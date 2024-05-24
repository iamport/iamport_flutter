import 'package:iamport_flutter_example/model/pg.dart';

class Quota {
  static final List<String> _default = [
    '0',
    '1',
  ];

  static String getLabel(String quota) {
    return switch (quota) {
      '0' => 'PG사 기본 제공',
      '1' => '일시불',
      '2' => '2개월',
      '3' => '3개월',
      '4' => '4개월',
      '5' => '5개월',
      '6' => '6개월',
      _ => '-',
    };
  }

  static List<String> getListsByPg(Pgs pg) {
    return switch (pg) {
      Pgs.html5_inicis || Pgs.kcp => _default + ['2', '3', '4', '5', '6'],
      _ => _default,
    };
  }
}
