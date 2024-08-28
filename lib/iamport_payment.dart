import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:app_links/app_links.dart';
import 'package:iamport_webview_flutter/iamport_webview_flutter.dart';

import 'package:iamport_flutter/model/iamport_validation.dart';
import 'package:iamport_flutter/model/payment_data.dart';
import 'package:iamport_flutter/model/url_data.dart';
import 'package:iamport_flutter/widget/iamport_error.dart';
import 'package:iamport_flutter/widget/iamport_webview.dart';

class IamportPayment extends StatelessWidget {
  const IamportPayment({
    super.key,
    this.appBar,
    this.initialChild,
    required this.userCode,
    required this.data,
    required this.callback,
    this.gestureRecognizers,
  });

  final PreferredSizeWidget? appBar;
  final Widget? initialChild;
  final String userCode;
  final PaymentData data;
  final ValueChanged<Map<String, String>> callback;
  final Set<Factory<OneSequenceGestureRecognizer>>? gestureRecognizers;

  AppLinks get _appLinks => AppLinks();

  @override
  Widget build(BuildContext context) {
    final validation = IamportValidation(userCode, data, callback);

    if (validation.getIsValid()) {
      var redirectUrl = UrlData.redirectUrl;
      if (data.mRedirectUrl != null && data.mRedirectUrl!.isNotEmpty) {
        redirectUrl = data.mRedirectUrl!;
      }

      return IamportWebView(
        type: ActionType.payment,
        appBar: appBar,
        initialChild: initialChild,
        gestureRecognizers: gestureRecognizers,
        executeJS: (WebViewController controller) async {
          await controller.evaluateJavascript('''
            IMP.init("$userCode");
            IMP.request_pay(${jsonEncode(data.toJson())}, function(response) {
              const query = [];
              Object.keys(response).forEach(function(key) {
                query.push(key + "=" + response[key]);
              });
              location.href = "$redirectUrl" + "?" + query.join("&");
            });
          ''');
        },
        customPGAction: (WebViewController controller) async {
          if (data.pg == 'smilepay') {
            // webview_flutter에서 iOS는 쿠키가 기본적으로 허용되어있는 것으로 추정
            if (Platform.isAndroid) {
              await controller.setAcceptThirdPartyCookies(true);
            }
          }
          /* [v0.9.6] niceMobileV2: true 대비 코드 작성 */
          if (data.pg == 'nice' && data.payMethod == 'trans') {
            try {
              final StreamSubscription sub =
                  _appLinks.uriLinkStream.listen((Uri? link) async {
                if (link != null) {
                  final decodedUrl = Uri.decodeComponent(link.toString());
                  final parsedUrl = Uri.parse(decodedUrl);
                  final scheme = parsedUrl.scheme;
                  if (scheme == data.appScheme.toLowerCase()) {
                    final queryToString = parsedUrl.query;
                    String? niceTransRedirectionUrl;
                    parsedUrl.queryParameters.forEach((key, value) {
                      if (key == 'callbackparam1') {
                        niceTransRedirectionUrl = value;
                      }
                    });

                    await controller.evaluateJavascript('''
                    location.href = "$niceTransRedirectionUrl?$queryToString";
                  ''');
                  }
                }
              });

              return sub;
            } on FormatException {
              return null;
            }
          }
          return null;
        },
        useQueryData: callback,
        isPaymentOver: (String url) {
          if (url.startsWith(redirectUrl)) {
            return true;
          }

          if (data.payMethod == 'trans') {
            /* [IOS] imp_uid와 merchant_uid값만 전달되기 때문에 결제 성공 또는 실패 구분할 수 없음 */
            final decodedUrl = Uri.decodeComponent(url);
            final parsedUrl = Uri.parse(decodedUrl);
            final scheme = parsedUrl.scheme;
            if (data.pg == 'html5_inicis') {
              final query = parsedUrl.queryParameters;
              if (query['m_redirect_url'] != null &&
                  scheme == data.appScheme.toLowerCase()) {
                if (query['m_redirect_url']!.contains(redirectUrl)) {
                  return true;
                }
              }
            }
          }

          return false;
        },
      );
    } else {
      return IamportError(ActionType.payment, validation.getErrorMessage());
    }
  }
}
