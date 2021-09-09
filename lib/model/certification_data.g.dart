// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'certification_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CertificationData _$CertificationDataFromJson(Map<String, dynamic> json) {
  return CertificationData(
    merchantUid: json['merchant_uid'] as String?,
    company: json['company'] as String?,
    carrier: json['carrier'] as String?,
    name: json['name'] as String?,
    phone: json['phone'] as String?,
    minAge: json['min_age'] as int?,
  );
}

Map<String, dynamic> _$CertificationDataToJson(CertificationData instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('merchant_uid', instance.merchantUid);
  writeNotNull('company', instance.company);
  writeNotNull('carrier', instance.carrier);
  writeNotNull('name', instance.name);
  writeNotNull('phone', instance.phone);
  writeNotNull('min_age', instance.minAge);
  return val;
}
