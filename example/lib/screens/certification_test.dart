import 'package:flutter/material.dart';

import 'package:iamport_flutter/model/certification_data.dart';

import '../model/carrier.dart';

class CertificationTest extends StatefulWidget {
  @override
  _CertificationTestState createState() => _CertificationTestState();
}

class _CertificationTestState extends State<CertificationTest> {
  final _formKey = GlobalKey<FormState>();
  String merchantUid;        // 주문번호
  String company = '아임포트'; // 회사명 또는 URL
  String carrier = 'SKT';    // 통신사
  String name;               // 본인인증 할 이름
  String phone;              // 본인인증 할 전화번호
  String minAge;             // 최소 허용 만 나이

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('아임포트 본인인증 테스트'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: '주문번호',
                ),
                validator: (value) => value.isEmpty ? '주문번호는 필수입력입니다' : null,
                initialValue: 'mid_${DateTime.now().millisecondsSinceEpoch}',
                onSaved: (String value) {
                  merchantUid = value;
                },
              ),
              TextFormField(
                initialValue: company,
                decoration: InputDecoration(
                  labelText: '회사명',
                ),
                onSaved: (String value) {
                  company = value;
                },
              ),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  labelText: '통신사',
                ),
                value: carrier,
                onChanged: (String value) {
                  setState(() {
                    carrier = value;
                  });
                },
                items: Carrier.getLists()
                  .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(Carrier.getLabel(value)),
                    );
                  })
                  .toList(),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: '이름',
                  hintText: '본인인증 할 이름',
                ),
                onSaved: (String value) {
                  name = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: '전화번호',
                  hintText: '본인인증 할 전화번호',
                ),
                keyboardType: TextInputType.number,
                onSaved: (String value) {
                  phone = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: '최소연령',
                  hintText: '허용 최소 만 나이',
                ),
                validator: (value) {
                  if (value.length > 0) {
                    Pattern pattern = r'^[0-9]+$';
                    RegExp regex = new RegExp(pattern);
                    if (!regex.hasMatch(value))
                      return '최소 연령이 올바르지 않습니다.';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                onSaved: (String value) {
                  minAge = value;
                },
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 30.0, 0, 0),
                child: RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();

                      CertificationData data = CertificationData.fromJson({
                        'merchantUid': merchantUid,
                        'carrier': carrier,
                      });
                      if (company != null) {
                        data.company = company; 
                      }
                      if (name != null) {
                        data.name = name; 
                      }
                      if (phone != null) {
                        data.phone = phone; 
                      }
                      if (minAge.length != null && minAge.length > 0) {
                        data.minAge = int.parse(minAge);
                      }

                      Navigator.pushNamed(
                        context,
                        '/certification',
                        arguments: data
                      );
                    }
                  },
                  child: Text('본인인증 하기', style: TextStyle(fontSize: 20)),
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(15.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}