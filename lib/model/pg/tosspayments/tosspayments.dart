import 'package:json_annotation/json_annotation.dart';

part 'tosspayments.g.dart';

@JsonSerializable()
class Tosspayments {
  const Tosspayments({this.useInternationalCardOnly, this.discountCode});

  factory Tosspayments.fromJson(Map<String, dynamic> json) =>
      _$TosspaymentsFromJson(json);

  final bool? useInternationalCardOnly;
  final String? discountCode;

  Map<String, dynamic> toJson() => _$TosspaymentsToJson(this);
}
