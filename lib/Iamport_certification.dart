import 'dart:core';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iamport_webview_flutter/iamport_webview_flutter.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';
import './model/certification_data.dart';
import './widget/iamport_webview.dart';
import './model/url_data.dart';

class IamportCertification extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Container? initialChild;
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
    return IamportWebView(
      type: ActionType.auth,
      appBar: this.appBar,
      initialChild: this.initialChild,
      executeJS: (WebViewController controller) {
        controller.evaluateJavascript('''
            IMP.init("${this.userCode}");
            IMP.certification(${JsonMapper.serialize(this.data)}, function(response) {
              const query = [];
              Object.keys(response).forEach(function(key) {
                query.push(key + "=" + response[key]);
              });
              location.href = "${UrlData.redirectUrl}" + "?" + query.join("&");
            });
          ''');
      },
      useQueryData: (Map<String, String> data) {
        this.callback(data);
      },
      isPaymentOver: (String url) {
        return url.startsWith(UrlData.redirectUrl);
      },
      // 인증에는 customPGAction 수행할 필요 없음
      customPGAction: (WebViewController controller) {},
    );
  }
}
