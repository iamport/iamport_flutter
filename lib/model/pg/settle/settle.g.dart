// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Settle _$SettleFromJson(Map<String, dynamic> json) => Settle(
      cashReceiptType: json['criPsblYn'] as String?,
    );

Map<String, dynamic> _$SettleToJson(Settle instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('criPsblYn', instance.cashReceiptType);
  return val;
}
