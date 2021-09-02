import 'package:flutter/material.dart';
import 'package:iamport_flutter_example/main.mapper.g.dart';

import './screens/home.dart';
import './screens/payment_test.dart';
import './screens/payment.dart';
import './screens/payment_result.dart';
import './screens/certification_test.dart';
import './screens/certification.dart';
import './screens/certification_result.dart';

void main() {
  initializeJsonMapper();

  runApp(new IamportApp());
}

class IamportApp extends StatefulWidget {
  @override
  _IamportAppState createState() => _IamportAppState();
}

class _IamportAppState extends State<IamportApp> {
  static const Color primaryColor = Color(0xff344e81);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      theme: ThemeData(
        primaryColor: primaryColor,
        buttonColor: primaryColor,
      ),
      routes: {
        '/': (context) => Home(),
        '/payment-test': (context) => PaymentTest(),
        '/payment': (context) => Payment(),
        '/payment-result': (context) => PaymentResult(),
        '/certification-test': (context) => CertificationTest(),
        '/certification': (context) => Certification(),
        '/certification-result': (context) => CertificationResult(),
      },
    );
  }
}
