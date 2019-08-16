import 'dart:convert';

import './iamport_url.dart';

class PaymentData {
  String pg;                        // PG사
  String pay_method;                // 결제수단
  Map<String, List<int>> display;   // 할부개월수
  String vbank_due;                 // 가상계좌 입금기한
  String biz_num;                   // 사업자번호
  bool digital;                     // 실물컨텐츠 여부
  bool escrow;                      // 에스크로 여부
  String name;                      // 주문명
  int amount;                       // 결제금액
  String currency;                  // 화폐단위
  Map<String, Future> custom_data;  // 임의 지정 데이터
  int tax_free;                     // 면세 공급 가액
  int vat;                          // 부가세
  String language;                  // 언어설정
  String merchant_uid;              // 주문번호
  String buyer_name;                // 구매자 이름
  String buyer_tel;                 // 구매자 연락처
  String buyer_email;               // 구매자 이메일
  String buyer_addr;                // 구매자 주소
  String buyer_postcode;            // 구매자 우편번호
  String notice_url;
  String customer_uid;              // 정기결제 카드정보
  String app_scheme;                // 앱 스킴
  bool popup;                       // 페이팔 팝업 여부
  bool naverPopupMode;              // 네이버페이 팝업 여부

  PaymentData(
    this.pg,
    this.pay_method,
    this.display,
    this.vbank_due,
    this.biz_num,
    this.digital,
    this.escrow,
    this.name,
    this.amount,
    this.currency,
    this.custom_data,
    this.tax_free,
    this.vat,
    this.language,
    this.merchant_uid,
    this.buyer_name,
    this.buyer_tel,
    this.buyer_email,
    this.buyer_addr,
    this.buyer_postcode,
    this.notice_url,
    this.customer_uid,
    this.app_scheme,
    this.popup,
    this.naverPopupMode,
  );

  PaymentData.fromJson(Map<String, dynamic> data) :
    pg = data['pg'],
    pay_method = data['pay_method'],
    display = data['display'],
    vbank_due = data['vbank_due'],
    biz_num = data['biz_num'],
    digital = data['digital'],
    escrow = data['escrow'],
    name = data['name'],
    amount = data['amount'],
    merchant_uid = data['merchant_uid'],
    buyer_name = data['buyer_name'],
    buyer_tel = data['buyer_tel'],
    buyer_email = data['buyer_email'],
    customer_uid = data['customer_uid'],
    app_scheme = data['app_scheme'];

  String toJsonString() {
    Map<String, dynamic> jsonData =  {
      'pg': pg,
      'pay_method': pay_method,
      'escrow': escrow,
      'name': name,
      'amount': amount,
      'merchant_uid': merchant_uid,
      'buyer_name': buyer_name,
      'buyer_tel': buyer_tel,
      'buyer_email': buyer_email,
      'buyer_addr': buyer_addr,
      'buyer_postcode': buyer_postcode,
      'm_redirect_url': IamportUrl.redirectUrl,
      'app_scheme': app_scheme,
    };

    if (currency != null) {
      jsonData['currency'] = currency;
    }
    if (tax_free != null) {
      jsonData['tax_free'] = tax_free;
    }
    if (vat != null) {
      jsonData['vat'] = vat;
    }
    if (custom_data != null) {
      jsonData['custom_data'] = custom_data;
    }
    if (language != null) {
      jsonData['language'] = language;
    }
    if (display != null) {
      jsonData['display'] = display;
    }
    if (vbank_due != null) {
      jsonData['vbank_due'] = vbank_due;
    }
    if (biz_num != null) {
      jsonData['biz_num'] = biz_num;
    }
    if (digital != null) {
      jsonData['digital'] = digital;
    }
    if (notice_url != null) {
      jsonData['notice_url'] = notice_url;
    }
    if (customer_uid != null) {
      jsonData['customer_uid'] = customer_uid;
    }

    return jsonEncode(jsonData);
  }
}
