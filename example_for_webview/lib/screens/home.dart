import 'dart:io' show Platform;
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final webView = new FlutterWebviewPlugin();
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  StreamSubscription _sub;

  final Set<JavascriptChannel> jsChannels = [
    JavascriptChannel(
      name: 'Flutter',
      onMessageReceived: (JavascriptMessage message) {
        print('message.message: ${message.message}');
      }),
  ].toSet();

  @override
  void initState() {
    super.initState();

    // _onStateChanged =
    //     webView.onStateChanged.listen((WebViewStateChanged state) async {
    //   if (mounted) {
    //     WebViewState type = state.type;
    //     if (type == WebViewState.finishLoad) {
    //       webView.evalJavascript('''
    //         window.addEventListener("message", receiveMessage, false);
    //         function receiveMessage(event) {
    //           Flutter.postMessage(event.data);
    //         }
    //       ''');
    //     }
    //   }
    // });
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
      url: 'http://172.16.200.35:3000',
      hidden: true,
      invalidUrlRegex: Platform.isAndroid
        ? '^(?!https://|http://|about:blank|data:).+'
        : null,
      javascriptChannels: jsChannels,
    );
  }
}
