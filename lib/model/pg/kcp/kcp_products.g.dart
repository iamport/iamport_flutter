// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kcp_products.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KcpProducts _$KcpProductsFromJson(Map<String, dynamic> json) => KcpProducts(
      orderNumber: json['orderNumber'] as String,
      name: json['name'] as String,
      quantity: json['quantity'] as int,
      amount: json['amount'] as int,
    );

Map<String, dynamic> _$KcpProductsToJson(KcpProducts instance) =>
    <String, dynamic>{
      'orderNumber': instance.orderNumber,
      'name': instance.name,
      'quantity': instance.quantity,
      'amount': instance.amount,
    };
