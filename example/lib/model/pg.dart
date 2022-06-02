class Pg {
  static List<String> PGS = [
    'tosspayments.port-dev-test',
    'tosspayments.port-dev-live',
    'tosspayments.port-prod-test',
    'tosspayments.port-prod-live'
  ];

  static String getLabel(String pg) {
    switch(pg) {
      case 'tosspayments.port-dev-test':
        return '토스페이먼츠(port-dev-test)';
      case 'tosspayments.port-dev-live':
        return '토스페이먼츠(port-dev-live)';
      case 'tosspayments.port-prod-test':
        return '토스페이먼츠(port-prod-test)';
      case 'tosspayments.port-prod-live':
        return '토스페이먼츠(port-prod-live)';
      default:
        return "미확인 pg: $pg";
    }
  }

  static List<String> getLists() {
    return PGS;
  }
}
