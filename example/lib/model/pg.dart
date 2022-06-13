class Pg {
  static List<String> PGS = [
    'tosspayments.kream-prod-live',
    'tosspayments.im_kream-prod-live',
  ];

  static String getLabel(String pg) {
    switch(pg) {
      case 'tosspayments.kream-prod-live':
        return '토스페이먼츠(kream-prod-live)';
      case 'tosspayments.im_kream-prod-live':
        return '토스페이먼츠(im_kream-prod-live)';
      default:
        return "미확인 pg: $pg";
    }
  }

  static List<String> getLists() {
    return PGS;
  }
}
