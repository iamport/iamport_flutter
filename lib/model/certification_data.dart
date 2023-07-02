import 'package:json_annotation/json_annotation.dart';

part 'certification_data.g.dart';

@JsonSerializable()
class CertificationData {
  String? pg;

  @JsonKey(name: 'merchant_uid')
  String? merchantUid;

  String? company;
  String? carrier;
  String? name;
  String? phone;

  @JsonKey(name: 'min_age')
  int? minAge;

  bool? popup;

  @JsonKey(name: 'm_redirect_url')
  String? mRedirectUrl;

  CertificationData({
    this.pg,
    this.merchantUid,
    this.company,
    this.carrier,
    this.name,
    this.phone,
    this.minAge,
    this.popup,
    this.mRedirectUrl,
  });

  factory CertificationData.fromJson(Map<String, dynamic> json) =>
      _$CertificationDataFromJson(json);

  Map<String, dynamic> toJson() => _$CertificationDataToJson(this);
}
