import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';
import 'package:webview_flutter/webview_flutter.dart';

import './model/iamport_url.dart';
import './model/iamport_validation.dart';
import './model/payment_data.dart';
import './widget/iamport_error.dart';
import './widget/iamport_webview.dart';
import 'model/iamport_url.dart';

class IamportPayment extends StatefulWidget {
  final String userCode;
  final PaymentData data;
  final Function callback;
  final IamportValidation _iamportValidation;

  IamportPayment({
    Key key,
    this.userCode,
    this.data,
    this.callback,
  })  : _iamportValidation = IamportValidation(userCode, data, callback),
        super(key: key);

  @override
  _IamportPaymentState createState() => _IamportPaymentState();
}

class _IamportPaymentState extends State<IamportPayment> {
  StreamSubscription _linkStreamSubscription;
  WebViewController _webViewController;

  @override
  void initState() {
    super.initState();

    // NICE - 실시간 계좌이체 대비 : trigger incoming app link
    _listenListStream();
  }

  @override
  void dispose() {
    _linkStreamSubscription?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        if (widget._iamportValidation.getIsValid())
          IamportWebView(
            type: IamportType.payment,
            onIamportInitialized: (controller) {
              _webViewController = controller;
              controller.evaluateJavascript('''
                  IMP.init("${widget.userCode}");
                  IMP.request_pay(${widget.data.toJsonString()}, function(response) {
                    const query = [];
                    Object.keys(response).forEach(function(key) {
                      query.push(key + "=" + response[key]);
                    });
                    location.href = "${IamportUrl.redirectUrl}" + "?" + query.join("&");
                  });
                ''');
            },
            isIamportComplete: (url) => _isPaymentOver(url),
            onIamportComplete: (data) => widget.callback(data),
          ),
        if (!widget._iamportValidation.getIsValid())
          IamportError('결제', widget._iamportValidation.errorMessage),
      ],
    );
  }

  bool _isPaymentOver(String url) {
    PaymentData data = widget.data;
    if (url.startsWith(IamportUrl.redirectUrl)) return true;

    // [IOS] imp_uid와 merchant_uid값만 전달되기 때문에 결제 성공 또는 실패 구분할 수 없음
    if (data.payMethod == 'trans') {
      String decodedUrl = Uri.decodeComponent(url);
      Uri parsedUrl = Uri.parse(decodedUrl);
      String scheme = parsedUrl.scheme;
      if (data.pg == 'html5_inicis') {
        Map<String, String> query = parsedUrl.queryParameters;
        if (scheme == data.appScheme.toLowerCase() &&
            query['m_redirect_url'].contains(IamportUrl.redirectUrl)) {
          return true;
        }
      }
    }

    return false;
  }

  void _listenListStream() {
    _linkStreamSubscription = getLinksStream().listen((String link) async {
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
            await _webViewController.evaluateJavascript('''
              location.href = "$niceTransRedirectionUrl?$queryToString";
            ''');
          }
        }
      } on FormatException {}
    });
  }
}
