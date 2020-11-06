import 'package:flutter/material.dart';

import 'package:iamport_flutter/iamport_payment.dart';
import 'package:iamport_flutter/model/payment_data.dart';

class Payment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PaymentData data = ModalRoute.of(context).settings.arguments;

    return IamportPayment(
      appBar: new AppBar(
        title: new Text('아임포트 결제'),
      ),
      userCode: 'imp19424728',
      data: data,
      callback: (Map<String, String> result) {
        Navigator.pushReplacementNamed(
          context,
          '/',
          arguments: result,
        );
      },
    );
  }
}
