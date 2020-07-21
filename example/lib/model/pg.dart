class Pg {
  static List<String> PGS = [
    'html5_inicis',
    'kcp',
    'kcp_billing',
    'uplus',
    'jtnet',
    'nice',
    'kakaopay',
    'kakao',
    'danal',
    'danal_tpay',
    'kicc',
    'paypal',
    'mobilians',
    'payco',
    'settle',
    'naverco',
    'naverpay',
    'smilepay',
    'chai',
    'payple',
    'alipay',
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
        return 'LG 유플러스';
      case 'jtnet':
        return 'JTNET';
      case 'nice':
        return '나이스 정보통신';
      case 'kakaopay':
        return '신 - 카카오페이';
      case 'kakao':
        return '구 - LG CNS 카카오페이';
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
      case 'settle':
        return '세틀뱅크 가상계좌';
      case 'naverco':
        return '네이버 체크아웃';
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
      default:
        return '-';
    }
  }

  static List<String> getLists() {
    return PGS;
  }
}