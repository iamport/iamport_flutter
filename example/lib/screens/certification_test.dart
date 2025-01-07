import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portone_flutter/model/certification_data.dart';
import 'package:portone_flutter_example/model/carrier.dart';
import 'package:portone_flutter/model/url_data.dart';

class CertificationTest extends StatefulWidget {
  @override
  _CertificationTestState createState() => _CertificationTestState();
}

class _CertificationTestState extends State<CertificationTest> {
  final _formKey = GlobalKey<FormState>();
  late String userCode; // 가맹점 식별코드
  String pg = 'danal'; // PG사
  late String merchantUid; // 주문번호
  String company = '포트원'; // 회사명 또는 URL
  String carrier = 'SKT'; // 통신사
  late String name; // 본인인증 할 이름
  late String phone; // 본인인증 할 전화번호
  late String minAge; // 최소 허용 만 나이

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('포트원 V1 본인인증 테스트'),
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 24,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: '가맹점 식별코드',
                ),
                validator: (value) =>
                    value!.isEmpty ? '가맹점 식별코드는 필수입력입니다' : null,
                initialValue: '',
                onSaved: (String? value) {
                  userCode = value!;
                },
              ),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  labelText: 'PG사',
                ),
                value: pg,
                onChanged: (String? value) {
                  setState(() {
                    pg = value!;
                  });
                },
                items: ['danal', 'inicis_unified']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value == 'danal'
                        ? '다날 휴대폰 본인인증'
                        : (value == 'inicis_unified' ? '이니시스 통합인증' : '')),
                  );
                }).toList(),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: '주문번호',
                ),
                validator: (value) => value!.isEmpty ? '주문번호는 필수입력입니다' : null,
                initialValue: 'mid_${DateTime.now().millisecondsSinceEpoch}',
                onSaved: (String? value) {
                  merchantUid = value!;
                },
              ),
              Visibility(
                child: TextFormField(
                  initialValue: company,
                  decoration: InputDecoration(
                    labelText: '회사명',
                  ),
                  onSaved: (String? value) {
                    company = value!;
                  },
                ),
                visible: pg == 'danal',
              ),
              Visibility(
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: '통신사',
                  ),
                  value: carrier,
                  onChanged: (String? value) {
                    setState(() {
                      carrier = value!;
                    });
                  },
                  items: Carrier.getLists()
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(Carrier.getLabel(value)),
                    );
                  }).toList(),
                ),
                visible: pg == 'danal',
              ),
              Visibility(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: '이름',
                    hintText: '본인인증 할 이름',
                  ),
                  onSaved: (String? value) {
                    name = value!;
                  },
                ),
                visible: pg == 'danal',
              ),
              Visibility(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: '전화번호',
                    hintText: '본인인증 할 전화번호',
                  ),
                  keyboardType: TextInputType.number,
                  onSaved: (String? value) {
                    phone = value!;
                  },
                ),
                visible: pg == 'danal',
              ),
              Visibility(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: '최소연령',
                    hintText: '허용 최소 만 나이',
                  ),
                  validator: (value) {
                    if (value!.length > 0) {
                      RegExp regex = RegExp(r'^[0-9]+$');
                      if (!regex.hasMatch(value)) return '최소 연령이 올바르지 않습니다.';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  onSaved: (String? value) {
                    minAge = value!;
                  },
                ),
                visible: pg == 'danal',
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      CertificationData data = CertificationData(
                        pg: pg,
                        merchantUid: merchantUid,
                      );

                      if (pg == 'inicis_unified') {
                        data.mRedirectUrl = UrlData.redirectUrl;
                      } else {
                        data.carrier = carrier;
                        data.company = company;
                        data.name = name;
                        data.phone = phone;
                        if (minAge.length > 0) {
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
                  child: Text(
                    '본인인증 하기',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 0,
                    shadowColor: Colors.transparent,
                    backgroundColor: Colors.blue,
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
