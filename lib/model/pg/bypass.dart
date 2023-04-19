import 'package:iamport_flutter/model/pg/daou/daou.dart';
import 'package:iamport_flutter/model/pg/tosspayments/tosspayments.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bypass.g.dart';

@JsonSerializable()
class Bypass {
  bool? isCulturalExpense;
  String? cashReceiptType;
  Daou? daou;
  Tosspayments? tosspayments;

  Bypass({
    this.isCulturalExpense,
    this.cashReceiptType,
    this.daou,
    this.tosspayments,
  });

  factory Bypass.fromJson(Map<String, dynamic> json) => _$BypassFromJson(json);

  Map<String, dynamic> toJson() => _$BypassToJson(this);
}
