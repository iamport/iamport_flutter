import 'package:json_annotation/json_annotation.dart';

import 'package:iamport_flutter/model/pg/danal/danal.dart';
import 'package:iamport_flutter/model/pg/daou/daou.dart';
import 'package:iamport_flutter/model/pg/settle/settle.dart';
import 'package:iamport_flutter/model/pg/tosspayments/tosspayments.dart';

part 'bypass.g.dart';

@JsonSerializable()
class Bypass {
  const Bypass({
    this.isCulturalExpense,
    this.cashReceiptType,
    this.acceptMethod,
    this.pReserved,
    this.daou,
    this.tosspayments,
    this.settle,
    this.danal,
  });

  factory Bypass.fromJson(Map<String, dynamic> json) => _$BypassFromJson(json);

  final bool? isCulturalExpense;
  final String? cashReceiptType;

  // https://guide.portone.io/aad7f7a4-366b-46fc-8e59-f1d79c986b3e
  @JsonKey(name: 'acceptmethod')
  final String? acceptMethod;
  @JsonKey(name: 'P_RESERVED')
  final String? pReserved;

  final Daou? daou;
  final Tosspayments? tosspayments;
  final Settle? settle;
  final Danal? danal;

  Map<String, dynamic> toJson() => _$BypassToJson(this);
}
