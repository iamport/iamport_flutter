import 'dart:async';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

class IamportUrl {
  String? url;
  String? appScheme;
  String? appUrl;
  String? package; // Android only

  static const String redirectUrl = 'http://localhost/iamport';

  static const String ANDROID_MARKET_PREFIX = 'market://details?id=';
  static const String IOS_MARKET_PREFIX = 'https://itunes.apple.com/app/';

  static const String ISP = 'ispmobile';
  static const String BANKPAY = 'kftc-bankpay';
  static const String KB_BANKPAY = 'kb-bankpay';
  static const String NH_BANKPAY = 'nhb-bankpay';
  static const String MG_BANKPAY = 'mg-bankpay';
  static const String KN_BANKPAY = 'kn-bankpay';

  static const String PACKAGE_ISP = 'kvp.jjy.MispAndroid320';
  static const String PACKAGE_BANKPAY = 'com.kftc.bankpay.android';
  static const String PACKAGE_KB_BANKPAY = 'com.kbstar.liivbank';
  static const String PACKAGE_NH_BANKPAY = 'com.nh.cashcardapp';
  static const String PACKAGE_MG_BANKPAY = 'kr.co.kfcc.mobilebank';
  static const String PACKAGE_KN_BANKPAY = 'com.knb.psb';

  static const String SMILE_PAY_BASE_URL = "https://www.mysmilepay.com/";

  IamportUrl(String incomeUrl) {
    this.url = incomeUrl;

    List<String> splittedUrl =
        this.url!.replaceFirst(RegExp(r'://'), ' ').split(' ');
    this.appScheme = splittedUrl[0];

    if (Platform.isIOS) {
      this.appUrl =
          this.appScheme == 'itmss' ? 'https://${splittedUrl[1]}' : this.url;
    } else if (Platform.isAndroid) {
      /*
        Android scheme은 크게 3가지 형태
        1. intent://
        2. [app]://
        3. intent:[app]://
        이 세가지를 정상적으로 launch가 가능한 2번 형태로 변환한다
      */
      if (this.isAppLink()) {
        if (this.appScheme!.contains('intent')) {
          List<String> intentUrl = splittedUrl[1].split('#Intent;');
          String host = intentUrl[0];
          List<String> arguments = intentUrl[1].split(';');

          // scheme이 intent로 시작하면 뒷쪽의 정보를 통해 appscheme과 package 정보 추출
          if (this.appScheme! != 'intent') {
            // 현대카드 예외처리
            this.appScheme = this.appScheme!.split(':')[1];
            this.appUrl = this.appScheme! + '://' + host;
          }
          arguments.forEach((s) {
            if (s.startsWith('scheme')) {
              String scheme = s.split('=')[1];
              this.appUrl = scheme + '://' + host;
              this.appScheme = scheme;
            } else if (s.startsWith('package')) {
              String package = s.split('=')[1];
              this.package = package;
            }
          });
        } else {
          this.appUrl = this.url;
        }
      } else {
        this.appUrl = this.url;
      }
    }
  }

  bool isAppLink() {
    return !['http', 'https', 'about:blank', 'data', '']
        .contains(Uri.parse(this.url!).scheme);
  }

  Future<String?> getAppUrl() async {
    return this.appUrl;
  }

  Future<String?> getMarketUrl() async {
    if (Platform.isIOS) {
      switch (this.appScheme) {
        case 'kftc-bankpay': // 뱅크페이
          return IOS_MARKET_PREFIX + 'id398456030';
        case 'ispmobile': // ISP/페이북
          return IOS_MARKET_PREFIX + 'id369125087';
        case 'hdcardappcardansimclick': // 현대카드 앱카드
          return IOS_MARKET_PREFIX + 'id702653088';
        case 'shinhan-sr-ansimclick': // 신한 앱카드
          return IOS_MARKET_PREFIX + 'id572462317';
        case 'kb-acp': // KB국민 앱카드
          return IOS_MARKET_PREFIX + 'id695436326';
        case 'mpocket.online.ansimclick': // 삼성앱카드
          return IOS_MARKET_PREFIX + 'id535125356';
        case 'lottesmartpay': // 롯데 모바일결제
          return IOS_MARKET_PREFIX + 'id668497947';
        case 'lotteappcard': // 롯데 앱카드
          return IOS_MARKET_PREFIX + 'id688047200';
        case 'cloudpay': // 하나1Q페이(앱카드)
          return IOS_MARKET_PREFIX + 'id847268987';
        case 'citimobileapp': // 시티은행 앱카드
          return IOS_MARKET_PREFIX + 'id1179759666';
        case 'payco': // 페이코
          return IOS_MARKET_PREFIX + 'id924292102';
        case 'kakaotalk': // 카카오톡
          return IOS_MARKET_PREFIX + 'id362057947';
        case 'lpayapp': // 롯데 L.pay
          return IOS_MARKET_PREFIX + 'id1036098908';
        case 'wooripay': // 우리페이
          return IOS_MARKET_PREFIX + 'id1201113419';
        case 'nhallonepayansimclick': // NH농협카드 올원페이(앱카드)
          return IOS_MARKET_PREFIX + 'id1177889176';
        case 'hanawalletmembers': // 하나카드(하나멤버스 월렛)
          return IOS_MARKET_PREFIX + 'id1038288833';
        case 'shinsegaeeasypayment': // 신세계 SSGPAY
          return IOS_MARKET_PREFIX + 'id666237916';
        default:
          return this.url;
      }
    } else if (Platform.isAndroid) {
      if (this.package != null) {
        // 앱이 설치되어 있지 않아 실행 불가능할 경우 추출된 package 정보를 이용해 플레이스토어 열기
        return ANDROID_MARKET_PREFIX + this.package!;
      } else {
        switch (this.appScheme) {
          case ISP:
            return ANDROID_MARKET_PREFIX + PACKAGE_ISP;
          case BANKPAY:
            return ANDROID_MARKET_PREFIX + PACKAGE_BANKPAY;
          case KB_BANKPAY:
            return ANDROID_MARKET_PREFIX + PACKAGE_KB_BANKPAY;
          case NH_BANKPAY:
            return ANDROID_MARKET_PREFIX + PACKAGE_NH_BANKPAY;
          case MG_BANKPAY:
            return ANDROID_MARKET_PREFIX + PACKAGE_MG_BANKPAY;
          case KN_BANKPAY:
            return ANDROID_MARKET_PREFIX + PACKAGE_KN_BANKPAY;
          default:
        }
      }
    }
  }

  Future<bool> launchApp() async {
    if (Platform.isIOS) {
      if (await canLaunch(this.url!)) {
        return await launch(await (this.getAppUrl() as FutureOr<String>));
      } else {
        return await launch(await (this.getMarketUrl() as FutureOr<String>));
      }
    } else if (Platform.isAndroid) {
      try {
        return await launch(await (this.getAppUrl() as FutureOr<String>));
      } catch (e) {
        return await launch(await (this.getMarketUrl() as FutureOr<String>));
      }
    } else {
      return false;
    }
  }
}
