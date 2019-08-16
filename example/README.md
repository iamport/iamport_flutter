# iamport_flutter_example

아임포트 리액트 네이티브 모듈 예제 안내입니다.

## 일반/정기결제 예제
```dart
import 'package:flutter/material.dart';

/* 아임포트 결제 모듈을 불러옵니다. */
import 'package:iamport_flutter/iamport_payment.dart';
/* 아임포트 결제 데이터 모델을 불러옵니다. */
import 'package:iamport_flutter/model/payment_data.dart';

class Payment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IamportPayment(
      appBar: new AppBar(
        title: new Text('아임포트 결제'),
      ),
      /* 웹뷰 로딩 컴포넌트 */
      initialChild: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/iamport-logo.png'),
              Container(
                padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                child: Text('잠시만 기다려주세요...', style: TextStyle(fontSize: 20.0)),
              ),
            ],
          ),
        ),
      ),
      /* [필수입력] 가맹점 식별코드 */
      userCode: 'iamport',
      /* [필수입력] 결제 데이터 */
      data: PaymentData.fromJson({
        'pg': 'html5_inicis',                                           // PG사
        'pay_method': 'card',                                           // 결제수단
        'name': '아임포트 결제데이터 분석',                                   // 주문명
        'merchant_uid': 'mid_${DateTime.now().millisecondsSinceEpoch}', // 주문번호
        'amount': '39000',                                              // 결제금액
        'buyer_name': '홍길동',                                           // 구매자 이름
        'buyer_tel': '01012345678',                                     // 구매자 연락처
        'buyer_email': 'example@naver.com',                             // 구매자 이메일
        'buyer_addr': '서울시 강남구 신사동 661-16',                         // 구매자 주소
        'buyer_postcode': '06018',                                      // 구매자 우편번호
        'app_scheme': 'example',                                        // 앱 URL scheme
      }),
      /* [필수입력] 콜백 함수 */
      callback: (Map<String, String> result) {
        Navigator.pushReplacementNamed(
          context,
          '/payment-result',
          arguments: result,
        );
      },
    );
  }
}
```

### IamportPayment 모델

| Prop             | Type          |  Description         | Required   |
| ---------------- | ------------- | -------------------- | ---------- |
| userCode         | String        | 가맹점 식별코드          | true       |
| initialChild     | 플러터 컴포넌트   | 웹뷰 로드시 보여질 컴포넌트 | false      |
| data             | `PaymentData` | 결제에 필요한 정보        | true       |
| callback         | function      | 결제 후 실행 될 함수      | true       |

### PaymentData 모델 [자세히보기](https://docs.iamport.kr/tech/imp#param)

| Key            | Type                     |  Description   | Required                 |
| -------------- | ------------------------ | -------------- | ------------------------ |
| pg             | String                   | PG사           | false                     |
| pay_method     | String                   | 결제수단         | false                     |
| display        | `Map<String, List<int>>` | 할부개월수        | false                     |
| vbank_due      | String                   | 가상계좌 입금기한   | false (가상계좌시 필수)       |
| biz_num        | String                   | 사업자번호        | false (다날 - 가상계좌시 필수) |
| digital        | bool                     | 실물컨텐츠 여부    | false (휴대폰 소액결제시 필수) |
| escrow         | bool                     | 에스크로 여부      | false                    |
| name           | String                   | 주문명           | true                     |
| amount         | int                      | 결제금액          | true                     |
| currency       | String                   | 화폐 단위         | false                    |
| custom_data    | Map<String, String>      | 임의 지정 데이터    | false                    |
| tax_free       | int                      | 면세 공급 가액     | false                    |
| vat            | int                      | 부가세            | false                    |
| language       | String                   | 결제 창 언어설정    | false                    |
| merchant_uid   | String                   | 주문번호          | true                     |
| buyer_name     | String                   | 구매자 이름       | false                     |
| buyer_tel      | String                   | 구매자 연락처      | false                     |
| buyer_email    | String                   | 구매자 이메일      | false                     |
| buyer_addr     | String                   | 구매자 주소        | false                     |
| buyer_postcode | String                   | 구매자 우편번호     | false                     |
| notice_url     | String                   | 웹훅 URL         | false                     |
| customer_uid   | String                   | 정기결제 카드정보   | false (정기결제시 필수)       |
| app_scheme     | String                   | 앱 스킴          | true                      |
| popup          | bool                     | 페이팔 팝업 여부    | false                    |
| naverPopupMode | bool                     | 네이버페이 팝업 여부 | false                    |

## 휴대폰 본인인증 예제
```dart
import 'package:flutter/material.dart';

/* 아임포트 휴대폰 본인인증 모듈을 불러옵니다. */
import 'package:iamport_flutter/iamport_certification.dart';
/* 아임포트 휴대폰 본인인증 데이터 모델을 불러옵니다. */
import 'package:iamport_flutter/model/certification_data.dart';

class Certification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IamportCertification(
      appBar: new AppBar(
        title: new Text('아임포트 본인인증'),
      ),
      /* 웹뷰 로딩 컴포넌트 */
      initialChild: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/iamport-logo.png'),
              Container(
                padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                child: Text('잠시만 기다려주세요...', style: TextStyle(fontSize: 20.0)),
              ),
            ],
          ),
        ),
      ),
      /* [필수입력] 가맹점 식별코드 */
      userCode: 'iamport',
      /* [필수입력] 본인인증 데이터 */
      data: CertificationData.fromJson({
        'merchantUid': 'mid_${DateTime.now().millisecondsSinceEpoch}', // 주문번호
        'company': '아임포트',                                            // 회사명 또는 URL
        'carrier': 'SKT',                                               // 통신사
        'name': '홍길동',                                                 // 이름
        'phone': '01012341234',                                         // 전화번호
      }),
      /* [필수입력] 콜백 함수 */
      callback: (Map<String, String> result) {
        Navigator.pushReplacementNamed(
          context,
          '/certification-result',
          arguments: result,
        );
      },
    );
  }
}
```

### IamportCertification 모델

| Prop          | Type                | Description                        | Required   |
| ------------- | ------------------- | ---------------------------------- | ---------- |
| userCode      | string              | 가맹점 식별코드                        | true       |
| initialChild  | 플러터 컴포넌트         | 웹뷰 로드시 보여질 컴포넌트               | false      |
| data          | `CertificationData` | 본인인증에 필요한 정보                   | true       |
| callback      | function            | 본인인증 후 실행 될 함수                 | true       |

### CertificationData 모델 [자세히보기](https://docs.iamport.kr/tech/mobile-authentication#call-authentication)

| Key          | Type   |  Description    | Required |
| ------------ | ------ | --------------- | -------- |
| merchantUid  | String | 주문번호          | true     |
| company      | String | 회사명 또는 URL    | false    |
| carrier      | String | 통신사            | false    |
|              |        | - `SKT`: SKT    |          |
|              |        | - `KTF`: KT     |          |
|              |        | - `LGT`: LGU+   |          |
|              |        | - `MVNO`: 알뜰폰  |          |
| name         | String | 본인인증 할 이름    | false    |
| phone        | String | 본인인증 할 전화번호 | false    |
| minAge       | int    | 허용 최소 만 나이   | false    |
