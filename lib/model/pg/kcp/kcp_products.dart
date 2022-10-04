import 'package:json_annotation/json_annotation.dart';

part 'kcp_products.g.dart';

@JsonSerializable()
class KcpProducts {
  String orderNumber;
  String name;
  int quantity;
  int amount;

  KcpProducts({
    required this.orderNumber,
    required this.name,
    required this.quantity,
    required this.amount,
  });

  factory KcpProducts.fromJson(Map<String, dynamic> json) =>
      _$KcpProductsFromJson(json);

  Map<String, dynamic> toJson() => _$KcpProductsToJson(this);
}
