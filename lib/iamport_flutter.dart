import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';

import './model/payment_data.dart';
import './model/certification_data.dart';
import './model/title_options.dart';

class IamportFlutter {
  Function callback;
  Map<String, dynamic> webViewData = {};

  static const MethodChannel _channel = const MethodChannel('iamport_flutter');
  static const String redirectUrl = 'http://localhost/iamport';
  static const String triggerCallback = '''
    function(response) {
      var query = [];
      Object.keys(response).forEach(function(key) {
        query.push(key + '=' + decodeURIComponent(response[key]));
      });
      location.href = '$redirectUrl?' + query.join('&');
    }
  ''';

  IamportFlutter(String userCode, data, TitleOptions titleOptions, Function callbackFunc) {
    webViewData['type'] = getType(data);
    webViewData['titleOptions'] = titleOptions.toJson();

    Map<String, String> params = {
      'userCode': userCode,
      'data': data.toJsonString(),
      'redirectUrl': redirectUrl,
      'triggerCallback': triggerCallback.replaceAll(new RegExp(r'\n||\t'), '').trim(),
    };
    webViewData['params'] = params;

    callback = callbackFunc;
  }

  void payment() async {
    String url = await _channel.invokeMethod('launch', webViewData);
    if (url.contains(redirectUrl)) {
      String decodedUrl = Uri.decodeComponent(url);
      Uri parsedUrl = Uri.parse(decodedUrl);
      Map<String, String> query = parsedUrl.queryParameters;
      callback(query);
    }
  }

  void certification() async {
    String url = await _channel.invokeMethod('launch', webViewData);
    if (url.contains(redirectUrl)) {
      String decodedUrl = Uri.decodeComponent(url);
      Uri parsedUrl = Uri.parse(decodedUrl);
      Map<String, String> query = parsedUrl.queryParameters;
      callback(query);
    }
  }

  String getType(data) {
    if (data is PaymentData) {
      String payMethod = data.payMethod;
      String pg = data.pg;
      if (payMethod == 'trans') {
        if (pg.startsWith('html5_inicis')) {
          return 'inicis';
        }
        if (pg.startsWith('nice')) {
          return 'nice';
        }
      }
      return 'payment';
    }
    return 'certification';
  }

  // static Future<String> get platformVersion async {
  //   final String version = await _channel.invokeMethod('getPlatformVersion');
  //   return version;
  // }
}
