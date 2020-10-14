import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class IamportWebView extends StatelessWidget {
  static final Color primaryColor = Color(0xff344e81);
  static final String html = '''
    <html>
      <head>
        <meta http-equiv="content-type" content="text/html; charset=utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <script type="text/javascript" src="https://code.jquery.com/jquery-latest.min.js" ></script>
        <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.8.js"></script>
      </head>
      <body></body>
    </html>
  ''';

  final String type;
  final PreferredSizeWidget appBar;
  final Widget initialChild;
  IamportWebView(this.type, this.appBar, this.initialChild);

  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
      url: new Uri.dataFromString(html, mimeType: 'text/html').toString(),
      appBar: appBar ??
          new AppBar(
            title: new Text('아임포트 $type'),
            backgroundColor: primaryColor,
          ),
      hidden: true,
      initialChild: initialChild ??
          Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/iamport-logo.png'),
                  Container(
                    padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                    child:
                        Text('잠시만 기다려주세요...', style: TextStyle(fontSize: 20.0)),
                  ),
                ],
              ),
            ),
          ),
      invalidUrlRegex: Platform.isAndroid
          ? '^(?!https://|http://|about:blank|data:).+'
          : null,
    );
  }
}
