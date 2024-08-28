import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:iamport_webview_flutter/iamport_webview_flutter.dart';

import 'package:iamport_flutter/model/iamport_url.dart';

enum ActionType { auth, payment }

class IamportWebView extends StatefulWidget {
  const IamportWebView({
    super.key,
    required this.type,
    this.appBar,
    this.initialChild,
    required this.executeJS,
    required this.useQueryData,
    required this.isPaymentOver,
    required this.customPGAction,
    this.gestureRecognizers,
    this.customUserAgent,
  });

  static const Color primaryColor = Color(0xff344e81);
  static const String html = '''
    <html>
      <head>
        <meta http-equiv="content-type" content="text/html; charset=utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">

        <script type="text/javascript" src="https://cdn.iamport.kr/v1/iamport.js"></script>
      </head>
      <body></body>
    </html>
  ''';

  final ActionType type;
  final PreferredSizeWidget? appBar;
  final Widget? initialChild;
  final ValueSetter<WebViewController> executeJS;
  final ValueSetter<Map<String, String>> useQueryData;
  final bool Function(String url) isPaymentOver;
  final dynamic Function(WebViewController controller) customPGAction;
  final Set<Factory<OneSequenceGestureRecognizer>>? gestureRecognizers;
  final String? customUserAgent;

  @override
  State<IamportWebView> createState() => _IamportWebViewState();
}

class _IamportWebViewState extends State<IamportWebView> {
  late WebViewController _webViewController;
  StreamSubscription? _sub;
  late int _isWebviewLoaded;
  late int _isImpLoaded;

  @override
  void initState() {
    super.initState();
    _isWebviewLoaded = 0;
    _isImpLoaded = 0;
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    if (widget.initialChild != null) {
      _isWebviewLoaded++;
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (_sub != null) {
      // ignore: discarded_futures
      _sub!.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      body: SafeArea(
        child: IndexedStack(
          index: _isWebviewLoaded,
          children: [
            WebView(
              initialUrl:
                  Uri.dataFromString(IamportWebView.html, mimeType: 'text/html')
                      .toString(),
              javascriptMode: JavascriptMode.unrestricted,
              gestureRecognizers: widget.gestureRecognizers,
              userAgent: widget.customUserAgent,
              onWebViewCreated: (WebViewController controller) {
                _webViewController = controller;
                if (widget.type == ActionType.payment) {
                  // 스마일페이, 나이스 실시간 계좌이체
                  _sub = widget.customPGAction(_webViewController)
                      as StreamSubscription;
                }
              },
              onPageFinished: (String url) {
                // 웹뷰 로딩 완료시에 화면 전환
                if (_isWebviewLoaded == 1) {
                  setState(() {
                    _isWebviewLoaded = 0;
                  });
                }
                // 페이지 로딩 완료시 IMP 코드 실행
                if (_isImpLoaded == 0) {
                  widget.executeJS(_webViewController);
                  _isImpLoaded++;
                }
              },
              navigationDelegate: (request) async {
                // print("url: " + request.url);
                if (widget.isPaymentOver(request.url)) {
                  final decodedUrl = Uri.decodeComponent(request.url);
                  widget.useQueryData(Uri.parse(decodedUrl).queryParameters);

                  return NavigationDecision.prevent;
                }

                final iamportUrl = IamportUrl(request.url);
                if (iamportUrl.isAppLink()) {
                  // print("appLink: " + iamportUrl.appUrl!);
                  // 앱 실행 로직을 iamport_url 모듈로 이동
                  await iamportUrl.launchApp();
                  return NavigationDecision.prevent;
                }

                return NavigationDecision.navigate;
              },
            ),
            if (_isWebviewLoaded == 1) widget.initialChild!,
          ],
        ),
      ),
    );
  }
}
