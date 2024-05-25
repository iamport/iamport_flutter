// 🌎 Project imports:
import 'package:iamport_flutter_example/model/method.dart';

enum Pgs {
  html5_inicis, // 웹 표준 이니시스
  kcp, // NHN KCP
  kcp_billing, // NHN KCP 정기결제
  uplus, // (구)토스페이먼츠
  jtnet, // JTNET
  nice, // 나이스 정보통신
  kakaopay, // 카카오페이
  danal, // 다날 휴대폰 소액결제
  danal_tpay, // 다날 일반결제
  kicc, // 한국정보통신
  paypal, // 페이팔
  mobilians, // 모빌리언스
  payco, // 페이코
  eximbay, // 엑심베이
  settle, // 세틀뱅크 가상계좌
  naverpay, // 네이버페이
  smilepay, // 스마일페이
  chai, // 차이페이
  payple, // 페이플
  alipay, // 알리페이
  bluewalnut, // 블루월넛
  tosspay, // 토스 간편결제
  smartro, // 스마트로
  tosspayments, // 토스페이먼츠
  ksnet, // KSNET
  welcome, // 웰컴페이먼츠
  tosspay_v2, // 토스페이(V2)
}

extension LabelExt on Pgs {
  String get label {
    return switch (this) {
      Pgs.html5_inicis => '웹 표준 이니시스',
      Pgs.kcp => 'NHN KCP',
      Pgs.kcp_billing => 'NHN KCP 정기결제',
      Pgs.uplus => '(구)토스페이먼츠',
      Pgs.jtnet => 'JTNET',
      Pgs.nice => '나이스 정보통신',
      Pgs.kakaopay => '카카오페이',
      Pgs.danal => '다날 휴대폰 소액결제',
      Pgs.danal_tpay => '다날 일반결제',
      Pgs.kicc => '한국정보통신',
      Pgs.paypal => '페이팔',
      Pgs.mobilians => '모빌리언스',
      Pgs.payco => '페이코',
      Pgs.eximbay => '엑심베이',
      Pgs.settle => '세틀뱅크 가상계좌',
      Pgs.naverpay => '네이버페이',
      Pgs.smilepay => '스마일페이',
      Pgs.chai => '차이페이',
      Pgs.payple => '페이플',
      Pgs.alipay => '알리페이',
      Pgs.bluewalnut => '블루월넛',
      Pgs.tosspay => '토스 간편결제',
      Pgs.smartro => '스마트로',
      Pgs.tosspayments => '토스페이먼츠',
      Pgs.ksnet => 'KSNET',
      Pgs.welcome => '웰컴페이먼츠',
      Pgs.tosspay_v2 => '토스페이(V2)',
    };
  }

  Methods get methods {
    return switch (this) {
      Pgs.danal => Methods.phone,
      Pgs.settle => Methods.vbank,
      Pgs.chai || Pgs.payple => Methods.trans,
      Pgs.tosspay_v2 => Methods.tosspay,
      _ => Methods.card,
    };
  }

  List<Methods> get supportedMethods {
    return switch (this) {
      Pgs.kcp_billing ||
      Pgs.kakaopay ||
      Pgs.paypal ||
      Pgs.payco ||
      Pgs.eximbay ||
      Pgs.smilepay ||
      Pgs.alipay =>
        [Methods.card],
      Pgs.danal => [Methods.phone],
      Pgs.mobilians => [Methods.card, Methods.phone],
      Pgs.chai || Pgs.payple => [Methods.trans],
      Pgs.tosspay_v2 => [Methods.tosspay],
      Pgs.settle => [Methods.vbank],
      Pgs.kcp => [
          Methods.card,
          Methods.trans,
          Methods.vbank,
          Methods.phone,
          Methods.samsung,
          Methods.naverpay,
        ],
      Pgs.html5_inicis => [
          Methods.card,
          Methods.trans,
          Methods.vbank,
          Methods.phone,
          Methods.samsung,
          Methods.kpay,
          Methods.cultureland,
          Methods.smartculture,
          Methods.happymoney,
        ],
      Pgs.uplus => [
          Methods.card,
          Methods.trans,
          Methods.vbank,
          Methods.phone,
          Methods.cultureland,
          Methods.smartculture,
          Methods.booknlife,
        ],
      _ => [Methods.card, Methods.trans, Methods.vbank, Methods.phone],
    };
  }
}
