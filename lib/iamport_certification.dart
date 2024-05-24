import 'dart:convert';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:iamport_webview_flutter/iamport_webview_flutter.dart';

import 'package:iamport_flutter/model/certification_data.dart';
import 'package:iamport_flutter/model/iamport_validation.dart';
import 'package:iamport_flutter/model/url_data.dart';
import 'package:iamport_flutter/widget/iamport_error.dart';
import 'package:iamport_flutter/widget/iamport_webview.dart';

class IamportCertification extends StatelessWidget {
  const IamportCertification({
    super.key,
    this.appBar,
    this.initialChild,
    required this.userCode,
    required this.data,
    required this.callback,
    this.gestureRecognizers,
    this.customUserAgent,
  });

  final PreferredSizeWidget? appBar;
  final Widget? initialChild;
  final String userCode;
  final CertificationData data;
  final void Function(Map<String, String>) callback;
  final Set<Factory<OneSequenceGestureRecognizer>>? gestureRecognizers;
  final String? customUserAgent;

  @override
  Widget build(BuildContext context) {
    var redirectUrl = UrlData.redirectUrl;
    if (data.mRedirectUrl != null && data.mRedirectUrl!.isNotEmpty) {
      redirectUrl = data.mRedirectUrl!;
    }

    final validation = IamportValidation.fromCertificationData(data);
    if (validation.getIsValid()) {
      return IamportWebView(
        type: ActionType.auth,
        appBar: appBar,
        initialChild: initialChild,
        gestureRecognizers: gestureRecognizers,
        customUserAgent: customUserAgent,
        executeJS: (WebViewController controller) async {
          await controller.evaluateJavascript('''
            IMP.init("$userCode");
            IMP.certification(${jsonEncode(data.toJson())}, function(response) {
              const query = [];
              Object.keys(response).forEach(function(key) {
                query.push(key + "=" + response[key]);
              });
              location.href = "$redirectUrl" + "?" + query.join("&");
            });
          ''');
        },
        useQueryData: callback,
        isPaymentOver: (String url) {
          return url.startsWith(redirectUrl);
        },
        // 인증에는 customPGAction 수행할 필요 없음
        customPGAction: (WebViewController controller) {
          return;
        },
      );
    } else {
      return IamportError(ActionType.auth, validation.getErrorMessage());
    }
  }
}
