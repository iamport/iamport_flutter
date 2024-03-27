class Pg {
  static List<String> PGS = [
    'html5_inicis',
    'kcp',
    'kcp_billing',
    'uplus',
    'jtnet',
    'nice',
    'kakaopay',
    'danal',
    'danal_tpay',
    'kicc',
    'paypal',
    'mobilians',
    'payco',
    'eximbay',
    'settle',
    'naverpay',
    'smilepay',
    'chai',
    'payple',
    'alipay',
    'bluewalnut',
    'tosspay',
    'smartro',
    'tosspayments',
    'ksnet',
    'welcome',
    'tosspay_v2'
  ];

  static String getLabel(String pg) {
    switch (pg) {
      case 'html5_inicis':
        return '웹 표준 이니시스';
      case 'kcp':
        return 'NHN KCP';
      case 'kcp_billing':
        return 'NHN KCP 정기결제';
      case 'uplus':
        return '(구)토스페이먼츠';
      case 'jtnet':
        return 'JTNET';
      case 'nice':
        return '나이스 정보통신';
      case 'kakaopay':
        return '카카오페이';
      case 'danal':
        return '다날 휴대폰 소액결제';
      case 'danal_tpay':
        return '다날 일반결제';
      case 'kicc':
        return '한국정보통신';
      case 'paypal':
        return '페이팔';
      case 'mobilians':
        return '모빌리언스';
      case 'payco':
        return '페이코';
      case 'eximbay':
        return '엑심베이';
      case 'settle':
        return '세틀뱅크 가상계좌';
      case 'naverpay':
        return '네이버페이';
      case 'smilepay':
        return '스마일페이';
      case 'chai':
        return '차이페이';
      case 'payple':
        return '페이플';
      case 'alipay':
        return '알리페이';
      case 'bluewalnut':
        return '블루월넛';
      case 'tosspay':
        return '토스 간편결제';
      case 'smartro':
        return '스마트로';
      case 'tosspayments':
        return '토스페이먼츠';
      case 'ksnet':
        return 'KSNET';
      case 'welcome':
        return '웰컴페이먼츠';
      case 'tosspay_v2':
        return '토스페이(V2)';
      default:
        return '-';
    }
  }

  static List<String> getLists() {
    return PGS;
  }
}
