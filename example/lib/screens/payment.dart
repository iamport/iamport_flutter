import 'package:flutter/material.dart';
import 'package:iamport_flutter/iamport_payment.dart';
import 'package:iamport_flutter/model/payment_data.dart';

import '../utils/index.dart';

class Payment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PaymentData data = ModalRoute.of(context).settings.arguments;
    data.appScheme = 'example';

    return Scaffold(
      appBar: AppBar(title: Text('아임포트 결제')),
      body: IamportPayment(
        userCode: Utils.getUserCodeByPg(data.pg),
        data: data,
        callback: (Map<String, String> result) {
          Navigator.pushReplacementNamed(
            context,
            '/payment-result',
            arguments: result,
          );
        },
      ),
    );
  }
}
