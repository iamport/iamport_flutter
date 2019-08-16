import 'package:flutter/material.dart';

import 'package:iamport_flutter/model/payment_data.dart';

import '../model/pg.dart';
import '../model/method.dart';
import '../model/quota.dart';

class PaymentTest extends StatefulWidget {
  @override
  _PaymentTestState createState() => _PaymentTestState();
}

class _PaymentTestState extends State<PaymentTest> {
  final _formKey = GlobalKey<FormState>();
  String pg = 'html5_inicis';   // PG사
  String pay_method = 'card';   // 결제수단
  String card_quota = '0';      // 할부개월수
  String vbank_due;             // 가상계좌 입금기한
  String biz_num;               // 사업자번호
  bool digital = false;         // 실물컨텐츠 여부
  bool escrow = false;          // 에스크로 여부
  String name;                  // 주문명
  String amount;                // 결제금액
  String merchant_uid;          // 주문번호
  String buyer_name;            // 구매자 이름
  String buyer_tel;             // 구매자 전화번호
  String buyer_email;           // 구매자 이메일

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('아임포트 결제 테스트'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField(
                decoration: InputDecoration(
                  labelText: 'PG사',
                ),
                value: pg,
                onChanged: (String value) {
                  setState(() {
                    pg = value;
                    pay_method = Method.getValueByPg(value);
                  });
                },
                items: Pg.getLists()
                  .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(Pg.getLabel(value)),
                    );
                  })
                  .toList(),
              ),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  labelText: '결제수단',
                ),
                value: pay_method,
                onChanged: (String value) {
                  setState(() {
                    pay_method = value;
                  });
                },
                items: Method.getListsByPg(pg)
                  .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(Method.getLabel(value)),
                    );
                  })
                  .toList(),
              ),
              pay_method == 'card' ?
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: '할부개월수',
                  ),
                  value: card_quota,
                  onChanged: (String value) {
                    setState(() {
                      card_quota = value;
                    });
                  },
                  items: Quota.getListsByPg(pg)
                    .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(Quota.getLabel(value)),
                      );
                    })
                    .toList(),
                ) : new Container(),
              pay_method == 'vbank' ? 
                TextFormField(
                  decoration: InputDecoration(
                    labelText: '입금기한',
                    hintText: 'YYYYMMDDhhmm',
                  ),
                  validator: (value) {
                    if (value.isEmpty)
                      return '입금기한은 필수입력입니다';
                    if (value.length > 0) {
                      Pattern pattern = r'^[0-9]+$';
                      RegExp regex = new RegExp(pattern);
                      if (!regex.hasMatch(value))
                        return '입금기한이 올바르지 않습니다.';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  onSaved: (String value) {
                    vbank_due = value;
                  },
                ) : new Container(),
              pay_method == 'vbank' && pg == 'danal_tpay' ?
                TextFormField(
                  decoration: InputDecoration(
                    labelText: '사업자번호',
                  ),
                  validator: (value) {
                    if (value.isEmpty)
                      return '사업자번호는 필수입력입니다';
                    if (value.length > 0) {
                      Pattern pattern = r'^[0-9]+$';
                      RegExp regex = new RegExp(pattern);
                      if (!regex.hasMatch(value))
                        return '사업자번호가 올바르지 않습니다.';
                      if (value.length != 10)
                        return '사업자번호는 10자리 숫자입니다.';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  onSaved: (String value) {
                    biz_num = value;
                  },
                ) : new Container(),
              TextFormField(
                decoration: InputDecoration(
                  labelText: '주문명',
                ),
                initialValue: '아임포트 결제 데이터 분석',
                validator: (value) => value.isEmpty ? '주문명은 필수입력입니다' : null,
                onSaved: (String value) {
                  name = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: '결제금액',
                ),
                initialValue: '39000',
                validator: (value) {
                  if (value.isEmpty) {
                    return '결제금액은 필수입력입니다.';
                  }
                  if (value.length > 0) {
                    Pattern pattern = r'^[0-9]+$';
                    RegExp regex = new RegExp(pattern);
                    if (!regex.hasMatch(value))
                      return '결제금액이 올바르지 않습니다.';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                onSaved: (String value) {
                  amount = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: '주문번호',
                ),
                validator: (value) => value.isEmpty ? '주문번호는 필수입력입니다' : null,
                initialValue: 'mid_${DateTime.now().millisecondsSinceEpoch}',
                onSaved: (String value) {
                  merchant_uid = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: '이름',
                ),
                initialValue: '홍길동',
                onSaved: (String value) {
                  buyer_name = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: '전화번호',
                ),
                initialValue: '01012341234',
                validator: (value) {
                  if (value.length > 0) {
                    Pattern pattern = r'^[0-9]+$';
                    RegExp regex = new RegExp(pattern);
                    if (!regex.hasMatch(value))
                      return '전화번호가 올바르지 않습니다.';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                onSaved: (String value) {
                  buyer_tel = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: '이메일',
                ),
                initialValue: 'example@example.com',
                keyboardType: TextInputType.emailAddress,
                onSaved: (String value) {
                  buyer_email = value;
                },
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 30.0, 0, 0),
                child: RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();

                      PaymentData data = PaymentData.fromJson({
                        'pg': pg,
                        'pay_method': pay_method,
                        'escrow': escrow,
                        'name': name,
                        'amount': int.parse(amount),
                        'merchant_uid': merchant_uid,
                        'buyer_name': buyer_name,
                        'buyer_tel': buyer_tel,
                        'buyer_email': buyer_email,
                      });
                      if (pay_method == 'card' && card_quota != '0') {
                        data.display = {
                          'card_quota': card_quota == '1' ? [] : [int.parse(card_quota)],
                        };
                      }

                      // 가상계좌의 경우, 입금기한 추가
                      if (pay_method == 'vbank') {
                        data.vbank_due = vbank_due;

                        // 다날 && 가상계좌의 경우, 사업자 등록번호 10자리 추가
                        if (pg == 'danal_tpay') {
                          data.biz_num = biz_num;
                        }
                      }

                      // 휴대폰 소액결제의 경우, 실물 컨텐츠 여부 추가
                      if (pay_method == 'phone') {
                        data.digital = digital;
                      }

                      // 정기결제의 경우, customer_uid 추가
                      if (pg == 'kcp_billing') {
                        data.customer_uid = 'cuid_${DateTime.now().millisecondsSinceEpoch}';
                      }

                      Navigator.pushNamed(
                        context,
                        '/payment',
                        arguments: data
                      );
                    }
                  },
                  child: Text('결제하기', style: TextStyle(fontSize: 20)),
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