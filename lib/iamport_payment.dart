import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

import './widget/iamport_error.dart';
import './widget/iamport_webview.dart';
import './model/iamport_url.dart';
import './model/iamport_validation.dart';
import './model/payment_data.dart';

String redirectUrl = IamportUrl.redirectUrl;

class IamportPayment extends StatefulWidget {
  final PreferredSizeWidget appBar;
  final Container initialChild;
  final String userCode;
  final PaymentData data;
  final Function callback;

  IamportPayment({
    Key key,
    this.appBar,
    this.initialChild,
    this.userCode,
    this.data,
    this.callback,
  }) : super(key: key);

  @override
  _IamportPaymentState createState() => _IamportPaymentState();
}

class _IamportPaymentState extends State<IamportPayment> {
  final webView = new FlutterWebviewPlugin();
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  StreamSubscription _sub;

  @override
  void initState() {
    super.initState();
    _onUrlChanged = webView.onUrlChanged.listen((String url) async {
      if (mounted) {
        if (isPaymentOver(url)) {
          String decodedUrl = Uri.decodeComponent(url);
          Uri parsedUrl = Uri.parse(decodedUrl);
          Map<String, String> query = parsedUrl.queryParameters;
          await webView.close();
          widget.callback(query);
        }

        IamportUrl iamportUrl = new IamportUrl(url);
        if (iamportUrl.isAppLink()) {
          /* IOS */
          if (await canLaunch(url)) {
            // 3rd parth 앱 오픈
            await launch(await iamportUrl.getAppUrl());
          } else {
            // 앱 미설치시 마켓 URL로 연결
            await launch(await iamportUrl.getMarketUrl());
          }
        }
      }
    });

    _onStateChanged =
        webView.onStateChanged.listen((WebViewStateChanged state) async {
      if (mounted) {
        WebViewState type = state.type;
        String url = state.url;
        if (type == WebViewState.finishLoad) {
          String userCode = widget.userCode;
          String data = widget.data.toJsonString();
          webView.evalJavascript('''
            IMP.init("$userCode");
            IMP.request_pay($data, function(response) {
              const query = [];
              Object.keys(response).forEach(function(key) {
                query.push(key + "=" + response[key]);
              });
              location.href = "$redirectUrl" + "?" + query.join("&");
            });
          ''');
        }
        IamportUrl iamportUrl = new IamportUrl(url);
        if (type == WebViewState.abortLoad && iamportUrl.isAppLink()) {
          /* Android */
          await iamportUrl.launch();
        }
      }
    });

    /* NICE - 실시간 계좌이체 대비 : trigger incoming app link */
    _sub = getLinksStream().listen((String link) async {
      if (!mounted) return;
      try {
        PaymentData data = widget.data;
        if (link != null) {
          String decodedUrl = Uri.decodeComponent(link);
          Uri parsedUrl = Uri.parse(decodedUrl);
          String scheme = parsedUrl.scheme;
          if (scheme == data.appScheme.toLowerCase() &&
              data.pg == 'nice' &&
              data.payMethod == 'trans') {
            String queryToString = parsedUrl.query;

            /* [v0.9.6] niceMobileV2: true 대비 코드 작성 */
            String niceTransRedirectionUrl;
            parsedUrl.queryParameters.forEach((key, value) {
              if (key == 'callbackparam1') {
                niceTransRedirectionUrl = value;
              }
            });
            await webView.evalJavascript(''' 
              location.href = "$niceTransRedirectionUrl?$queryToString";
            ''');
          }
        }
      } on FormatException {}
    });
  }

  @override
  void dispose() {
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    if (_sub != null) _sub.cancel();

    webView.dispose();
    super.dispose();
  }

  bool isPaymentOver(String url) {
    PaymentData data = widget.data;
    if (url.contains(redirectUrl)) {
      return true;
    }

    if (data.payMethod == 'trans') {
      /* [IOS] imp_uid와 merchant_uid값만 전달되기 때문에 결제 성공 또는 실패 구분할 수 없음 */
      String decodedUrl = Uri.decodeComponent(url);
      Uri parsedUrl = Uri.parse(decodedUrl);
      String scheme = parsedUrl.scheme;
      if (data.pg == 'html5_inicis') {
        Map<String, String> query = parsedUrl.queryParameters;
        if (scheme == data.appScheme.toLowerCase() &&
            query['m_redirect_url'].contains(redirectUrl)) {
          return true;
        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    IamportValidation validation =
        IamportValidation(widget.userCode, widget.data, widget.callback);
    bool isValid = validation.getIsValid();

    if (isValid) {
      return IamportWebView('결제', widget.appBar, widget.initialChild);
    }

    String errorMessage = validation.getErrorMessage();
    return IamportError('결제', errorMessage);
  }
}
