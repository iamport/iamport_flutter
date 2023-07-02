// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'certification_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CertificationData _$CertificationDataFromJson(Map<String, dynamic> json) =>
    CertificationData(
      pg: json['pg'] as String?,
      merchantUid: json['merchant_uid'] as String?,
      company: json['company'] as String?,
      carrier: json['carrier'] as String?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      minAge: json['min_age'] as int?,
      popup: json['popup'] as bool?,
      mRedirectUrl: json['m_redirect_url'] as String?,
    );

Map<String, dynamic> _$CertificationDataToJson(CertificationData instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('pg', instance.pg);
  writeNotNull('merchant_uid', instance.merchantUid);
  writeNotNull('company', instance.company);
  writeNotNull('carrier', instance.carrier);
  writeNotNull('name', instance.name);
  writeNotNull('phone', instance.phone);
  writeNotNull('min_age', instance.minAge);
  writeNotNull('popup', instance.popup);
  writeNotNull('m_redirect_url', instance.mRedirectUrl);
  return val;
}
