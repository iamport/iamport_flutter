import 'package:iamport_flutter/model/pg/naver/naver_co_products.dart';
import 'package:iamport_flutter/model/pg/naver/naver_pay_products.dart';
import 'package:json_annotation/json_annotation.dart';

part 'naver_products.g.dart';

@JsonSerializable(createFactory: false)
abstract class NaverProducts {
  NaverProducts();

  factory NaverProducts.fromJson(Map<String, dynamic> json) {
    if (json['id'] != null) {
      return NaverCoProducts.fromJson(json);
    } else {
      return NaverPayProducts.fromJson(json);
    }
  }

  Map<String, dynamic> toJson() => _$NaverProductsToJson(this);
}
