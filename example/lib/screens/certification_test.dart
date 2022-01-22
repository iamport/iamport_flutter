import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iamport_flutter/model/certification_data.dart';
import 'package:iamport_flutter_example/model/carrier.dart';

class CertificationTest extends StatefulWidget {
  @override
  _CertificationTestState createState() => _CertificationTestState();
}

class _CertificationTestState extends State<CertificationTest> {
  final _formKey = GlobalKey<FormState>();
  late String merchantUid; // 주문번호
  String company = '아임포트'; // 회사명 또는 URL
  String carrier = 'SKT'; // 통신사
  late String name; // 본인인증 할 이름
  late String phone; // 본인인증 할 전화번호
  late String minAge; // 최소 허용 만 나이

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('아임포트 본인인증 테스트'),
        centerTitle: true,
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
                  labelText: '주문번호',
                ),
                validator: (value) => value!.isEmpty ? '주문번호는 필수입력입니다' : null,
                initialValue: 'mid_${DateTime.now().millisecondsSinceEpoch}',
                onSaved: (String? value) {
                  merchantUid = value!;
                },
              ),
              TextFormField(
                initialValue: company,
                decoration: InputDecoration(
                  labelText: '회사명',
                ),
                onSaved: (String? value) {
                  company = value!;
                },
              ),
              DropdownButtonFormField(
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
              TextFormField(
                decoration: InputDecoration(
                  labelText: '이름',
                  hintText: '본인인증 할 이름',
                ),
                onSaved: (String? value) {
                  name = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: '전화번호',
                  hintText: '본인인증 할 전화번호',
                ),
                keyboardType: TextInputType.number,
                onSaved: (String? value) {
                  phone = value!;
                },
              ),
              TextFormField(
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
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      CertificationData data = CertificationData(
                        merchantUid: merchantUid,
                        carrier: carrier,
                        company: company,
                        name: name,
                        phone: phone,
                      );
                      print("m_redirect_url: ${data.mRedirectUrl}");
                      if (minAge.length > 0) {
                        data.minAge = int.parse(minAge);
                      }

                      Get.toNamed('/certification', arguments: data);
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
