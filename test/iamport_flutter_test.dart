import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iamport_flutter/iamport_flutter.dart';

void main() {
  const MethodChannel channel = MethodChannel('iamport_flutter');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await IamportFlutter.platformVersion, '42');
  });
}
