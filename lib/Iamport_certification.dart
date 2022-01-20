import 'dart:convert';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iamport_flutter/model/certification_data.dart';
import 'package:iamport_flutter/model/iamport_validation.dart';
import 'package:iamport_flutter/model/url_data.dart';
import 'package:iamport_flutter/widget/iamport_error.dart';
import 'package:iamport_flutter/widget/iamport_webview.dart';
import 'package:iamport_webview_flutter/iamport_webview_flutter.dart';

class IamportCertification extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? initialChild;
  final String userCode;
  final CertificationData data;
  final callback;

  IamportCertification({
    Key? key,
    this.appBar,
    this.initialChild,
    required this.userCode,
    required this.data,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var redirectUrl = UrlData.redirectUrl;
    if (this.data.mRedirectUrl != null && this.data.mRedirectUrl!.isNotEmpty) {
      redirectUrl = this.data.mRedirectUrl!;
    }

    IamportValidation validation =
        IamportValidation.fromCertificationData(userCode, data, callback);
    if (validation.getIsValid()) {
      return IamportWebView(
        type: ActionType.auth,
        appBar: this.appBar,
        initialChild: this.initialChild,
        executeJS: (WebViewController controller) {
          controller.evaluateJavascript('''
            IMP.init("${this.userCode}");
            IMP.certification(${jsonEncode(this.data.toJson())}, function(response) {
              const query = [];
              Object.keys(response).forEach(function(key) {
                query.push(key + "=" + response[key]);
              });
              location.href = "$redirectUrl" + "?" + query.join("&");
            });
          ''');
        },
        useQueryData: (Map<String, String> data) {
          this.callback(data);
        },
        isPaymentOver: (String url) {
          return url.startsWith(redirectUrl);
        },
        // 인증에는 customPGAction 수행할 필요 없음
        customPGAction: (WebViewController controller) {},
      );
    } else {
      return IamportError(ActionType.auth, validation.getErrorMessage());
    }
  }
}
