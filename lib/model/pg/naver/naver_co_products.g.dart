// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'naver_co_products.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NaverCoProducts _$NaverCoProductsFromJson(Map<String, dynamic> json) =>
    NaverCoProducts(
      id: json['id'] as String?,
      merchantProductId: json['merchantProductId'] as String?,
      ecMallProductId: json['ecMallProductId'] as String?,
      name: json['name'] as String?,
      basePrice: json['basePrice'] as int?,
      taxType: json['taxType'] as String?,
      quantity: json['quantity'] as int?,
      infoUrl: json['infoUrl'] as String?,
      imageUrl: json['imageUrl'] as String?,
      giftName: json['giftName'] as String?,
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => NaverCoOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      shipping: json['shipping'] == null
          ? null
          : NaverCoShipping.fromJson(json['shipping'] as Map<String, dynamic>),
      supplements: (json['supplements'] as List<dynamic>?)
          ?.map((e) => NaverCoSupplement.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NaverCoProductsToJson(NaverCoProducts instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('merchantProductId', instance.merchantProductId);
  writeNotNull('ecMallProductId', instance.ecMallProductId);
  writeNotNull('name', instance.name);
  writeNotNull('basePrice', instance.basePrice);
  writeNotNull('taxType', instance.taxType);
  writeNotNull('quantity', instance.quantity);
  writeNotNull('infoUrl', instance.infoUrl);
  writeNotNull('imageUrl', instance.imageUrl);
  writeNotNull('giftName', instance.giftName);
  writeNotNull('options', instance.options);
  writeNotNull('shipping', instance.shipping);
  writeNotNull('supplements', instance.supplements);
  return val;
}

NaverCoOption _$NaverCoOptionFromJson(Map<String, dynamic> json) =>
    NaverCoOption(
      optionQuantity: json['optionQuantity'] as int?,
      optionPrice: json['optionPrice'] as int?,
      selectionCode: json['selectionCode'] as String?,
      selections: (json['selections'] as List<dynamic>?)
          ?.map((e) => NaverCoOptionItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NaverCoOptionToJson(NaverCoOption instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('optionQuantity', instance.optionQuantity);
  writeNotNull('optionPrice', instance.optionPrice);
  writeNotNull('selectionCode', instance.selectionCode);
  writeNotNull('selections', instance.selections);
  return val;
}

NaverCoOptionItem _$NaverCoOptionItemFromJson(Map<String, dynamic> json) =>
    NaverCoOptionItem(
      code: json['code'] as String?,
      label: json['label'] as String?,
      value: json['value'] as String?,
    );

Map<String, dynamic> _$NaverCoOptionItemToJson(NaverCoOptionItem instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('code', instance.code);
  writeNotNull('label', instance.label);
  writeNotNull('value', instance.value);
  return val;
}

NaverCoSupplement _$NaverCoSupplementFromJson(Map<String, dynamic> json) =>
    NaverCoSupplement(
      id: json['id'] as String?,
      name: json['name'] as String?,
      price: json['price'] as int?,
      quantity: json['quantity'] as int?,
    );

Map<String, dynamic> _$NaverCoSupplementToJson(NaverCoSupplement instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('price', instance.price);
  writeNotNull('quantity', instance.quantity);
  return val;
}

NaverCoShipping _$NaverCoShippingFromJson(Map<String, dynamic> json) =>
    NaverCoShipping(
      groupId: json['groupId'] as String?,
      method: json['method'] as String?,
      baseFee: json['baseFee'] as int?,
      feePayType: json['feePayType'] as String?,
      feeRule: json['feeRule'] == null
          ? null
          : NaverCoFeeRule.fromJson(json['feeRule'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NaverCoShippingToJson(NaverCoShipping instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('groupId', instance.groupId);
  writeNotNull('method', instance.method);
  writeNotNull('baseFee', instance.baseFee);
  writeNotNull('feePayType', instance.feePayType);
  writeNotNull('feeRule', instance.feeRule);
  return val;
}

NaverCoFeeRule _$NaverCoFeeRuleFromJson(Map<String, dynamic> json) =>
    NaverCoFeeRule(
      freeByThreshold: json['freeByThreshold'] as int?,
      repeatByQty: json['repeatByQty'] as int?,
      rangesByQty: (json['rangesByQty'] as List<dynamic>?)
          ?.map((e) => NaverCoFeeRangeByQty.fromJson(e as Map<String, dynamic>))
          .toList(),
      surchargesByArea: (json['surchargesByArea'] as List<dynamic>?)
          ?.map((e) => NaverCoFeeAreaByQty.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NaverCoFeeRuleToJson(NaverCoFeeRule instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('freeByThreshold', instance.freeByThreshold);
  writeNotNull('repeatByQty', instance.repeatByQty);
  writeNotNull('rangesByQty', instance.rangesByQty);
  writeNotNull('surchargesByArea', instance.surchargesByArea);
  return val;
}

NaverCoFeeRangeByQty _$NaverCoFeeRangeByQtyFromJson(
        Map<String, dynamic> json) =>
    NaverCoFeeRangeByQty(
      from: json['from'] as int?,
      surcharge: json['surcharge'] as int?,
    );

Map<String, dynamic> _$NaverCoFeeRangeByQtyToJson(
    NaverCoFeeRangeByQty instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('from', instance.from);
  writeNotNull('surcharge', instance.surcharge);
  return val;
}

NaverCoFeeAreaByQty _$NaverCoFeeAreaByQtyFromJson(Map<String, dynamic> json) =>
    NaverCoFeeAreaByQty(
      from: (json['from'] as List<dynamic>?)?.map((e) => e as String).toList(),
      surcharge: json['surcharge'] as int?,
    );

Map<String, dynamic> _$NaverCoFeeAreaByQtyToJson(NaverCoFeeAreaByQty instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('from', instance.from);
  writeNotNull('surcharge', instance.surcharge);
  return val;
}
