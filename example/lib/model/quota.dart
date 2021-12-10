class Quota {
  static List<String> QUOTAS = [
    '0',
    '1',
  ];

  static String getLabel(String quota) {
    switch (quota) {
      case '0':
        return 'PG사 기본 제공';
      case '1':
        return '일시불';
      case '2':
        return '2개월';
      case '3':
        return '3개월';
      case '4':
        return '4개월';
      case '5':
        return '5개월';
      case '6':
        return '6개월';
      default:
        return '-';
    }
  }

  static List<String> getListsByPg(String pg) {
    switch (pg) {
      case 'html5_inicis':
      case 'kcp':
        return QUOTAS + ['2', '3', '4', '5', '6'];
      default:
        return QUOTAS;
    }
  }
}
