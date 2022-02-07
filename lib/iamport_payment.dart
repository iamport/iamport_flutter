import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iamport_flutter/model/iamport_validation.dart';
import 'package:iamport_flutter/model/payment_data.dart';
import 'package:iamport_flutter/model/url_data.dart';
import 'package:iamport_flutter/widget/iamport_error.dart';
import 'package:iamport_flutter/widget/iamport_webview.dart';
import 'package:iamport_webview_flutter/iamport_webview_flutter.dart';
import 'package:uni_links/uni_links.dart';

class IamportPayment extends StatelessWidget {
  final PreferredSizeWidget? appBar;

  /// 웹뷰 로딩 컴포넌트
  final Widget? initialChild;

  /// 가맹점 식별코드
  final String userCode;

  /// 결제 데이터
  final PaymentData data;

  /// 콜백 함수
  ///
  /// 콜백 함수는 필수입력 필드로, 결제/본인인증 완료 후 라우트 이동을 위해 아래와 같이 로직을 작성할
  /// 수 있습니다. 콜백 함수에 대한 자세한 설명은 [콜백 설정하기](https://github.com/iamport/iamport_flutter/blob/main/example/manuals/CALLBACK.md)를 참고하세요.
  final callback;

  IamportPayment({
    Key? key,
    this.appBar,
    this.initialChild,
    required this.userCode,
    required this.data,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IamportValidation validation =
        IamportValidation(this.userCode, this.data, this.callback);

    if (validation.getIsValid()) {
      var redirectUrl = UrlData.redirectUrl;
      if (this.data.mRedirectUrl != null &&
          this.data.mRedirectUrl!.isNotEmpty) {
        redirectUrl = this.data.mRedirectUrl!;
      }

      return IamportWebView(
        type: ActionType.payment,
        appBar: this.appBar,
        initialChild: this.initialChild,
        executeJS: (WebViewController controller) {
          controller.evaluateJavascript('''
            IMP.init("${this.userCode}");
            IMP.request_pay(${jsonEncode(this.data.toJson())}, function(response) {
              const query = [];
              Object.keys(response).forEach(function(key) {
                query.push(key + "=" + response[key]);
              });
              location.href = "$redirectUrl" + "?" + query.join("&");
            });
          ''');
        },
        customPGAction: (WebViewController controller) {
          if (this.data.pg == 'smilepay') {
            // webview_flutter에서 iOS는 쿠키가 기본적으로 허용되어있는 것으로 추정
            if (Platform.isAndroid) {
              controller.setAcceptThirdPartyCookies(true);
            }
          }
          /* [v0.9.6] niceMobileV2: true 대비 코드 작성 */
          if (this.data.pg == 'nice' && this.data.payMethod == 'trans') {
            try {
              StreamSubscription sub = linkStream.listen((String? link) async {
                if (link != null) {
                  String decodedUrl = Uri.decodeComponent(link);
                  Uri parsedUrl = Uri.parse(decodedUrl);
                  String scheme = parsedUrl.scheme;
                  if (scheme == data.appScheme.toLowerCase()) {
                    String queryToString = parsedUrl.query;
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
            } on FormatException {}
          }
          return null;
        },
        useQueryData: (Map<String, String> data) {
          this.callback(data);
        },
        isPaymentOver: (String url) {
          if (url.startsWith(redirectUrl)) {
            return true;
          }

          if (this.data.payMethod == 'trans') {
            /* [IOS] imp_uid와 merchant_uid값만 전달되기 때문에 결제 성공 또는 실패 구분할 수 없음 */
            String decodedUrl = Uri.decodeComponent(url);
            Uri parsedUrl = Uri.parse(decodedUrl);
            String scheme = parsedUrl.scheme;
            if (this.data.pg == 'html5_inicis') {
              Map<String, String> query = parsedUrl.queryParameters;
              if (query['m_redirect_url'] != null &&
                  scheme == this.data.appScheme.toLowerCase()) {
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
