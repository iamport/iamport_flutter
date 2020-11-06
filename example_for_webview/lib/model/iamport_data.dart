import 'dart:convert';

class IamportData {
  String userCode; // 가맹점 식별코드
  String data; // 결제 || 본인인증 데이터
  String type; // payment(결제) || certification(본인인증)

  IamportData(
    this.userCode,
    this.data,
    this.type,
  );

  IamportData.fromJson(Map<String, dynamic> iamportData)
      : userCode = iamportData['userCode'],
        data = iamportData['data'],
        type = iamportData['type'];

  String toJsonString() {
    Map<String, dynamic> jsonData = {
      'userCode': userCode,
      'data': data,
      'type': type,
    };

    return jsonEncode(jsonData);
  }
}
