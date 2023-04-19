import 'package:json_annotation/json_annotation.dart';

part 'tosspayments.g.dart';

@JsonSerializable()
class Tosspayments {
  bool? useInternationalCardOnly;
  String? discountCode;

  Tosspayments({
    this.useInternationalCardOnly,
    this.discountCode,
  });

  factory Tosspayments.fromJson(Map<String, dynamic> json) =>
      _$TosspaymentsFromJson(json);

  Map<String, dynamic> toJson() => _$TosspaymentsToJson(this);
}
