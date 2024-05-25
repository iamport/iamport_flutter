import 'package:flutter/material.dart';

import 'package:get/get.dart';

typedef PaymentResultPayload = Map<String, String>;

extension SuccessResult on PaymentResultPayload {
  bool get isSucceed {
    bool? getBoolean(String? value) {
      switch (value) {
        case 'true':
          return true;
        case 'false':
          return false;
      }
      return null;
    }

    return getBoolean(this['imp_success']) ??
        getBoolean(this['success']) ??
        this['error_code'] == null && this['code'] == null;
  }

  String get transactionId {
    return this['imp_uid'] ?? this['txId'] ?? '-';
  }

  String get paymentId {
    return this['merchant_uid'] ?? this['paymentId'] ?? '-';
  }

  String get errorCode {
    return this['error_code'] ?? this['code'] ?? '-';
  }

  String get errorMessage {
    return this['error_msg'] ?? this['message'] ?? '-';
  }
}

class PaymentResult extends StatelessWidget {
  static const Color successColor = Color(0xFF52C41A);
  static const Color failureColor = Color(0xFFF5222D);

  const PaymentResult({super.key});

  @override
  Widget build(BuildContext context) {
    final payload = Get.arguments as PaymentResultPayload;
    final isSucceed = payload.isSucceed;
    String message;
    IconData icon;
    Color color;
    if (isSucceed) {
      message = '결제에 성공하였습니다';
      icon = Icons.check_circle;
      color = successColor;
    } else {
      message = '결제에 실패하였습니다';
      icon = Icons.error;
      color = failureColor;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('아임포트 결제 결과'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 200),
            Text(
              message,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(50, 30, 50, 50),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 4,
                          child: Text(
                            '아임포트 번호',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Expanded(flex: 5, child: Text(payload.transactionId)),
                      ],
                    ),
                  ),
                  isSucceed
                      ? Container(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            children: [
                              const Expanded(
                                flex: 4,
                                child: Text(
                                  '주문 번호',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                              Expanded(flex: 5, child: Text(payload.paymentId)),
                            ],
                          ),
                        )
                      : Container(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Expanded(
                                    flex: 4,
                                    child: Text(
                                      '에러 코드',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Text(payload.errorCode),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Expanded(
                                    flex: 4,
                                    child: Text(
                                      '에러 메시지',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Text(payload.errorMessage),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.arrow_back),
              onPressed: () async {
                Get.offAllNamed('/');
              },
              label: const Text(
                '돌아가기',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                shadowColor: Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
