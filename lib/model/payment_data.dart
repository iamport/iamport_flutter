import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:iamport_flutter/model/pg/naver/naver_interface.dart';
import 'package:iamport_flutter/model/pg/naver/naver_products.dart';

import './url_data.dart';

@jsonSerializable
@Json(ignoreNullMembers: true)
class PaymentData {
  String? pg; // PG사

  @JsonProperty(name: 'pay_method')
  String payMethod; // 결제수단

  bool? escrow; // 에스크로 여부

  @JsonProperty(name: 'merchant_uid')
  String merchantUid; // 주문번호

  String? name; // 주문명
  int amount; // 결제금액

  @JsonProperty(name: 'custom_data')
  Map<String, String>? customData; // 임의 지정 데이터

  @JsonProperty(name: 'tax_free')
  int? taxFree; // 면세 공급 가액

  int? vat; // 부가세
  String? currency; // 화폐단위
  String? language; // 언어설정

  @JsonProperty(name: 'buyer_name')
  String? buyerName; // 구매자 이름

  @JsonProperty(name: 'buyer_tel')
  String buyerTel; // 구매자 연락처

  @JsonProperty(name: 'buyer_email')
  String? buyerEmail; // 구매자 이메일

  @JsonProperty(name: 'buyer_addr')
  String? buyerAddr; // 구매자 주소

  @JsonProperty(name: 'buyer_postcode')
  String? buyerPostcode; // 구매자 우편번호

  @JsonProperty(name: 'notice_url')
  String? noticeUrl;

  @JsonProperty(name: 'display/card_quota')
  List<int>? displayCardQuota; // 할부개월수
  bool? digital; // 실물컨텐츠 여부

  @JsonProperty(name: 'vbank_due')
  String? vbankDue; // 가상계좌 입금기한

  @JsonProperty(name: 'm_redirect_url')
  String? mRedirectUrl;

  @JsonProperty(name: 'app_scheme')
  String appScheme; // 앱 스킴

  @JsonProperty(name: 'biz_num')
  String? bizNum; // 사업자번호

  @JsonProperty(name: 'customer_uid')
  String? customerUid; // 정기결제 카드정보

  bool? popup; // 페이팔 팝업 여부
  String? naverUseCfm; // 네이버페이 이용완료일
  bool? naverPopupMode; // 네이버페이 팝업 여부
  List<NaverProducts>? naverProducts; // 네이버 상품정보
  bool? naverCultureBenefit;
  String? naverProductCode;
  String? naverActionType;
  NaverInterface? naverInterface;
  Map<String, String>? period; // [이니시스. 다날. 나이스] 서비스 제공기간 표기
  String? company; // [다날 - 휴대폰 소액결제 전용] 주문명: (company) name 대비
  bool? niceMobileV2 = true;

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
    this.digital,
    this.vbankDue,
    this.mRedirectUrl = UrlData.redirectUrl,
    required this.appScheme,
    this.bizNum,
    this.customerUid,
    this.popup,
    this.naverUseCfm,
    this.naverPopupMode,
    this.naverProducts,
    this.naverCultureBenefit,
    this.naverProductCode,
    this.naverActionType,
    this.naverInterface,
    this.period,
    this.company,
    this.niceMobileV2,
  });
}
