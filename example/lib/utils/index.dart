class Utils {
  static String getUserCodeByPg(String pg) {
    switch(pg) {
      case 'kakao':
        return 'imp10391932';
      case 'paypal':
        return 'imp09350031';
      case 'mobilians':
        return 'imp60029475';
      case 'naverco':
      case 'naverpay':
        return 'imp41073887';
      default:
        return 'imp19424728';
    }
  }
}