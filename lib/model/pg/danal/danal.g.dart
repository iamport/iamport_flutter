// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'danal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Danal _$DanalFromJson(Map<String, dynamic> json) => Danal(
      isCashReceiptUi: json['ISCASHRECEIPTUI'] as String?,
    );

Map<String, dynamic> _$DanalToJson(Danal instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ISCASHRECEIPTUI', instance.isCashReceiptUi);
  return val;
}
