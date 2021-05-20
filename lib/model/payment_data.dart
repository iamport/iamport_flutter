import 'dart:convert';
import './url_data.dart';

class PaymentData {
  String? pg; // PG사
  String payMethod; // 결제수단
  bool? escrow; // 에스크로 여부
  String merchantUid; // 주문번호
  String? name; // 주문명
  int amount; // 결제금액
  Map<String, String>? customData; // 임의 지정 데이터
  int? taxFree; // 면세 공급 가액
  int? vat; // 부가세
  String? currency; // 화폐단위
  String? language; // 언어설정
  String? buyerName; // 구매자 이름
  String buyerTel; // 구매자 연락처
  String? buyerEmail; // 구매자 이메일
  String? buyerAddr; // 구매자 주소
  String? buyerPostcode; // 구매자 우편번호
  String? noticeUrl;
  Map<String, List<int>>? display; // 할부개월수
  bool? digital; // 실물컨텐츠 여부
  String? vbankDue; // 가상계좌 입금기한
  String? mRedirectUrl = UrlData.redirectUrl;
  String appScheme; // 앱 스킴
  String? bizNum; // 사업자번호
  String? customerUid; // 정기결제 카드정보
  bool? popup; // 페이팔 팝업 여부
  String? naverUseCfm; // 네이버페이 이용완료일
  bool? naverPopupMode; // 네이버페이 팝업 여부
  List<NaverProduct>? naverProducts; // 네이버 상품정보
  Map<String, String>? period; // [이니시스. 다날. 나이스] 서비스 제공기간 표기
  String? company; // [다날 - 휴대폰 소액결제 전용] 주문명: (company) name 대비
  bool niceMobileV2 = true;

  PaymentData({
    this.pg,
    required this.payMethod,
    this.escrow,
    required this.merchantUid,
    this.name,
    required this.amount,
    this.customData,
    this.taxFree,
    this.vat,
    this.currency,
    this.language,
    this.buyerName,
    required this.buyerTel,
    this.buyerEmail,
    this.buyerAddr,
    this.buyerPostcode,
    this.noticeUrl,
    this.display,
    this.digital,
    this.vbankDue,
    this.mRedirectUrl,
    required this.appScheme,
    this.bizNum,
    this.customerUid,
    this.popup,
    this.naverUseCfm,
    this.naverPopupMode,
    this.naverProducts,
    this.period,
    this.company,
    required this.niceMobileV2,
  });

  PaymentData.fromJson(Map<String, dynamic> data)
      : pg = data['pg'],
        payMethod = data['payMethod'],
        escrow = data['escrow'],
        merchantUid = data['merchantUid'],
        name = data['name'],
        amount = data['amount'],
        customData = data['customData'],
        taxFree = data['taxFree'],
        vat = data['vat'],
        currency = data['currency'],
        language = data['language'],
        buyerName = data['buyerName'],
        buyerTel = data['buyerTel'],
        buyerEmail = data['buyerEmail'],
        buyerAddr = data['buyerAddr'],
        buyerPostcode = data['buyerPostcode'],
        noticeUrl = data['noticeUrl'],
        display = data['display'],
        digital = data['digital'],
        vbankDue = data['vbankDue'],
        mRedirectUrl = data['mRedirectUrl'],
        bizNum = data['bizNum'],
        customerUid = data['customerUid'],
        appScheme = data['appScheme'],
        popup = data['popup'],
        naverUseCfm = data['naverUseCfm'],
        naverPopupMode = data['naverPopupMode'],
        naverProducts = data['naverProducts'],
        period = data['period'],
        company = data['company'],
        niceMobileV2 = data['niceMobileV2'];

  String toJsonString() {
    Map<String, dynamic> jsonData = {
      'pay_method': payMethod,
      'merchant_uid': merchantUid,
      'amount': amount,
      'buyer_tel': buyerTel,
      'app_scheme': appScheme,
      'niceMobileV2': niceMobileV2,
    };

    if (pg != null) jsonData['pg'] = pg;

    if (escrow != null) jsonData['escrow'] = escrow;

    if (name != null) jsonData['name'] = name;

    if (customData != null) jsonData['custom_data'] = customData;

    if (taxFree != null) jsonData['tax_free'] = taxFree;

    if (vat != null) jsonData['vat'] = vat;

    if (currency != null) jsonData['currency'] = currency;

    if (language != null) jsonData['language'] = language;

    if (buyerName != null) jsonData['buyer_name'] = buyerName;

    if (buyerEmail != null) jsonData['buyer_email'] = buyerEmail;

    if (buyerAddr != null) jsonData['buyer_addr'] = buyerAddr;

    if (buyerPostcode != null) jsonData['buyer_postcode'] = buyerPostcode;

    if (noticeUrl != null) jsonData['notice_url'] = noticeUrl;

    if (display != null) {
      jsonData['display'] = {
        'card_quota': display!['cardQuota'],
      };
    }

    if (digital != null) jsonData['digital'] = digital;

    if (vbankDue != null) jsonData['vbank_due'] = vbankDue;

    if (mRedirectUrl != null) jsonData['m_redirect_url'] = mRedirectUrl;

    if (bizNum != null) jsonData['biz_num'] = bizNum;

    if (customerUid != null) jsonData['customer_uid'] = customerUid;

    if (popup != null) jsonData['popup'] = popup;

    if (naverUseCfm != null) jsonData['naverUseCfm'] = naverUseCfm;

    if (naverPopupMode != null) jsonData['naverPopupMode'] = naverPopupMode;

    if (naverProducts != null) {
      List<Map<String, dynamic>> list = [];
      for (int i = 0; i < naverProducts!.length; i++) {
        Map<String, dynamic> data = {
          'categoryType': naverProducts![i].categoryType,
          'categoryId': naverProducts![i].categoryId,
          'uid': naverProducts![i].uid,
          'name': naverProducts![i].name,
          'count': naverProducts![i].count,
          'payReferrer': naverProducts![i].payReferrer,
        };
        list.add(data);
      }
      jsonData['naverProducts'] = list;
    }

    if (period != null) jsonData['period'] = period;

    if (company != null) jsonData['company'] = company;

    return jsonEncode(jsonData);
  }
}

class NaverProduct {
  String categoryType;
  String categoryId;
  String uid;
  String name;
  String count;
  String? payReferrer;

  NaverProduct({
    required this.categoryType,
    required this.categoryId,
    required this.uid,
    required this.name,
    required this.count,
    this.payReferrer,
  });
}
