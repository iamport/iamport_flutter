import 'dart:io' show Platform;

import 'package:flutter/services.dart';

class IamportUrl {
  String url;
  String appScheme;
  String appUrl;

  static const MethodChannel _channel = const MethodChannel('iamport_flutter');
  static String redirectUrl = 'http://localhost/iamport';

  IamportUrl(String url) {
    this.url = url;

    List<String> splittedUrl = url.split('://');
    String appScheme = Uri.parse(url).scheme;
    this.appScheme = appScheme;
    this.appUrl = appScheme == 'itmss' ? 'https://$splittedUrl[1]' :  url;
  }

  bool isAppLink() {
    return appScheme != 'http' && appScheme != 'https' && appScheme != 'about:blank' && appScheme != 'data';
  }

  Future<String> getAppUrl() async {
    if (Platform.isIOS) {
      return appUrl;
    }

    return await _channel.invokeMethod('getAppUrl', <String, Object>{'url': this.url});
  }

  Future<String> getMarketUrl() async {
    if (Platform.isIOS) {
      switch (appScheme) {
        case 'shinhan-sr-ansimclick':                             // 신한 앱카드
          return 'https://itunes.apple.com/app/id572462317';
        case 'hdcardappcardansimclick':                           // 현대카드 앱카드
          return 'https://itunes.apple.com/kr/app/id702653088';
        case 'citimobileapp':                                     // 시티은행 앱카드
          return 'https://itunes.apple.com/kr/app/id1179759666';
        case 'shinsegaeeasypayment':                              // 신세계 SSGPAY
          return 'https://itunes.apple.com/app/id666237916';
        case 'lpayapp':                                           // 롯데 L.pay
          return 'https://itunes.apple.com/kr/app/id1036098908';
        case 'lottesmartpay':                                     // 롯데 모바일결제
          return 'https://itunes.apple.com/kr/app/id668497947';
        case 'kpay':                                              // Kpay
          return 'https://itunes.apple.com/app/id911636268';
        case 'ispmobile':                                         // ISP/페이북
          return 'https://itunes.apple.com/kr/app/id369125087';
        case 'kb-acp':                                            // KB국민 앱카드
          return 'https://itunes.apple.com/kr/app/id695436326';
        case 'mpocket.online.ansimclick':                         // 삼성앱카드
          return 'https://itunes.apple.com/kr/app/id535125356';
        case 'lotteappcard':                                      // 롯데 앱카드
          return 'https://itunes.apple.com/kr/app/id688047200';
        case 'nhallonepayansimclick':                             // NH농협카드 올원페이(앱카드)
          return 'https://itunes.apple.com/kr/app/id1177889176';
        case 'cloudpay':                                          // 하나1Q페이(앱카드)
          return 'https://itunes.apple.com/kr/app/id847268987';
        case 'lguthepay':                                         // 페이나우
          return 'https://itunes.apple.com/kr/app/id760098906';
        case 'kftc-bankpay':                                      // 뱅크페이
          return 'https://itunes.apple.com/kr/app/id398456030';
        case 'kakaotalk':                                         // 카카오페이
          return 'https://itunes.apple.com/kr/app/id362057947';
        default:
          return '';
      }
    }

    return await _channel.invokeMethod('getMarketUrl', <String, Object>{'url': this.url});
  }
}