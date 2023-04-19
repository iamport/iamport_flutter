// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bypass.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bypass _$BypassFromJson(Map<String, dynamic> json) => Bypass(
      isCulturalExpense: json['isCulturalExpense'] as bool?,
      cashReceiptType: json['cashReceiptType'] as String?,
      daou: json['daou'] == null
          ? null
          : Daou.fromJson(json['daou'] as Map<String, dynamic>),
      tosspayments: json['tosspayments'] == null
          ? null
          : Tosspayments.fromJson(json['tosspayments'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BypassToJson(Bypass instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('isCulturalExpense', instance.isCulturalExpense);
  writeNotNull('cashReceiptType', instance.cashReceiptType);
  writeNotNull('daou', instance.daou);
  writeNotNull('tosspayments', instance.tosspayments);
  return val;
}
