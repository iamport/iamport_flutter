import 'package:json_annotation/json_annotation.dart';

import 'package:iamport_flutter/model/pg/naver/naver_products.dart';

part 'naver_co_products.g.dart';

@JsonSerializable()
class NaverCoProducts implements NaverProducts {
  const NaverCoProducts({
    this.id,
    this.merchantProductId,
    this.ecMallProductId,
    this.name,
    this.basePrice,
    this.taxType,
    this.quantity,
    this.infoUrl,
    this.imageUrl,
    this.giftName,
    this.options,
    this.shipping,
    this.supplements,
  });

  factory NaverCoProducts.fromJson(Map<String, dynamic> json) =>
      _$NaverCoProductsFromJson(json);

  final String? id;
  final String? merchantProductId;
  final String? ecMallProductId;
  final String? name;
  final int? basePrice;
  final String? taxType;
  final int? quantity;
  final String? infoUrl;
  final String? imageUrl;
  final String? giftName;
  final List<NaverCoOption>? options;
  final NaverCoShipping? shipping;
  final List<NaverCoSupplement>? supplements;

  @override
  Map<String, dynamic> toJson() => _$NaverCoProductsToJson(this);
}

@JsonSerializable()
class NaverCoOption {
  const NaverCoOption({
    this.optionQuantity,
    this.optionPrice,
    this.selectionCode,
    this.selections,
  });

  factory NaverCoOption.fromJson(Map<String, dynamic> json) =>
      _$NaverCoOptionFromJson(json);

  final int? optionQuantity;
  final int? optionPrice;
  final String? selectionCode;
  final List<NaverCoOptionItem>? selections;

  Map<String, dynamic> toJson() => _$NaverCoOptionToJson(this);
}

@JsonSerializable()
class NaverCoOptionItem {
  const NaverCoOptionItem({this.code, this.label, this.value});

  factory NaverCoOptionItem.fromJson(Map<String, dynamic> json) =>
      _$NaverCoOptionItemFromJson(json);

  final String? code;
  final String? label;
  final String? value;

  Map<String, dynamic> toJson() => _$NaverCoOptionItemToJson(this);
}

@JsonSerializable()
class NaverCoSupplement {
  const NaverCoSupplement({this.id, this.name, this.price, this.quantity});

  factory NaverCoSupplement.fromJson(Map<String, dynamic> json) =>
      _$NaverCoSupplementFromJson(json);

  final String? id;
  final String? name;
  final int? price;
  final int? quantity;

  Map<String, dynamic> toJson() => _$NaverCoSupplementToJson(this);
}

@JsonSerializable()
class NaverCoShipping {
  const NaverCoShipping({
    this.groupId,
    this.method,
    this.baseFee,
    this.feePayType,
    this.feeRule,
  });

  factory NaverCoShipping.fromJson(Map<String, dynamic> json) =>
      _$NaverCoShippingFromJson(json);

  final String? groupId;
  final String? method;
  final int? baseFee;
  final String? feePayType;
  final NaverCoFeeRule? feeRule;

  Map<String, dynamic> toJson() => _$NaverCoShippingToJson(this);
}

@JsonSerializable()
class NaverCoFeeRule {
  const NaverCoFeeRule({
    this.freeByThreshold,
    this.repeatByQty,
    this.rangesByQty,
    this.surchargesByArea,
  });

  factory NaverCoFeeRule.fromJson(Map<String, dynamic> json) =>
      _$NaverCoFeeRuleFromJson(json);

  final int? freeByThreshold;
  final int? repeatByQty;
  final List<NaverCoFeeRangeByQty>? rangesByQty;
  final List<NaverCoFeeAreaByQty>? surchargesByArea;

  Map<String, dynamic> toJson() => _$NaverCoFeeRuleToJson(this);
}

@JsonSerializable()
class NaverCoFeeRangeByQty {
  const NaverCoFeeRangeByQty({this.from, this.surcharge});

  factory NaverCoFeeRangeByQty.fromJson(Map<String, dynamic> json) =>
      _$NaverCoFeeRangeByQtyFromJson(json);

  final int? from;
  final int? surcharge;

  Map<String, dynamic> toJson() => _$NaverCoFeeRangeByQtyToJson(this);
}

@JsonSerializable()
class NaverCoFeeAreaByQty {
  const NaverCoFeeAreaByQty({this.from, this.surcharge});

  factory NaverCoFeeAreaByQty.fromJson(Map<String, dynamic> json) =>
      _$NaverCoFeeAreaByQtyFromJson(json);

  final List<String>? from;
  final int? surcharge;

  Map<String, dynamic> toJson() => _$NaverCoFeeAreaByQtyToJson(this);
}
