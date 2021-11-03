// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'naver_pay_products.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NaverPayProducts _$NaverPayProductsFromJson(Map<String, dynamic> json) =>
    NaverPayProducts(
      categoryType: json['categoryType'] as String,
      categoryId: json['categoryId'] as String,
      uid: json['uid'] as String,
      name: json['name'] as String,
      count: json['count'] as int,
      payReferrer: json['payReferrer'] as String?,
    );

Map<String, dynamic> _$NaverPayProductsToJson(NaverPayProducts instance) {
  final val = <String, dynamic>{
    'categoryType': instance.categoryType,
    'categoryId': instance.categoryId,
    'uid': instance.uid,
    'name': instance.name,
    'count': instance.count,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('payReferrer', instance.payReferrer);
  return val;
}
