import 'package:json_annotation/json_annotation.dart';

part 'naver_interface.g.dart';

@JsonSerializable()
class NaverInterface {
  NaverInterface({
    this.cpaInflowCode,
    this.naverInflowCode,
    this.saClickId,
    this.merchantCustomCode1,
    this.merchantCustomCode2,
  });

  factory NaverInterface.fromJson(Map<String, dynamic> json) =>
      _$NaverInterfaceFromJson(json);

  String? cpaInflowCode;
  String? naverInflowCode;
  String? saClickId;
  String? merchantCustomCode1;
  String? merchantCustomCode2;

  Map<String, dynamic> toJson() => _$NaverInterfaceToJson(this);
}
