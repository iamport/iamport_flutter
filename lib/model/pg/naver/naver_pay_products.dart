import 'package:json_annotation/json_annotation.dart';

import 'package:iamport_flutter/model/pg/naver/naver_products.dart';

part 'naver_pay_products.g.dart';

@JsonSerializable()
class NaverPayProducts implements NaverProducts {
  NaverPayProducts({
    required this.categoryType,
    required this.categoryId,
    required this.uid,
    required this.name,
    required this.count,
    this.payReferrer,
  });

  factory NaverPayProducts.fromJson(Map<String, dynamic> json) =>
      _$NaverPayProductsFromJson(json);

  String categoryType;
  String categoryId;
  String uid;
  String name;
  int count;
  String? payReferrer;

  @override
  Map<String, dynamic> toJson() => _$NaverPayProductsToJson(this);
}
