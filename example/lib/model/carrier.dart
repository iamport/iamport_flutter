enum Carriers {
  SKT,
  KTF,
  LGT,
  MVNO,
}

extension LabelExt on Carriers {
  String get label {
    return switch (this) {
      Carriers.SKT => 'SKT',
      Carriers.KTF => 'KT',
      Carriers.LGT => 'LGU+',
      Carriers.MVNO => '알뜰폰',
    };
  }
}
