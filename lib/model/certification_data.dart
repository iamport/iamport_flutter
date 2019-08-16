import 'dart:convert';

class CertificationData {
  String merchant_uid;  // 주문번호
  String company;       // 회사명 또는 URL
  String carrier;       // 통신사
  String name;          // 본인인증 할 이름
  String phone;         // 본인인증 할 휴대폰 번호
  int min_age;          // 허용 최소 만 나이

  CertificationData(
    this.merchant_uid,
    this.company,
    this.carrier,
    this.name,
    this.phone,
    this.min_age,
  );

  CertificationData.fromJson(Map<String, dynamic> data) :
    merchant_uid = data['merchant_uid'],
    company = data['company'],
    carrier = data['carrier'],
    name = data['name'],
    phone = data['phone'],
    min_age = data['min_age'];
  
  String toJsonString() {
    Map<String, dynamic> jsonData = {
      "merchant_uid": merchant_uid,
    };

    if (company != null) {
      jsonData['company'] = company;
    }
    if (carrier != null) {
      jsonData['carrier'] = carrier;
    }
    if (name != null) {
      jsonData['name'] = name;
    }
    if (phone != null) {
      jsonData['phone'] = phone;
    }
    if (min_age != null) {
      jsonData['min_age'] = min_age;
    }

    return jsonEncode(jsonData);
  }
}
