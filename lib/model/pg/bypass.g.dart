// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bypass.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bypass _$BypassFromJson(Map<String, dynamic> json) => Bypass(
      daou: json['daou'] == null
          ? null
          : Daou.fromJson(json['daou'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BypassToJson(Bypass instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('daou', instance.daou);
  return val;
}
