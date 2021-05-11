import 'dart:async';
import 'dart:core';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import './model/iamport_url.dart';
import './model/certification_data.dart';
import './widget/iamport_webview.dart';

String redirectUrl = IamportUrl.redirectUrl;

class IamportCertification extends StatefulWidget {
  final PreferredSizeWidget appBar;
  final Container initialChild;
  final String userCode;
  final CertificationData data;
  final callback;

  IamportCertification({
    Key key,
    this.appBar,
    this.initialChild,
    this.userCode,
    this.data,
    this.callback,
  }) : super(key: key);

  @override
  _IamportCertificationState createState() => _IamportCertificationState();
}

class _IamportCertificationState extends State<IamportCertification> {
  final webView = new FlutterWebviewPlugin();
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;

  @override
  void initState() {
    super.initState();

    _onUrlChanged = webView.onUrlChanged.listen((String url) async {
      if (mounted) {
        if (url.contains(redirectUrl)) {
          Uri parsedUrl = Uri.parse(url);
          Map<String, String> query = parsedUrl.queryParameters;
          await webView.close();
          widget.callback(query);
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
            IMP.certification($data, function(response) {
              const query = [];
              Object.keys(response).forEach(function(key) {
                query.push(key + "=" + response[key]);
              });
              location.href = "$redirectUrl" + "?" + query.join("&");
            });
          ''');
        }
        IamportUrl iamportUrl = new IamportUrl(url);
        bool isOpeningStore = (Platform.isIOS && type == WebViewState.shouldStart) || (Platform.isAndroid && type == WebViewState.abortLoad);
        if (isOpeningStore && iamportUrl.isAppLink()) {
          /* Android */
          await iamportUrl.launch();
        }
      }
    });
  }

  @override
  void dispose() {
    _onUrlChanged.cancel();
    _onStateChanged.cancel();

    webView.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IamportWebView('본인인증', widget.appBar, widget.initialChild);
  }
}
