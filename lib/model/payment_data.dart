import 'dart:convert';

import './iamport_url.dart';

class PaymentData {
  String pg; // PG사
  String payMethod; // 결제수단
  Map<String, List<int>> display; // 할부개월수
  String vbankDue; // 가상계좌 입금기한
  String bizNum; // 사업자번호
  bool digital; // 실물컨텐츠 여부
  bool escrow; // 에스크로 여부
  String name; // 주문명
  int amount; // 결제금액
  String currency; // 화폐단위
  Map<String, String> customData; // 임의 지정 데이터
  int taxFree; // 면세 공급 가액
  int vat; // 부가세
  String language; // 언어설정
  String merchantUid; // 주문번호
  String buyerName; // 구매자 이름
  String buyerTel; // 구매자 연락처
  String buyerEmail; // 구매자 이메일
  String buyerAddr; // 구매자 주소
  String buyerPostcode; // 구매자 우편번호
  String noticeUrl;
  String customerUid; // 정기결제 카드정보
  String appScheme; // 앱 스킴
  bool popup; // 페이팔 팝업 여부
  bool naverPopupMode; // 네이버페이 팝업 여부
  Map<String, String> period; // [이니시스. 다날. 나이스] 서비스 제공기간 표기
  String company; // [다날 - 휴대폰 소액결제 전용] 주문명: (company) name 대비

  PaymentData(
    this.pg,
    this.payMethod,
    this.display,
    this.vbankDue,
    this.bizNum,
    this.digital,
    this.escrow,
    this.name,
    this.amount,
    this.currency,
    this.customData,
    this.taxFree,
    this.vat,
    this.language,
    this.merchantUid,
    this.buyerName,
    this.buyerTel,
    this.buyerEmail,
    this.buyerAddr,
    this.buyerPostcode,
    this.noticeUrl,
    this.customerUid,
    this.appScheme,
    this.popup,
    this.naverPopupMode,
    this.period,
    this.company,
  );

  PaymentData.fromJson(Map<String, dynamic> data)
      : pg = data['pg'],
        payMethod = data['payMethod'],
        display = data['display'],
        vbankDue = data['vbankDue'],
        bizNum = data['bizNum'],
        digital = data['digital'],
        escrow = data['escrow'],
        name = data['name'],
        amount = data['amount'],
        currency = data['currency'],
        customData = data['customData'],
        taxFree = data['taxFree'],
        vat = data['vat'],
        language = data['language'],
        merchantUid = data['merchantUid'],
        buyerName = data['buyerName'],
        buyerTel = data['buyerTel'],
        buyerEmail = data['buyerEmail'],
        buyerAddr = data['buyerAddr'],
        buyerPostcode = data['buyerPostcode'],
        noticeUrl = data['noticeUrl'],
        customerUid = data['customerUid'],
        appScheme = data['appScheme'],
        popup = data['popup'],
        naverPopupMode = data['naverPopupMode'],
        period = data['period'],
        company = data['company'];

  String toJsonString() {
    Map<String, dynamic> jsonData = {
      'pg': pg,
      'pay_method': payMethod,
      'name': name,
      'amount': amount,
      'merchant_uid': merchantUid,
      'buyer_name': buyerName,
      'buyer_tel': buyerTel,
      'buyer_email': buyerEmail,
      'm_redirect_url': IamportUrl.redirectUrl,
      'app_scheme': appScheme,
      'niceMobileV2': true,
    };

    if (escrow != null) {
      jsonData['escrow'] = escrow;
    }
    if (currency != null) {
      jsonData['currency'] = currency;
    }
    if (taxFree != null) {
      jsonData['tax_free'] = taxFree;
    }
    if (vat != null) {
      jsonData['vat'] = vat;
    }
    if (customData != null) {
      jsonData['custom_data'] = customData;
    }
    if (language != null) {
      jsonData['language'] = language;
    }
    if (display != null) {
      jsonData['display'] = {
        'card_quota': display['cardQuota'],
      };
    }
    if (vbankDue != null) {
      jsonData['vbank_due'] = vbankDue;
    }
    if (bizNum != null) {
      jsonData['biz_num'] = bizNum;
    }
    if (digital != null) {
      jsonData['digital'] = digital;
    }
    if (noticeUrl != null) {
      jsonData['notice_url'] = noticeUrl;
    }
    if (buyerAddr != null) {
      jsonData['buyer_addr'] = buyerAddr;
    }
    if (buyerPostcode != null) {
      jsonData['buyer_postcode'] = buyerPostcode;
    }
    if (customerUid != null) {
      jsonData['customer_uid'] = customerUid;
    }
    if (popup != null) {
      jsonData['popup'] = popup;
    }
    if (naverPopupMode != null) {
      jsonData['naverPopupMode'] = naverPopupMode;
    }
    if (period != null) {
      jsonData['period'] = period;
    }
    if (company != null) {
      jsonData['company'] = company;
    }

    return jsonEncode(jsonData);
  }
}
