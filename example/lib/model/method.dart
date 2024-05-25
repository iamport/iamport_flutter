enum Methods {
  card, // 신용카드
  vbank, // 가상계좌
  trans, // 실시간 계좌이체
  phone, // 휴대폰 소액결제
  samsung, // 삼성페이
  kpay, // KPAY
  cultureland, // 문화상품권
  smartculture, // 스마트문상
  happymoney, // 해피머니
  booknlife, // 도서상품권
  naverpay, // 네이버페이
  tosspay, // 토스페이
}

extension MethodsExt on Methods {
  String get label {
    return switch (this) {
      Methods.card => '신용카드',
      Methods.vbank => '가상계좌',
      Methods.trans => '실시간 계좌이체',
      Methods.phone => '휴대폰 소액결제',
      Methods.samsung => '삼성페이',
      Methods.kpay => 'KPAY',
      Methods.cultureland => '문화상품권',
      Methods.smartculture => '스마트문상',
      Methods.happymoney => '해피머니',
      Methods.booknlife => '도서상품권',
      Methods.naverpay => '네이버페이',
      Methods.tosspay => '토스페이',
    };
  }
}
