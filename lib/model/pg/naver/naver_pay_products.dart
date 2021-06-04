import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:iamport_flutter/model/pg/naver/naver_products.dart';

@jsonSerializable
class NaverPayProducts implements NaverProducts {
  String categoryType;
  String categoryId;
  String uid;
  String name;
  int count;
  String? payReferrer;

  NaverPayProducts({
    required this.categoryType,
    required this.categoryId,
    required this.uid,
    required this.name,
    required this.count,
    this.payReferrer,
  });
}
