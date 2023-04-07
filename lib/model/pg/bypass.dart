import 'package:iamport_flutter/model/pg/daou/daou.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bypass.g.dart';

@JsonSerializable()
class Bypass {
  Daou? daou;

  Bypass({
    this.daou,
  });

  factory Bypass.fromJson(Map<String, dynamic> json) => _$BypassFromJson(json);

  Map<String, dynamic> toJson() => _$BypassToJson(this);
}
