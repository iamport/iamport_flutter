// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daou.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Daou _$DaouFromJson(Map<String, dynamic> json) => Daou(
      productCode: json['PRODUCTCODE'] as String?,
      cashReceiptFlag: json['CASHRECEIPTFLAG'] as int,
    );

Map<String, dynamic> _$DaouToJson(Daou instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('PRODUCTCODE', instance.productCode);
  val['CASHRECEIPTFLAG'] = instance.cashReceiptFlag;
  return val;
}
