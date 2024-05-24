import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iamport_flutter/iamport_certification.dart';
import 'package:iamport_flutter/model/certification_data.dart';

class Certification extends StatelessWidget {
  const Certification({super.key});

  @override
  Widget build(BuildContext context) {
    String userCode = Get.arguments['userCode'] as String;
    CertificationData data = Get.arguments['data'] as CertificationData;

    return IamportCertification(
      appBar: AppBar(
        title: const Text('아임포트 본인인증'),
        centerTitle: true,
        titleTextStyle: const TextStyle(fontSize: 24, color: Colors.white),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
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
              const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
              const Text('잠시만 기다려주세요...', style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
      userCode: userCode,
      data: data,
      callback: (Map<String, String> result) {
        Get.offNamed('/certification-result', arguments: result);
      },
    );
  }
}
