# iamport_flutter_example

아임포트 플러터 모듈 예제 안내입니다.

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
        'pg': 'html5_inicis',                                          // PG사
        'payMethod': 'card',                                           // 결제수단
        'name': '아임포트 결제데이터 분석',                                  // 주문명
        'merchantUid': 'mid_${DateTime.now().millisecondsSinceEpoch}', // 주문번호
        'amount': 39000,                                               // 결제금액
        'buyerName': '홍길동',                                           // 구매자 이름
        'buyerTel': '01012345678',                                     // 구매자 연락처
        'buyerEmail': 'example@naver.com',                             // 구매자 이메일
        'buyerAddr': '서울시 강남구 신사동 661-16',                         // 구매자 주소
        'buyerPostcode': '06018',                                      // 구매자 우편번호
        'appScheme': 'example',                                        // 앱 URL scheme
        'display': {
          'cardQuota' : [2,3]                                          //결제창 UI 내 할부개월수 제한
        }
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

| Prop             | Type                |  Description         | Required   |
| ---------------- | ------------------- | -------------------- | ---------- |
| appBar           | PreferredSizeWidget | 앱 네비게이션 헤더 바     | false      |
| userCode         | String              | 가맹점 식별코드          | true       |
| initialChild     | 플러터 컴포넌트         | 웹뷰 로드시 보여질 컴포넌트 | false      |
| data             | `PaymentData`       | 결제에 필요한 정보        | true       |
| callback         | function            | 결제 후 실행 될 함수      | true       |

### PaymentData 모델 [자세히보기](https://docs.iamport.kr/tech/imp#param)

| Key            | Type                     |  Description   | Required                 |
| -------------- | ------------------------ | -------------- | ------------------------ |
| pg             | String                   | PG사           | false                     |
| payMethod      | String                   | 결제수단         | false                     |
| display        | `Map<String, List<int>>` | 할부개월수        | false                     |
| vbankDue       | String                   | 가상계좌 입금기한   | false (가상계좌시 필수)       |
| bizNum         | String                   | 사업자번호        | false (다날 - 가상계좌시 필수) |
| digital        | bool                     | 실물컨텐츠 여부    | false (휴대폰 소액결제시 필수) |
| escrow         | bool                     | 에스크로 여부      | false                    |
| name           | String                   | 주문명           | true                     |
| amount         | int                      | 결제금액          | true                     |
| currency       | String                   | 화폐 단위         | false                    |
| customData     | Map<String, String>      | 임의 지정 데이터    | false                    |
| taxFree        | int                      | 면세 공급 가액     | false                    |
| vat            | int                      | 부가세            | false                    |
| language       | String                   | 결제 창 언어설정    | false                    |
| merchantUid    | String                   | 주문번호          | true                     |
| buyerName      | String                   | 구매자 이름       | false                     |
| buyerTel       | String                   | 구매자 연락처      | false                     |
| buyerEmail     | String                   | 구매자 이메일      | false                     |
| buyerAddr      | String                   | 구매자 주소        | false                     |
| buyerPostcode  | String                   | 구매자 우편번호     | false                     |
| noticeUrl      | String                   | 웹훅 URL         | false                     |
| customerUid    | String                   | 정기결제 카드정보   | false (정기결제시 필수)       |
| appScheme      | String                   | 앱 스킴          | true                      |
| popup          | bool                     | 페이팔 팝업 여부    | false                    |
| naverPopupMode | bool                     | 네이버페이 팝업 여부 | false                    |
| `period`       | Map<String, String>      | 다날 - 신용카드/계좌이체/가상계좌 전용 제공기간 | false |
| `company`      | String                   | 다날 - 휴대폰 소액결제 전용 주문명 앞 괄호 안 텍스트 | false |

### period
이니시스, 나이스 그리고 다날 신용카드/계좌이체/가상계좌 결제시 제공기간 표기를 위한 파라미터입니다. 제공기간 시작 날짜(`from`)와 끝 날짜(`to`)를 아래와 같이 `YYYYMMDD` 형태로 넘겨주세요. 

| key  | Type             | Description   |
| ---- | ---------------- | ------------- |
| from | String(YYYYMMDD) | 제공기간 시작 날짜 |
| to   | String(YYYYMMDD) | 제공기간 종료날짜  |

```dart
data: PaymentData.fromJson({
  ...
  period: { // 제공기간 2020년 1월 1일 ~ 2020년 12월 31일
    from: '20200101', // 제공기간 시작 날짜
    to: '20201231', // 제공기간 종료 날짜
  },
}),
```

### company
다날 휴대폰 소액결제시 주문명 앞 괄호 안 텍스트에 표기될 회사명을 위한 파라미터입니다. 결제창 내 주문명은 `(회사명) 주문명`과 같이 표기되며, 누락시 `(주문명) 주문명`과 같이 표기됩니다.

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

| Prop          | Type                | Description          | Required   |
| ------------- | ------------------- | -------------------- | ---------- |
| appBar        | PreferredSizeWidget | 앱 네비게이션 헤더 바     | false      |
| userCode      | string              | 가맹점 식별코드          | true       |
| initialChild  | 플러터 컴포넌트         | 웹뷰 로드시 보여질 컴포넌트 | false      |
| data          | `CertificationData` | 본인인증에 필요한 정보     | true       |
| callback      | function            | 본인인증 후 실행 될 함수   | true       |

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
