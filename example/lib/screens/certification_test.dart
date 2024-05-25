import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iamport_flutter/model/certification_data.dart';
import 'package:iamport_flutter/model/url_data.dart';

import 'package:iamport_flutter_example/model/carrier.dart';
import 'package:iamport_flutter_example/model/pg.dart';

class CertificationTest extends StatefulWidget {
  const CertificationTest({super.key});

  @override
  State<CertificationTest> createState() => _CertificationTestState();
}

class _CertificationTestState extends State<CertificationTest> {
  final _formKey = GlobalKey<FormState>();
  late String userCode; // 가맹점 식별코드
  Pgs pg = Pgs.danal; // PG사
  late String merchantUid; // 주문번호
  String company = '아임포트'; // 회사명 또는 URL
  Carriers carrier = Carriers.SKT; // 통신사
  late String name; // 본인인증 할 이름
  late String phone; // 본인인증 할 전화번호
  late String minAge; // 최소 허용 만 나이

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('아임포트 본인인증 테스트'),
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
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: '가맹점 식별코드'),
                validator: (value) =>
                    value!.isEmpty ? '가맹점 식별코드는 필수입력입니다' : null,
                initialValue: '',
                onSaved: (String? value) {
                  userCode = value!;
                },
              ),
              DropdownButtonFormField(
                decoration: const InputDecoration(labelText: 'PG사'),
                value: pg,
                onChanged: (Pgs? value) {
                  setState(() {
                    pg = value!;
                  });
                },
                items: [Pgs.danal, Pgs.html5_inicis]
                    .map<DropdownMenuItem<Pgs>>((Pgs value) {
                  return DropdownMenuItem<Pgs>(
                    value: value,
                    child: Text(
                      value == Pgs.danal
                          ? '다날 휴대폰 본인인증'
                          : (value == Pgs.html5_inicis ? '이니시스 통합인증' : ''),
                    ),
                  );
                }).toList(),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: '주문번호'),
                validator: (value) => value!.isEmpty ? '주문번호는 필수입력입니다' : null,
                initialValue: 'mid_${DateTime.now().millisecondsSinceEpoch}',
                onSaved: (String? value) {
                  merchantUid = value!;
                },
              ),
              Visibility(
                visible: pg == Pgs.danal,
                child: TextFormField(
                  initialValue: company,
                  decoration: const InputDecoration(labelText: '회사명'),
                  onSaved: (String? value) {
                    company = value!;
                  },
                ),
              ),
              Visibility(
                visible: pg == Pgs.danal,
                child: DropdownButtonFormField(
                  decoration: const InputDecoration(labelText: '통신사'),
                  value: carrier,
                  onChanged: (Carriers? value) {
                    setState(() {
                      carrier = value!;
                    });
                  },
                  items: Carriers.values
                      .map<DropdownMenuItem<Carriers>>((Carriers value) {
                    return DropdownMenuItem<Carriers>(
                      value: value,
                      child: Text(value.name),
                    );
                  }).toList(),
                ),
              ),
              Visibility(
                visible: pg == Pgs.danal,
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: '이름',
                    hintText: '본인인증 할 이름',
                  ),
                  onSaved: (String? value) {
                    name = value!;
                  },
                ),
              ),
              Visibility(
                visible: pg == Pgs.danal,
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: '전화번호',
                    hintText: '본인인증 할 전화번호',
                  ),
                  keyboardType: TextInputType.number,
                  onSaved: (String? value) {
                    phone = value!;
                  },
                ),
              ),
              Visibility(
                visible: pg == Pgs.danal,
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: '최소연령',
                    hintText: '허용 최소 만 나이',
                  ),
                  validator: (value) {
                    if (value!.isNotEmpty) {
                      final regex = RegExp(r'^[0-9]+$');
                      if (!regex.hasMatch(value)) return '최소 연령이 올바르지 않습니다.';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  onSaved: (String? value) {
                    minAge = value!;
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      final data = CertificationData(
                        pg: pg.name,
                        merchantUid: merchantUid,
                      );

                      if (pg == Pgs.html5_inicis) {
                        data.mRedirectUrl = UrlData.redirectUrl;
                      } else {
                        data.carrier = carrier.name;
                        data.company = company;
                        data.name = name;
                        data.phone = phone;
                        if (minAge.isNotEmpty) {
                          data.minAge = int.parse(minAge);
                        }
                      }

                      Get.toNamed(
                        '/certification',
                        arguments: {
                          'userCode': userCode,
                          'data': data,
                        },
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 0,
                    shadowColor: Colors.transparent,
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text(
                    '본인인증 하기',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
