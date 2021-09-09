import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iamport_flutter_example/screens/certification.dart';
import 'package:iamport_flutter_example/screens/certification_result.dart';
import 'package:iamport_flutter_example/screens/certification_test.dart';
import 'package:iamport_flutter_example/screens/home.dart';
import 'package:iamport_flutter_example/screens/payment.dart';
import 'package:iamport_flutter_example/screens/payment_result.dart';
import 'package:iamport_flutter_example/screens/payment_test.dart';

void main() {
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
    return GetMaterialApp(
      // initialRoute: '/',
      // theme: ThemeData(
      //   primaryColor: primaryColor,
      //   buttonColor: primaryColor,
      // ),
      // routes: {
      //   '/': (context) => Home(),
      //   '/payment-test': (context) => PaymentTest(),
      //   '/payment': (context) => Payment(),
      //   '/payment-result': (context) => PaymentResult(),
      //   '/certification-test': (context) => CertificationTest(),
      //   '/certification': (context) => Certification(),
      //   '/certification-result': (context) => CertificationResult(),
      // },
      initialRoute: '/',
      theme: ThemeData(
        primaryColor: primaryColor,
        buttonColor: primaryColor,
      ),
      getPages: [
        GetPage(name: '/', page: () => Home()),
        GetPage(name: '/payment-test', page: () => PaymentTest()),
        GetPage(name: '/payment', page: () => Payment()),
        GetPage(name: '/payment-result', page: () => PaymentResult()),
        GetPage(name: '/certification-test', page: () => CertificationTest()),
        GetPage(name: '/certification', page: () => Certification()),
        GetPage(
            name: '/certification-result', page: () => CertificationResult()),
      ],
    );
  }
}
