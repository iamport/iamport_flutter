import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// import 'package:flutter_webview_plugin/src/javascript_channel.dart';
// import 'package:flutter_webview_plugin/src/base.dart';

class IamportWebView extends StatefulWidget {
  const IamportWebView({
    Key key,
    this.title,
    this.type,
    this.appBar,
    this.initialChild,
    this.userCode,
    this.data,
  }) : super(key: key);

  final String title;
  final String type;
  final PreferredSizeWidget appBar;
  final Widget initialChild;
  final String userCode;
  final String data;

  @override
  _IamportWebViewState createState() => _IamportWebViewState();
}

class _IamportWebViewState extends State<IamportWebView> {
  static const MethodChannel _channel = const MethodChannel('iamport_flutter');
  static final Color primaryColor = Color(0xff344e81);
  // final webviewReference = FlutterWebviewPlugin();
  Rect _rect;
  Timer _resizeTimer;

  // var _onBack;

  @override
  void initState() {
    super.initState();
    // webviewReference.close();

    // _onBack = webviewReference.onBack.listen((_) async {
    //   if (!mounted) {
    //     return;
    //   }

    //   // The willPop/pop pair here is equivalent to Navigator.maybePop(),
    //   // which is what's called from the flutter back button handler.
    //   final pop = await _topMostRoute.willPop();
    //   if (pop == RoutePopDisposition.pop) {
    //     // Close the webview if it's on the route at the top of the stack.
    //     final isOnTopMostRoute = _topMostRoute == ModalRoute.of(context);
    //     if (isOnTopMostRoute) {
          // webviewReference.close();
    //     }
    //     Navigator.pop(context);
    //   }
    // });
  }

  /// Equivalent to [Navigator.of(context)._history.last].
  // Route<dynamic> get _topMostRoute {
  //   var topMost;
  //   Navigator.popUntil(context, (route) {
  //     topMost = route;
  //     return true;
  //   });
  //   return topMost;
  // }

  @override
  void dispose() {
    super.dispose();
    // _onBack?.cancel();
    _resizeTimer?.cancel();
    // webviewReference.close();
    // webviewReference.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar ??
        new AppBar(
          title: new Text('아임포트 $widget.title'),
          backgroundColor: primaryColor,
        ),
      body: _WebviewPlaceholder(
        onRectChanged: (Rect value) async {
          if (_rect == null) {
            _rect = value;

            Map<String, String> params = {
              'userCode': widget.userCode,
              'data': widget.data,
            };

            Map<String, dynamic> webViewData = {
              'type': widget.type,
              'params': jsonEncode(params),
              'rect': {
                'left': _rect.left,
                'top': _rect.top,
                'width': _rect.width,
                'height': _rect.height,
              },
            };
            await _channel.invokeMethod('launch', webViewData);
          } else {
            // if (_rect != value) {
            //   _rect = value;
            //   _resizeTimer?.cancel();
            //   _resizeTimer = Timer(const Duration(milliseconds: 250), () async {
            //     // avoid resizing to fast when build is called multiple time
            //     // webviewReference.resize(_rect);
            //     await _channel.invokeMethod('resize', _rect);
            //   });
            // }
          }
        },
        child: widget.initialChild ??
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
      ),
    );
  }
}

class _WebviewPlaceholder extends SingleChildRenderObjectWidget {
  const _WebviewPlaceholder({
    Key key,
    @required this.onRectChanged,
    Widget child,
  }) : super(key: key, child: child);

  final ValueChanged<Rect> onRectChanged;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _WebviewPlaceholderRender(
      onRectChanged: onRectChanged,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, _WebviewPlaceholderRender renderObject) {
    renderObject..onRectChanged = onRectChanged;
  }
}

class _WebviewPlaceholderRender extends RenderProxyBox {
  _WebviewPlaceholderRender({
    RenderBox child,
    ValueChanged<Rect> onRectChanged,
  })  : _callback = onRectChanged,
        super(child);

  ValueChanged<Rect> _callback;
  Rect _rect;

  Rect get rect => _rect;

  set onRectChanged(ValueChanged<Rect> callback) {
    if (callback != _callback) {
      _callback = callback;
      notifyRect();
    }
  }

  void notifyRect() {
    if (_callback != null && _rect != null) {
      _callback(_rect);
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    super.paint(context, offset);
    final rect = offset & size;
    if (_rect != rect) {
      _rect = rect;
      notifyRect();
    }
  }
}
///////////////////////////////////////////////////////////////////////////////////////////////////

// import 'dart:io' show Platform;

// import 'package:flutter/material.dart';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

// class IamportWebView extends StatelessWidget {
//   static final Color primaryColor = Color(0xff344e81);
//   static final String html = '''
//     <html>
//       <head>
//         <meta http-equiv="content-type" content="text/html; charset=utf-8">
//         <meta name="viewport" content="width=device-width, initial-scale=1.0">

//         <script type="text/javascript" src="https://code.jquery.com/jquery-latest.min.js" ></script>
//         <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.7.js"></script>
//       </head>
//       <body></body>
//     </html>
//   ''';

//   final String type;
//   final PreferredSizeWidget appBar;
//   final Widget initialChild;
//   IamportWebView(this.type, this.appBar, this.initialChild);

//   @override
//   Widget build(BuildContext context) {
//     return new WebviewScaffold(
//       url: new Uri.dataFromString(html, mimeType: 'text/html').toString(),
//       appBar: appBar ??
//           new AppBar(
//             title: new Text('아임포트 $type'),
//             backgroundColor: primaryColor,
//           ),
//       hidden: true,
//       initialChild: initialChild ??
//           Container(
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset('assets/images/iamport-logo.png'),
//                   Container(
//                     padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
//                     child:
//                         Text('잠시만 기다려주세요...', style: TextStyle(fontSize: 20.0)),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//       invalidUrlRegex: Platform.isAndroid
//           ? '^(?!https://|http://|about:blank|data:).+'
//           : null,
//     );
//   }
// }
