class Method {
  static List<String> METHODS = [
    'card'
  ];

  static String getLabel(String method) {
    switch (method) {
      case 'card':
        return '신용카드';
      default:
        return '미확인 결제수단: $method';
    }
  }

  static String getValueByPg(String pg) {
    switch (pg) {
      default:
        return 'card';
    }
  }

  static List<String> getListsByPg(String pg) {
    switch (pg) {
      default:
        return METHODS;
    }
  }
}
