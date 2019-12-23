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

    try {
      String appScheme = Uri.parse(url).scheme;
      this.appScheme = appScheme;
    } catch (Exception) {
      this.appScheme = splittedUrl[0];
    }
    this.appUrl = appScheme == 'itmss' ? 'https://$splittedUrl[1]' : url;
  }

  bool isAppLink() {
    return appScheme != 'http' &&
        appScheme != 'https' &&
        appScheme != 'about:blank' &&
        appScheme != 'data';
  }

  Future<String> getAppUrl() async {
    if (Platform.isIOS) {
      return this.appUrl;
    }

    String url = await _channel
        .invokeMethod('getAppUrl', <String, Object>{'url': this.url});
    List<String> splittedUrl = url.split('://');
    String convertedScheme = splittedUrl[0];
    if (convertedScheme == 'v3mobileplusweb') {
      /**
       * V3 일반결제 대비 코드
       * Uri.encodingFull 또는 Uri.encodingComponent로 URL을 인코딩 할 경우 해석 불가해
       * 피치못하게 콜론(:)을 강제로 인코딩 값 %3A로 변환
       */
      String encodedUrl = url.replaceAll(new RegExp(r':'), '%3A');
      List<String> splittedUrl = encodedUrl.split('$convertedScheme%3A//');
      String replacedData = splittedUrl[1];
      String replacedUrl = '$convertedScheme://$replacedData';

      return replacedUrl;
    }

    return url;
  }

  Future<String> getMarketUrl() async {
    if (Platform.isIOS) {
      switch (appScheme) {
        case 'kftc-bankpay': // 뱅크페이
          return 'https://itunes.apple.com/kr/app/id398456030';
        case 'ispmobile': // ISP/페이북
          return 'https://itunes.apple.com/kr/app/id369125087';
        case 'hdcardappcardansimclick': // 현대카드 앱카드
          return 'https://itunes.apple.com/kr/app/id702653088';
        case 'shinhan-sr-ansimclick': // 신한 앱카드
          return 'https://itunes.apple.com/app/id572462317';
        case 'kb-acp': // KB국민 앱카드
          return 'https://itunes.apple.com/kr/app/id695436326';
        case 'mpocket.online.ansimclick': // 삼성앱카드
          return 'https://itunes.apple.com/kr/app/id535125356';
        case 'lottesmartpay': // 롯데 모바일결제
          return 'https://itunes.apple.com/kr/app/id668497947';
        case 'lotteappcard': // 롯데 앱카드
          return 'https://itunes.apple.com/kr/app/id688047200';
        case 'cloudpay': // 하나1Q페이(앱카드)
          return 'https://itunes.apple.com/kr/app/id847268987';
        case 'citimobileapp': // 시티은행 앱카드
          return 'https://itunes.apple.com/kr/app/id1179759666';
        case 'payco': // 페이코
          return 'https://itunes.apple.com/kr/app/id924292102';
        case 'kakaotalk': // 카카오톡
          return 'https://itunes.apple.com/kr/app/id362057947';
        case 'lpayapp': // 롯데 L.pay
          return 'https://itunes.apple.com/kr/app/id1036098908';
        case 'wooripay': // 우리페이
          return 'https://itunes.apple.com/kr/app/id1201113419';
        case 'nhallonepayansimclick': // NH농협카드 올원페이(앱카드)
          return 'https://itunes.apple.com/kr/app/id1177889176';
        case 'hanawalletmembers': // 하나카드(하나멤버스 월렛)
          return 'https://itunes.apple.com/kr/app/id1038288833';
        case 'shinsegaeeasypayment': // 신세계 SSGPAY
          return 'https://itunes.apple.com/app/id666237916';
        default:
          return this.url;
      }
    }

    return await _channel
        .invokeMethod('getMarketUrl', <String, Object>{'url': this.url});
  }
}
