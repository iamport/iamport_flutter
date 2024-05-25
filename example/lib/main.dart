import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import 'package:iamport_flutter_example/screens/certification.dart';
import 'package:iamport_flutter_example/screens/certification_result.dart';
import 'package:iamport_flutter_example/screens/certification_test.dart';
import 'package:iamport_flutter_example/screens/home.dart';
import 'package:iamport_flutter_example/screens/payment.dart';
import 'package:iamport_flutter_example/screens/payment_result.dart';
import 'package:iamport_flutter_example/screens/payment_test.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.transparent,
    ),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  runApp(const IamportApp());
}

class IamportApp extends StatefulWidget {
  const IamportApp({super.key});

  @override
  State<IamportApp> createState() => _IamportAppState();
}

class _IamportAppState extends State<IamportApp> {
  static const Color primaryColor = Color(0xFF344E81);

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      initialRoute: '/',
      theme: ThemeData(primaryColor: primaryColor),
      getPages: [
        GetPage(name: '/', page: () => const Home()),
        GetPage(name: '/payment-test', page: () => const PaymentTest()),
        GetPage(name: '/payment', page: () => const Payment()),
        GetPage(name: '/payment-result', page: () => const PaymentResult()),
        GetPage(name: '/certification', page: () => const Certification()),
        GetPage(
          name: '/certification-test',
          page: () => const CertificationTest(),
        ),
        GetPage(
          name: '/certification-result',
          page: () => const CertificationResult(),
        ),
      ],
    );
  }
}
