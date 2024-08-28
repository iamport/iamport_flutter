import 'package:json_annotation/json_annotation.dart';

part 'kcp_products.g.dart';

@JsonSerializable()
class KcpProducts {
  const KcpProducts({
    required this.orderNumber,
    required this.name,
    required this.quantity,
    required this.amount,
  });

  factory KcpProducts.fromJson(Map<String, dynamic> json) =>
      _$KcpProductsFromJson(json);

  final String orderNumber;
  final String name;
  final int quantity;
  final int amount;

  Map<String, dynamic> toJson() => _$KcpProductsToJson(this);
}
