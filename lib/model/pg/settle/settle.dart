import 'package:json_annotation/json_annotation.dart';

part 'settle.g.dart';

@JsonSerializable()
class Settle {
  Settle({this.cashReceiptType});

  factory Settle.fromJson(Map<String, dynamic> json) => _$SettleFromJson(json);

  @JsonKey(name: 'criPsblYn') // bypass.settle.criPsblYn
  String? cashReceiptType; // Y or N (default "Y")

  Map<String, dynamic> toJson() => _$SettleToJson(this);
}
