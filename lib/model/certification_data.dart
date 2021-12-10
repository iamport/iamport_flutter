import 'package:iamport_flutter/model/url_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'certification_data.g.dart';

@JsonSerializable()
class CertificationData {
  @JsonKey(name: 'merchant_uid')
  String? merchantUid;

  String? company;
  String? carrier;
  String? name;
  String? phone;

  @JsonKey(name: 'min_age')
  int? minAge;

  @JsonKey(name: 'm_redirect_url')
  String? mRedirectUrl;

  CertificationData({
    this.merchantUid,
    this.company,
    this.carrier,
    this.name,
    this.phone,
    this.minAge,
    this.mRedirectUrl,
  });

  factory CertificationData.fromJson(Map<String, dynamic> json) =>
      _$CertificationDataFromJson(json);

  Map<String, dynamic> toJson() => _$CertificationDataToJson(this);
}
