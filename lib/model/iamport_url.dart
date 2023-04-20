import 'dart:async';
import 'dart:io';

import 'package:iamport_flutter/model/url_data.dart';
import 'package:url_launcher/url_launcher.dart';

class IamportUrl {
  late String url;
  String? appScheme;
  String? appUrl;
  String? package; // Android only

  IamportUrl(String incomeUrl) {
    this.url = incomeUrl;

    List<String> splittedUrl =
        this.url.replaceFirst(RegExp(r'://'), ' ').split(' ');
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
          // 농협카드 일반결제 예외처리
          if (host.contains(':')) {
            host = host.replaceAll(RegExp(r':'), '%3A');
          }
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
    String? scheme;
    try {
      scheme = Uri.parse(this.url).scheme;
    } catch (e) {
      scheme = this.appScheme;
    }
    return !['http', 'https', 'about', 'data', ''].contains(scheme);
  }

  Future<String?> getAppUrl() async {
    return this.appUrl;
  }

  Future<String?> getMarketUrl() async {
    if (Platform.isIOS) {
      switch (this.appScheme) {
        case 'kftc-bankpay': // 뱅크페이
          return UrlData.IOS_MARKET_PREFIX + 'id398456030';
        case 'ispmobile': // ISP/페이북
          return UrlData.IOS_MARKET_PREFIX + 'id369125087';
        case 'hdcardappcardansimclick': // 현대카드 앱카드
          return UrlData.IOS_MARKET_PREFIX + 'id702653088';
        case 'shinhan-sr-ansimclick': // 신한 앱카드
          return UrlData.IOS_MARKET_PREFIX + 'id572462317';
        case 'kb-acp': // KB국민 앱카드
          return UrlData.IOS_MARKET_PREFIX + 'id695436326';
        case 'mpocket.online.ansimclick': // 삼성앱카드
          return UrlData.IOS_MARKET_PREFIX + 'id535125356';
        case 'lottesmartpay': // 롯데 모바일결제
          return UrlData.IOS_MARKET_PREFIX + 'id668497947';
        case 'lotteappcard': // 롯데 앱카드
          return UrlData.IOS_MARKET_PREFIX + 'id688047200';
        case 'cloudpay': // 하나1Q페이(앱카드)
          return UrlData.IOS_MARKET_PREFIX + 'id847268987';
        case 'citimobileapp': // 시티은행 앱카드
          return UrlData.IOS_MARKET_PREFIX + 'id1179759666';
        case 'payco': // 페이코
          return UrlData.IOS_MARKET_PREFIX + 'id924292102';
        case 'kakaotalk': // 카카오톡
          return UrlData.IOS_MARKET_PREFIX + 'id362057947';
        case 'lpayapp': // 롯데 L.pay
          return UrlData.IOS_MARKET_PREFIX + 'id1036098908';
        case 'wooripay': // 우리페이
          return UrlData.IOS_MARKET_PREFIX + 'id1201113419';
        case 'com.wooricard.wcard': // 우리WON카드
          return UrlData.IOS_MARKET_PREFIX + 'id1499598869';
        case 'nhallonepayansimclick': // NH농협카드 올원페이(앱카드)
          return UrlData.IOS_MARKET_PREFIX + 'id1177889176';
        case 'hanawalletmembers': // 하나카드(하나멤버스 월렛)
          return UrlData.IOS_MARKET_PREFIX + 'id1038288833';
        case 'shinsegaeeasypayment': // 신세계 SSGPAY
          return UrlData.IOS_MARKET_PREFIX + 'id666237916';
        case 'naversearchthirdlogin': // 네이버페이 앱 로그인
          return UrlData.IOS_MARKET_PREFIX + 'id393499958';
        case 'lguthepay-xpay': // 페이나우
          return UrlData.IOS_MARKET_PREFIX + 'id760098906';
        case 'lmslpay': // 롯데 L.POINT
          return UrlData.IOS_MARKET_PREFIX + 'id473250588';
        case 'liivbank': // Liiv 국민
          return UrlData.IOS_MARKET_PREFIX + 'id1126232922';
        case 'supertoss': // 토스
          return UrlData.IOS_MARKET_PREFIX + 'id839333328';
        case 'newsmartpib': // 우리WON뱅킹
          return UrlData.IOS_MARKET_PREFIX + 'id1470181651';
        case 'v3mobileplusweb': // V3 Mobile Plus
          return UrlData.IOS_MARKET_PREFIX + 'id1481938658';
        case 'kbbank': // KB스타뱅킹
          return UrlData.IOS_MARKET_PREFIX + 'id373742138';
        case 'newliiv': // 리브 Next
          return UrlData.IOS_MARKET_PREFIX + 'id1573528126';
        default:
          return this.url;
      }
    } else if (Platform.isAndroid) {
      if (this.package != null) {
        // 앱이 설치되어 있지 않아 실행 불가능할 경우 추출된 package 정보를 이용해 플레이스토어 열기
        return UrlData.ANDROID_MARKET_PREFIX + this.package!;
      }
      switch (this.appScheme) {
        case UrlData.ISP:
          return UrlData.ANDROID_MARKET_PREFIX + UrlData.PACKAGE_ISP;
        case UrlData.BANKPAY:
          return UrlData.ANDROID_MARKET_PREFIX + UrlData.PACKAGE_BANKPAY;
        case UrlData.KB_BANKPAY:
          return UrlData.ANDROID_MARKET_PREFIX + UrlData.PACKAGE_KB_BANKPAY;
        case UrlData.NH_BANKPAY:
          return UrlData.ANDROID_MARKET_PREFIX + UrlData.PACKAGE_NH_BANKPAY;
        case UrlData.MG_BANKPAY:
          return UrlData.ANDROID_MARKET_PREFIX + UrlData.PACKAGE_MG_BANKPAY;
        case UrlData.KN_BANKPAY:
          return UrlData.ANDROID_MARKET_PREFIX + UrlData.PACKAGE_KN_BANKPAY;
        case UrlData.KAKAOPAY:
          return UrlData.ANDROID_MARKET_PREFIX + UrlData.PACKAGE_KAKAOPAY;
        case UrlData.SMILEPAY:
          return UrlData.ANDROID_MARKET_PREFIX + UrlData.PACKAGE_SMILEPAY;
        case UrlData.CHAIPAY:
          return UrlData.ANDROID_MARKET_PREFIX + UrlData.PACKAGE_CHAIPAY;
        case UrlData.PAYCO:
          return UrlData.ANDROID_MARKET_PREFIX + UrlData.PACKAGE_PAYCO;
        case UrlData.HYUNDAICARD:
          return UrlData.ANDROID_MARKET_PREFIX + UrlData.PACKAGE_HYUNDAICARD;
        case UrlData.TOSS:
          return UrlData.ANDROID_MARKET_PREFIX + UrlData.PACKAGE_TOSS;
        case UrlData.SHINHANCARD:
          return UrlData.ANDROID_MARKET_PREFIX + UrlData.PACKAGE_SHINHANCARD;
        case UrlData.HANACARD:
          return UrlData.ANDROID_MARKET_PREFIX + UrlData.PACKAGE_HANACARD;
        case UrlData.SAMSUNGCARD:
          return UrlData.ANDROID_MARKET_PREFIX + UrlData.PACKAGE_SAMSUNGCARD;
        case UrlData.KBCARD:
          return UrlData.ANDROID_MARKET_PREFIX + UrlData.PACKAGE_KBCARD;
        case UrlData.NHCARD:
          return UrlData.ANDROID_MARKET_PREFIX + UrlData.PACKAGE_NHCARD;
        case UrlData.CITICARD:
          return UrlData.ANDROID_MARKET_PREFIX + UrlData.PACKAGE_CITICARD;
        case UrlData.LOTTECARD:
          return UrlData.ANDROID_MARKET_PREFIX + UrlData.PACKAGE_LOTTECARD;
        case UrlData.LPAY:
          return UrlData.ANDROID_MARKET_PREFIX + UrlData.PACKAGE_LPAY;
        case UrlData.SSGPAY:
          return UrlData.ANDROID_MARKET_PREFIX + UrlData.PACKAGE_SSGPAY;
        case UrlData.KPAY:
          return UrlData.ANDROID_MARKET_PREFIX + UrlData.PACKAGE_KPAY;
        case UrlData.PAYNOW:
          return UrlData.ANDROID_MARKET_PREFIX + UrlData.PACKAGE_PAYNOW;
        case UrlData.WOORIWONCARD:
          return UrlData.ANDROID_MARKET_PREFIX + UrlData.PACKAGE_WOORIWONCARD;
        case UrlData.LPOINT:
          return UrlData.ANDROID_MARKET_PREFIX + UrlData.PACKAGE_LPOINT;
        case UrlData.WOORIWONBANK:
          return UrlData.ANDROID_MARKET_PREFIX + UrlData.PACKAGE_WOORIWONBANK;
        case UrlData.KTFAUTH:
          return UrlData.ANDROID_MARKET_PREFIX + UrlData.PACKAGE_KTFAUTH;
        case UrlData.LGTAUTH:
          return UrlData.ANDROID_MARKET_PREFIX + UrlData.PACKAGE_LGTAUTH;
        case UrlData.SKTAUTH:
          return UrlData.ANDROID_MARKET_PREFIX + UrlData.PACKAGE_SKTAUTH;
        case UrlData.V3_MOBILE_PLUS:
          return UrlData.ANDROID_MARKET_PREFIX + UrlData.PACKAGE_V3_MOBILE_PLUS;
        case UrlData.KBBANK:
          return UrlData.ANDROID_MARKET_PREFIX + UrlData.PACKAGE_KBBANK;
        case UrlData.LIIV_NEXT:
          return UrlData.ANDROID_MARKET_PREFIX + UrlData.PACKAGE_LIIV_NEXT;
        default:
          return this.url;
      }
    }
  }

  Future<bool> launchApp() async {
    if (Platform.isIOS) {
      try {
        if (await canLaunch(this.url)) {
          return await launch((await this.getAppUrl())!);
        } else {
          return await launch((await this.getAppUrl())!);
        }
      } catch (e) {
        return await launch((await this.getMarketUrl())!);
      }
    } else if (Platform.isAndroid) {
      try {
        return await launch((await this.getAppUrl())!);
      } catch (e) {
        return await launch((await this.getMarketUrl())!);
      }
    }
    return false;
  }
}
