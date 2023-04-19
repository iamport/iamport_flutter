// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tosspayments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tosspayments _$TosspaymentsFromJson(Map<String, dynamic> json) => Tosspayments(
      useInternationalCardOnly: json['useInternationalCardOnly'] as bool?,
      discountCode: json['discountCode'] as String?,
    );

Map<String, dynamic> _$TosspaymentsToJson(Tosspayments instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('useInternationalCardOnly', instance.useInternationalCardOnly);
  writeNotNull('discountCode', instance.discountCode);
  return val;
}
