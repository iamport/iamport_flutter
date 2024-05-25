import 'package:flutter/material.dart';

import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(color: Color(0xFF344E81)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      '아임포트 테스트',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        height: 2,
                      ),
                    ),
                  ),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '아임포트 플러터 모듈 테스트 화면입니다.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '아래 버튼을 눌러 결제 또는 본인인증 테스트를 진행해주세요.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(padding: EdgeInsets.only(left: 20)),
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 0,
                          shadowColor: Colors.transparent,
                        ),
                        icon: const Icon(
                          Icons.payment,
                          color: Colors.black,
                          size: 25,
                        ),
                        label: const Text(
                          '결제 테스트',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () async {
                          Get.toNamed('/payment-test');
                        },
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 0,
                          shadowColor: Colors.transparent,
                        ),
                        icon: const Icon(
                          Icons.people,
                          color: Colors.black,
                          size: 25,
                        ),
                        label: const Text(
                          '본인인증 테스트',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () async {
                          Get.toNamed('/certification-test');
                        },
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(right: 20)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
