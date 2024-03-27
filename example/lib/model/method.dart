class Method {
  static List<String> METHODS = [
    'card',
    'trans',
    'vbank',
    'phone',
  ];

  static List<String> METHODS_FOR_INICIS = METHODS +
      [
        'samsung',
        'kpay',
        'cultureland',
        'smartculture',
        'happymoney',
      ];

  static List<String> METHODS_FOR_UPLUS = METHODS +
      [
        'cultureland',
        'smartculture',
        'booknlife',
      ];

  static List<String> METHODS_FOR_KCP = METHODS + ['samsung', 'naverpay'];

  static List<String> METHODS_FOR_MOBILIANS = ['card', 'phone'];
  static List<String> METHOD_FOR_CARD = ['card'];
  static List<String> METHOD_FOR_PHONE = ['phone'];
  static List<String> METHOD_FOR_VBANK = ['vbank'];
  static List<String> METHOD_FOR_TRANS = ['trans'];
  static List<String> METHOD_FOR_TOSSPAY_V2 = ['tosspay'];

  static String getLabel(String method) {
    switch (method) {
      case 'card':
        return '신용카드';
      case 'vbank':
        return '가상계좌';
      case 'trans':
        return '실시간 계좌이체';
      case 'phone':
        return '휴대폰 소액결제';
      case 'samsung':
        return '삼성페이';
      case 'kpay':
        return 'KPAY';
      case 'cultureland':
        return '문화상품권';
      case 'smartculture':
        return '스마트문상';
      case 'happymoney':
        return '해피머니';
      case 'booknlife':
        return '도서상품권';
      case 'naverpay':
        return '네이버페이';
      case 'tosspay':
        return '토스페이';
      default:
        return '-';
    }
  }

  static String getValueByPg(String pg) {
    switch (pg) {
      case 'danal':
        return 'phone';
      case 'settle':
        return 'vbank';
      case 'chai':
      case 'payple':
        return 'trans';
      case 'tosspay_v2':
        return 'tosspay';
      default:
        return 'card';
    }
  }

  static List<String> getListsByPg(String pg) {
    switch (pg) {
      case 'html5_inicis':
        return METHODS_FOR_INICIS;
      case 'kcp':
        return METHODS_FOR_KCP;
      case 'kcp_billing':
      case 'kakaopay':
      case 'kakao':
      case 'paypal':
      case 'payco':
      case 'eximbay':
      case 'smilepay':
      case 'alipay':
        return METHOD_FOR_CARD;
      case 'uplus':
        return METHODS_FOR_UPLUS;
      case 'danal':
        return METHOD_FOR_PHONE;
      case 'mobilians':
        return METHODS_FOR_MOBILIANS;
      case 'settle':
        return METHOD_FOR_VBANK;
      case 'chai':
      case 'payple':
        return METHOD_FOR_TRANS;
      case 'tosspay_v2':
        return METHOD_FOR_TOSSPAY_V2;
      default:
        return METHODS;
    }
  }
}
