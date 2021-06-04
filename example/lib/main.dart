import 'package:flutter/material.dart';

import './screens/home.dart';
import './screens/payment_test.dart';
import './screens/payment.dart';
import './screens/payment_result.dart';
import './screens/certification_test.dart';
import './screens/certification.dart';
import './screens/certification_result.dart';
import './main.mapper.g.dart';

void main() {
  initializeJsonMapper();

  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
