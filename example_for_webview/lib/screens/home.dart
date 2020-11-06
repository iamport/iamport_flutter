import 'dart:io' show Platform;
import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:iamport_flutter/model/payment_data.dart';
import 'package:iamport_flutter/model/certification_data.dart';

import '../model/iamport_data.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final webView = new FlutterWebviewPlugin();
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  StreamSubscription _sub;
  Set<JavascriptChannel> jsChannels;

  @override
  void initState() {
    super.initState();

    _onStateChanged =
        webView.onStateChanged.listen((WebViewStateChanged state) async {
      if (mounted) {
        WebViewState type = state.type;
        if (type == WebViewState.finishLoad) {
          webView.evalJavascript('''
            window.addEventListener("message", receiveMessage, false);
            function receiveMessage(event) {
              Flutter.postMessage(event.data);
            }
          ''');
        }
      }
    });

    jsChannels = [
      JavascriptChannel(
          name: 'Flutter',
          onMessageReceived: (JavascriptMessage message) {
            IamportData iamportData =
                IamportData.fromJson(jsonDecode(message.message));

            String userCode = iamportData.userCode;
            String data = iamportData.data;
            String type = iamportData.type;
            if (type == 'payment') {
              PaymentData paymentData = PaymentData.fromJson(jsonDecode(data));
              Navigator.pushNamed(context, '/payment', arguments: paymentData);
            } else {
              CertificationData certificationData =
                  CertificationData.fromJson(jsonDecode(data));
              Navigator.pushNamed(context, '/certification',
                  arguments: certificationData);
            }
          }),
    ].toSet();
  }

  @override
  void dispose() {
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    if (_sub != null) _sub.cancel();

    webView.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
      url: 'http://192.168.0.3:3000',
      hidden: true,
      invalidUrlRegex: Platform.isAndroid
          ? '^(?!https://|http://|about:blank|data:).+'
          : null,
      javascriptChannels: jsChannels,
    );
  }
}
