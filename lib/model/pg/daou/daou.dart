import 'package:json_annotation/json_annotation.dart';

part 'daou.g.dart';

@JsonSerializable()
class Daou {
  @JsonKey(name: "PRODUCTCODE")
  String? productCode;

  @JsonKey(name: "CASHRECEIPTFLAG")
  int cashReceiptFlag;

  Daou({
    this.productCode,
    required this.cashReceiptFlag,
  });

  factory Daou.fromJson(Map<String, dynamic> json) => _$DaouFromJson(json);

  Map<String, dynamic> toJson() => _$DaouToJson(this);
}
