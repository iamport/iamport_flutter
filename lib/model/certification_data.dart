import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:iamport_flutter/model/url_data.dart';

@jsonSerializable
@Json(ignoreNullMembers: true)
class CertificationData {
  @JsonProperty(name: 'merchant_uid')
  String? merchantUid;

  String? company;
  String? carrier;
  String? name;
  String? phone;

  @JsonProperty(name: 'min_age')
  int? minAge;

  @JsonProperty(name: 'm_redirect_url')
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
}
