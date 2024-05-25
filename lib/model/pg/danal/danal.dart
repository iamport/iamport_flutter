import 'package:json_annotation/json_annotation.dart';

part 'danal.g.dart';

@JsonSerializable()
class Danal {
  Danal({this.isCashReceiptUi});

  factory Danal.fromJson(Map<String, dynamic> json) => _$DanalFromJson(json);

  /// KG 이니시스 결제창 내 현금영수증 노출 제어
  /// https://guide.portone.io/aad7f7a4-366b-46fc-8e59-f1d79c986b3e
  @JsonKey(name: 'ISCASHRECEIPTUI')
  String? isCashReceiptUi;

  Map<String, dynamic> toJson() => _$DanalToJson(this);
}
