import 'package:iamport_flutter/model/pg/naver/naver_products.dart';
import 'package:json_annotation/json_annotation.dart';

part 'naver_co_products.g.dart';

@JsonSerializable()
class NaverCoProducts implements NaverProducts {
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

  Map<String, dynamic> toJson() => _$NaverCoProductsToJson(this);
}

@JsonSerializable()
class NaverCoOption {
  int? optionQuantity;
  int? optionPrice;
  String? selectionCode;
  List<NaverCoOptionItem>? selections;

  NaverCoOption({
    this.optionQuantity,
    this.optionPrice,
    this.selectionCode,
    this.selections,
  });

  factory NaverCoOption.fromJson(Map<String, dynamic> json) =>
      _$NaverCoOptionFromJson(json);

  Map<String, dynamic> toJson() => _$NaverCoOptionToJson(this);
}

@JsonSerializable()
class NaverCoOptionItem {
  String? code;
  String? label;
  String? value;

  NaverCoOptionItem({
    this.code,
    this.label,
    this.value,
  });

  factory NaverCoOptionItem.fromJson(Map<String, dynamic> json) =>
      _$NaverCoOptionItemFromJson(json);

  Map<String, dynamic> toJson() => _$NaverCoOptionItemToJson(this);
}

@JsonSerializable()
class NaverCoSupplement {
  String? id;
  String? name;
  int? price;
  int? quantity;

  NaverCoSupplement({
    this.id,
    this.name,
    this.price,
    this.quantity,
  });

  factory NaverCoSupplement.fromJson(Map<String, dynamic> json) =>
      _$NaverCoSupplementFromJson(json);

  Map<String, dynamic> toJson() => _$NaverCoSupplementToJson(this);
}

@JsonSerializable()
class NaverCoShipping {
  String? groupId;
  String? method;
  int? baseFee;
  String? feePayType;
  NaverCoFeeRule? feeRule;

  NaverCoShipping({
    this.groupId,
    this.method,
    this.baseFee,
    this.feePayType,
    this.feeRule,
  });

  factory NaverCoShipping.fromJson(Map<String, dynamic> json) =>
      _$NaverCoShippingFromJson(json);

  Map<String, dynamic> toJson() => _$NaverCoShippingToJson(this);
}

@JsonSerializable()
class NaverCoFeeRule {
  int? freeByThreshold;
  int? repeatByQty;
  List<NaverCoFeeRangeByQty>? rangesByQty;
  List<NaverCoFeeAreaByQty>? surchargesByArea;

  NaverCoFeeRule({
    this.freeByThreshold,
    this.repeatByQty,
    this.rangesByQty,
    this.surchargesByArea,
  });

  factory NaverCoFeeRule.fromJson(Map<String, dynamic> json) =>
      _$NaverCoFeeRuleFromJson(json);

  Map<String, dynamic> toJson() => _$NaverCoFeeRuleToJson(this);
}

@JsonSerializable()
class NaverCoFeeRangeByQty {
  int? from;
  int? surcharge;

  NaverCoFeeRangeByQty({
    this.from,
    this.surcharge,
  });

  factory NaverCoFeeRangeByQty.fromJson(Map<String, dynamic> json) =>
      _$NaverCoFeeRangeByQtyFromJson(json);

  Map<String, dynamic> toJson() => _$NaverCoFeeRangeByQtyToJson(this);
}

@JsonSerializable()
class NaverCoFeeAreaByQty {
  List<String>? from;
  int? surcharge;

  NaverCoFeeAreaByQty({
    this.from,
    this.surcharge,
  });

  factory NaverCoFeeAreaByQty.fromJson(Map<String, dynamic> json) =>
      _$NaverCoFeeAreaByQtyFromJson(json);

  Map<String, dynamic> toJson() => _$NaverCoFeeAreaByQtyToJson(this);
}
