import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../model/iamport_url.dart';

enum IamportType { payment, certificate }

typedef CompleteChecker = bool Function(String url);

class IamportWebView extends StatefulWidget {
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
  static final String initialUrl =
      Uri.dataFromString(IamportWebView.html, mimeType: 'text/html').toString();

  final ValueSetter<WebViewController> onIamportInitialized;
  final ValueSetter<Map<String, String>> onIamportComplete;
  final ValueChanged<String> onPageStarted;
  final CompleteChecker isIamportComplete;

  final IamportType type;

  IamportWebView({
    @required this.type,
    @required this.onIamportInitialized,
    @required this.onIamportComplete,
    @required this.isIamportComplete,
    this.onPageStarted,
  })  : assert(type != null),
        assert(onIamportInitialized != null),
        assert(onIamportComplete != null),
        assert(isIamportComplete != null);

  @override
  _IamportWebViewState createState() => _IamportWebViewState();
}

class _IamportWebViewState extends State<IamportWebView> {
  WebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: IamportWebView.initialUrl,
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (controller) {
        this._webViewController = controller;
      },
      navigationDelegate: (request) async {
        if (widget.isIamportComplete(request.url)) {
          widget.onIamportComplete(_extractCompleteData(request.url));
          return NavigationDecision.prevent;
        }

        final iamportUrlUtil = IamportUrl(request.url);
        if (iamportUrlUtil.isAppLink()) {
          final appUrl = await iamportUrlUtil.getAppUrl();
          if (await canLaunch(appUrl)) {
            await launch(appUrl);
          } else {
            await launch(await iamportUrlUtil.getMarketUrl());
          }

          return NavigationDecision.prevent;
        }

        return NavigationDecision.navigate;
      },
      onPageStarted: (page) {
        widget?.onPageStarted(page);
      },
      onPageFinished: (page) {
        if (page.contains(IamportWebView.initialUrl)) {
          widget.onIamportInitialized(this._webViewController);
        }
      },
    );
  }

  Map<String, String> _extractCompleteData(String url) {
    return Uri.parse(url).queryParameters;
  }
}
