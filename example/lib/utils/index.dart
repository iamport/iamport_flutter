class Utils {
  static String getUserCodeByPg(String pg) {
    switch (pg) {
      case 'kakao':
        return 'imp10391932';
      case 'paypal':
        return 'imp09350031';
      case 'mobilians':
        return 'imp60029475';
      case 'naverpay':
        return 'imp41073887';
      case 'smilepay':
        return 'imp49241793';
      case 'chai':
        return 'imp37739582';
      case 'alipay':
        return 'imp87936124';
      case 'payple':
        return 'imp42284830';
      case 'tosspayments':
        return 'imp89347847';
      default:
        return 'imp19424728';
    }
  }
}
