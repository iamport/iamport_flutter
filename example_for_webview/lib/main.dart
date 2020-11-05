import 'package:flutter/material.dart';

import './screens/payment.dart';

void main() => runApp(new MyApp());

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
        '/': (context) => Payment(),
      },
    );
  }
}
