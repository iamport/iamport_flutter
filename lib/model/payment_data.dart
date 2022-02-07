import 'package:iamport_flutter/model/pg/naver/naver_interface.dart';
import 'package:iamport_flutter/model/pg/naver/naver_products.dart';
import 'package:iamport_flutter/model/url_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment_data.g.dart';

@JsonSerializable()
class PaymentData {
  /// PG사
  ///
  /// 하나의 아임포트계정으로 여러 PG를 사용할 때 구분자.
  /// 누락되거나 매칭되지 않는 경우 관리자 콘솔에서 설정한 기본PG가 호출됨.
  ///
  /// 값 형식: [PG사 코드값] 또는 [PG사 코드값].[PG사 상점아이디]
  ///
  /// - html5_inicis(이니시스웹표준)
  /// - inicis(이니시스ActiveX결제창)
  /// - kcp(NHN KCP)
  /// - kcp_billing(NHN KCP 정기결제)
  /// - uplus(토스페이먼츠(구 LG U+))
  /// - nice(나이스페이)
  /// - jtnet(JTNet)
  /// - kicc(한국정보통신)
  /// - bluewalnut(블루월넛)
  /// - kakaopay(카카오페이)
  /// - danal(다날휴대폰소액결제)
  /// - danal_tpay(다날일반결제)
  /// - mobilians(모빌리언스 휴대폰소액결제)
  /// - chai(차이 간편결제)
  /// - syrup(시럽페이)
  /// - payco(페이코)
  /// - paypal(페이팔)
  /// - eximbay(엑심베이)
  /// - naverpay(네이버페이-결제형)
  /// - naverco(네이버페이-주문형)
  /// - smilepay(스마일페이)
  /// - alipay(알리페이)
  /// - paymentwall(페이먼트월)
  /// - payple(페이플)
  /// - eximbay(엑심베이)
  /// - tosspay(토스간편결제)
  /// - smartro(스마트로)
  /// - settle(세틀뱅크)
  String? pg;

  /// 결제수단
  ///
  /// - `card`(신용카드)
  /// - `trans`(실시간계좌이체)
  /// - `vbank`(가상계좌)
  /// - `phone`(휴대폰소액결제)
  /// - `samsung`(삼성페이 / 이니시스, KCP 전용)
  /// - `kpay`(KPay앱 직접호출 / 이니시스 전용)
  /// - `kakaopay`(카카오페이 직접호출 / 이니시스, KCP, 나이스페이먼츠 전용)
  /// - `payco`(페이코 직접호출 / 이니시스, KCP 전용)
  /// - `lpay`(LPAY 직접호출 / 이니시스 전용)
  /// - `ssgpay`(SSG페이 직접호출 / 이니시스 전용)
  /// - `tosspay`(토스간편결제 직접호출 / 이니시스 전용)
  /// - `cultureland`(문화상품권 / 이니시스, 토스페이먼츠(구 LG U+), KCP 전용)
  /// - `smartculture`(스마트문상 / 이니시스, 토스페이먼츠(구 LG U+), KCP 전용)
  /// - `happymoney`(해피머니 / 이니시스, KCP 전용)
  /// - `booknlife`(도서문화상품권 / 토스페이먼츠(구 LG U+), KCP 전용)
  /// - `point`(베네피아 포인트 등 포인트 결제 / KCP 전용)
  /// - `wechat`(위쳇페이 / 엑심베이 전용)
  /// - `alipay`(알리페이 / 엑심베이 전용)
  /// - `unionpay`(유니온페이 / 엑심베이 전용)
  /// - `tenpay`(텐페이 / 엑심베이 전용)
  @JsonKey(name: 'pay_method')
  String payMethod;

  /// 에스크로가 적용되는 결제창을 호출할지 여부
  bool? escrow;

  /// 가맹점에서 생성/관리하는 고유 주문번호
  ///
  /// 이미 결제가 승인 된(status: paid) merchant_uid로는 재결제 불가
  @JsonKey(name: 'merchant_uid')
  String merchantUid;

  /// 주문명
  ///
  /// 원활한 결제정보 확인을 위해 입력 권장
  ///
  /// PG사마다 차이가 있지만, 16자이내로 작성 권장
  String? name;

  /// 결제할 금액
  int amount;

