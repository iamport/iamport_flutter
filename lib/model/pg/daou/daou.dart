import 'package:json_annotation/json_annotation.dart';

part 'daou.g.dart';

@JsonSerializable()
class Daou {
  Daou({this.productCode, required this.cashReceiptFlag});

  factory Daou.fromJson(Map<String, dynamic> json) => _$DaouFromJson(json);

  @JsonKey(name: 'PRODUCTCODE')
  String? productCode;

  @JsonKey(name: 'CASHRECEIPTFLAG')
  int cashReceiptFlag;

  Map<String, dynamic> toJson() => _$DaouToJson(this);
}
