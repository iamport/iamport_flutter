import 'dart:core';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iamport_webview_flutter/iamport_webview_flutter.dart';
import './model/iamport_url.dart';
import './model/certification_data.dart';
import './widget/iamport_webview.dart';

class IamportCertification extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Container? initialChild;
  final String? userCode;
  final CertificationData? data;
  final callback;

  IamportCertification({
    Key? key,
    this.appBar,
    this.initialChild,
    this.userCode,
    this.data,
    this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IamportWebView(
      type: ActionType.auth,
      appBar: this.appBar,
      initialChild: this.initialChild,
      executeJS: (WebViewController? controller) {
        controller?.evaluateJavascript('''
            IMP.init("${this.userCode}");
            IMP.certification(${this.data!.toJsonString()}, function(response) {
              const query = [];
              Object.keys(response).forEach(function(key) {
                query.push(key + "=" + response[key]);
              });
              location.href = "${IamportUrl.redirectUrl}" + "?" + query.join("&");
            });
          ''');
      },
      useQueryData: (Map<String, String> data) {
        this.callback(data);
      },
      isPaymentOver: (String url) {
        return url.startsWith(IamportUrl.redirectUrl);
      },
      customPGAction: (WebViewController? controller) {},
    );
  }
}
