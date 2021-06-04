import 'package:flutter/material.dart';

import 'package:iamport_flutter/iamport_payment.dart';
import 'package:iamport_flutter/model/payment_data.dart';

import '../utils/index.dart';

class Payment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PaymentData data =
        ModalRoute.of(context)!.settings.arguments as PaymentData;
    // data.appScheme = 'example';

    return IamportPayment(
      appBar: new AppBar(
        title: new Text('아임포트 결제'),
      ),
      initialChild: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/iamport-logo.png'),
              Container(
                padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                child: Text('잠시만 기다려주세요...', style: TextStyle(fontSize: 20.0)),
              ),
            ],
          ),
        ),
      ),
      userCode: Utils.getUserCodeByPg(data.pg!),
      data: data,
      callback: (Map<String, String> result) {
        Navigator.pushReplacementNamed(
          context,
          '/payment-result',
          arguments: result,
        );
      },
    );
  }
}
