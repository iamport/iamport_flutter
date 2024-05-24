import 'package:json_annotation/json_annotation.dart';

import 'package:iamport_flutter/model/pg/naver/naver_products.dart';

part 'naver_co_products.g.dart';

@JsonSerializable()
class NaverCoProducts implements NaverProducts {
  NaverCoProducts({
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

  String? id;
  String? merchantProductId;
  String? ecMallProductId;
  String? name;
  int? basePrice;
  String? taxType;
  int? quantity;
  String? infoUrl;
  String? imageUrl;
  String? giftName;
  List<NaverCoOption>? options;
  NaverCoShipping? shipping;
  List<NaverCoSupplement>? supplements;

  @override
  Map<String, dynamic> toJson() => _$NaverCoProductsToJson(this);
}

@JsonSerializable()
class NaverCoOption {
  NaverCoOption({
    this.optionQuantity,
    this.optionPrice,
    this.selectionCode,
    this.selections,
  });

  factory NaverCoOption.fromJson(Map<String, dynamic> json) =>
      _$NaverCoOptionFromJson(json);

  int? optionQuantity;
  int? optionPrice;
  String? selectionCode;
  List<NaverCoOptionItem>? selections;

  Map<String, dynamic> toJson() => _$NaverCoOptionToJson(this);
}

@JsonSerializable()
class NaverCoOptionItem {
  NaverCoOptionItem({
    this.code,
    this.label,
    this.value,
  });

  factory NaverCoOptionItem.fromJson(Map<String, dynamic> json) =>
      _$NaverCoOptionItemFromJson(json);

  String? code;
  String? label;
  String? value;

  Map<String, dynamic> toJson() => _$NaverCoOptionItemToJson(this);
}

@JsonSerializable()
class NaverCoSupplement {
  NaverCoSupplement({
    this.id,
    this.name,
    this.price,
    this.quantity,
  });

  factory NaverCoSupplement.fromJson(Map<String, dynamic> json) =>
      _$NaverCoSupplementFromJson(json);

  String? id;
  String? name;
  int? price;
  int? quantity;

  Map<String, dynamic> toJson() => _$NaverCoSupplementToJson(this);
}

@JsonSerializable()
class NaverCoShipping {
  NaverCoShipping({
    this.groupId,
    this.method,
    this.baseFee,
    this.feePayType,
    this.feeRule,
  });

  factory NaverCoShipping.fromJson(Map<String, dynamic> json) =>
      _$NaverCoShippingFromJson(json);

  String? groupId;
  String? method;
  int? baseFee;
  String? feePayType;
  NaverCoFeeRule? feeRule;

  Map<String, dynamic> toJson() => _$NaverCoShippingToJson(this);
}

@JsonSerializable()
class NaverCoFeeRule {
  NaverCoFeeRule({
    this.freeByThreshold,
    this.repeatByQty,
    this.rangesByQty,
    this.surchargesByArea,
  });

  factory NaverCoFeeRule.fromJson(Map<String, dynamic> json) =>
      _$NaverCoFeeRuleFromJson(json);

  int? freeByThreshold;
  int? repeatByQty;
  List<NaverCoFeeRangeByQty>? rangesByQty;
  List<NaverCoFeeAreaByQty>? surchargesByArea;

  Map<String, dynamic> toJson() => _$NaverCoFeeRuleToJson(this);
}

@JsonSerializable()
class NaverCoFeeRangeByQty {
  NaverCoFeeRangeByQty({
    this.from,
    this.surcharge,
  });

  factory NaverCoFeeRangeByQty.fromJson(Map<String, dynamic> json) =>
      _$NaverCoFeeRangeByQtyFromJson(json);

  int? from;
  int? surcharge;

  Map<String, dynamic> toJson() => _$NaverCoFeeRangeByQtyToJson(this);
}

@JsonSerializable()
class NaverCoFeeAreaByQty {
  NaverCoFeeAreaByQty({
    this.from,
    this.surcharge,
  });

  factory NaverCoFeeAreaByQty.fromJson(Map<String, dynamic> json) =>
      _$NaverCoFeeAreaByQtyFromJson(json);

  List<String>? from;
  int? surcharge;

  Map<String, dynamic> toJson() => _$NaverCoFeeAreaByQtyToJson(this);
}
