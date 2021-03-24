import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import './model/certification_data.dart';
import './model/iamport_url.dart';
import './widget/iamport_webview.dart';
import 'widget/iamport_webview.dart';

String redirectUrl = IamportUrl.redirectUrl;

class IamportCertification extends StatelessWidget {
  final String userCode;
  final CertificationData data;
  final callback;

  IamportCertification({
    Key key,
    this.userCode,
    this.data,
    this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IamportWebView(
      type: IamportType.certificate,
      onIamportInitialized: (WebViewController controller) {
        String userCode = this.userCode;
        String data = this.data.toJsonString();
        controller.evaluateJavascript('''
            IMP.init("$userCode");
            IMP.certification($data, function(response) {
              const query = [];
              Object.keys(response).forEach(function(key) {
                query.push(key + "=" + response[key]);
              });
              location.href = "$redirectUrl" + "?" + query.join("&");
            });
          ''');
      },
      isIamportComplete: (url) {
        return url.startsWith(IamportUrl.redirectUrl);
      },
      onIamportComplete: (Map<String, String> data) {
        this.callback(data);
      },
    );
  }
}