  /// 가맹점 임의 지정 데이터
  ///
  /// 주문건에 대해 부가정보를 저장할 공간이 필요할 때 사용
  @JsonKey(name: 'custom_data')
  Map<String, String>? customData;

  /// [amount] 중 면세공급가액에 해당하는 금액
  ///
  /// [자세히보기](https://docs.iamport.kr/tech/vat?lang=ko)
  @JsonKey(name: 'tax_free')
  int? taxFree;

  /// [amount] 중 부가세 금액
  ///
  /// 복합과세 적용시 더 정확한 계산을 위해 tax_free 파라미터 사용을 권장
  @deprecated
  int? vat;

  /// 통화 설정
  ///
  /// PayPal은 원화(KRW) 미지원으로 USD가 기본값
  ///
  /// PayPal에서 지원하는 통화는 [PayPal 지원 통화](https://developer.paypal.com/docs/reports/reference/paypal-supported-currencies/%20target=/) 참조
  ///
  /// - KRW
  /// - USD
  /// - EUR
  /// - JPY
  String? currency;

  /// 결제창 화면의 언어 설정
  ///
  /// - KG이니시스, 토스페이먼츠(구 LG U+), 나이스페이먼츠 : `en` 또는 `ko`(KG이니시스, 나이스
  /// 페이먼츠는 PC 결제창만 지원됨)
  /// - PayPal: 2자리 region code[(PayPal 로케일 코드 참조)](https://developer.paypal.com/api/rest/reference/locale-codes/)
  String? language;

  /// 주문자명
  @JsonKey(name: 'buyer_name')
  String? buyerName;

  /// 주문자 연락처
  ///
  /// (누락되거나 공백일때 일부 PG사[엑심베이]에서 오류 발생)
  @JsonKey(name: 'buyer_tel')
  String buyerTel;

  /// 주문자 이메일[페이먼트월 필수]
  @JsonKey(name: 'buyer_email')
  String? buyerEmail;

  /// 주문자 주소
  @JsonKey(name: 'buyer_addr')
  String? buyerAddr;

  /// 주문자 우편번호
  @JsonKey(name: 'buyer_postcode')
  String? buyerPostcode;

  /// 관리자 콘솔에서 설정하는 Notification URL대신 사용할 URL
  ///
  /// 주문마다 다른 혹은 복수의 Notification URL이 필요한 경우 사용
  @JsonKey(name: 'notice_url')
  String? noticeUrl;

  /// 50,000원 이상 금액 결제 시, 할부개월 수 선택 요소 제어 옵션
  ///
  /// - 미입력: PG사의 기본 할부개월 수 목록 제공
  /// - `[]`: 일시불만 결제 가능
  /// - `2,3,4,5,6`: 일시불을 포함한 2, 3, 4, 5, 6개월까지 할부개월 선택 가능(KG이니시스, KCP
  /// 만 지원)
  @JsonKey(name: 'display/card_quota')
  List<int>? displayCardQuota;

  /// 결제상품이 컨텐츠인지 여부(휴대폰 소액결제시 필수)
  ///
  /// 반드시 실물/컨텐츠를 정확히 구분해주어야 함
  bool? digital;

  /// 가상계좌 입금기한(`YYYYMMDDhhmm`)
  @JsonKey(name: 'vbank_due')
  String? vbankDue;

  /// 리디렉션 방식으로 호출된 결제창에서 결제 후에 이동 될 주소
  @JsonKey(name: 'm_redirect_url')
  String? mRedirectUrl;

  /// 모바일 앱 결제중 앱복귀를 위한 URL scheme(WebView 결제시 필수)
  ///
  /// ISP/앱카드 앱에서 결제정보인증 후 기존 앱으로 복귀할 때 사용됨
  @JsonKey(name: 'app_scheme')
  String appScheme;

  /// 계약된 사업자등록번호 10자리(기호 미포함)
  ///
  /// 다날-가상계좌 결제시 필수 항목
  @JsonKey(name: 'biz_num')
  String? bizNum;

  @JsonKey(name: 'customer_uid')
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
    @deprecated this.vat,
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

  factory PaymentData.fromJson(Map<String, dynamic> json) =>
      _$PaymentDataFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentDataToJson(this);
}
