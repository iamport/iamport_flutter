class Carrier {
  static List<String> CARRIERS = [
    'SKT',
    'KTF',
    'LGT',
    'MVNO',
  ];

  static String getLabel(String pg) {
    switch (pg) {
      case 'SKT':
        return 'SKT';
      case 'KTF':
        return 'KT';
      case 'LGT':
        return 'LGU+';
      case 'MVNO':
        return '알뜰폰';
      default:
        return '-';
    }
  }

  static List<String> getLists() {
    return CARRIERS;
  }
}
