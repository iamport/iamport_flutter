import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
@Json(name: 'naverInterface')
class NaverInterface {
  String? cpaInflowCode;
  String? naverInflowCode;
  String? saClickId;
  String? merchantCustomCode1;
  String? merchantCustomCode2;

  NaverInterface({
    this.cpaInflowCode,
    this.naverInflowCode,
    this.saClickId,
    this.merchantCustomCode1,
    this.merchantCustomCode2,
  });
}
