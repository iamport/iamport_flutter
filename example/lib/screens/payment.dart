import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portone_flutter/iamport_payment.dart';
import 'package:portone_flutter/model/payment_data.dart';

class Payment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String userCode = Get.arguments['userCode'] as String;
    PaymentData data = Get.arguments['data'] as PaymentData;

    return IamportPayment(
      appBar: AppBar(
        title: Text('포트원 V1 결제'),
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 24,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      initialChild: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/iamport-logo.png'),
              Padding(padding: EdgeInsets.symmetric(vertical: 15)),
              Text('잠시만 기다려주세요...', style: TextStyle(fontSize: 20.0)),
            ],
          ),
        ),
      ),
      userCode: userCode,
      data: data,
      callback: (Map<String, String> result) {
        Get.offNamed('/payment-result', arguments: result);
      },
    );
  }
}
