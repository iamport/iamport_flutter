import 'package:json_annotation/json_annotation.dart';

part 'naver_interface.g.dart';

@JsonSerializable()
class NaverInterface {
  const NaverInterface({
    this.cpaInflowCode,
    this.naverInflowCode,
    this.saClickId,
    this.merchantCustomCode1,
    this.merchantCustomCode2,
  });

  factory NaverInterface.fromJson(Map<String, dynamic> json) =>
      _$NaverInterfaceFromJson(json);

  final String? cpaInflowCode;
  final String? naverInflowCode;
  final String? saClickId;
  final String? merchantCustomCode1;
  final String? merchantCustomCode2;

  Map<String, dynamic> toJson() => _$NaverInterfaceToJson(this);
}
