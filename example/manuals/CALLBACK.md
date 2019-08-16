# 콜백 함수 설정하기
아임포트 플러터 모듈 콜백 함수 설정을 위한 안내입니다.

콜백 함수는 필수입력 필드로, 결제/본인인증 완료 후 라우트를 이동하도록 로직을 작성해야합니다. 아래와 같이 [push](https://api.flutter.dev/flutter/widgets/Navigator/push.html) 함수가 아닌 [pushReplacementNamed](https://api.flutter.dev/flutter/widgets/Navigator/pushReplacementNamed.html) 함수를 사용해야 합니다.
`push` 함수를 사용할 경우, 결제/본인인증 완료 후 라우터가 변경되더라도 유저가 뒤로가기를 하면 아임포트 모듈이 다시 렌더링됩니다. 하지만 `pushReplacementNamed` 함수를 사용하면, 결제/본인인증 직전 화면으로 넘어가게 됩니다.

### 잘못된 사용 예제
```dart
callback: (Map<String, String> result) {
  Navigator.push(
    context,
    '/result',
    arguments: result,
  );
},
```

### 올바른 사용 예제
```dart
callback: (Map<String, String> result) {
  Navigator.pushReplacementNamed(
    context,
    '/result',
    arguments: result,
  );
},
```

### 결과에 따라 로직 작성하기
콜백 함수의 첫번째 인자(result)는 결제/본인인증 결과를 담고 있는 오브젝트로 아래와 같이 구성되어 있습니다. 자세한 내용은 아임포트 공식 문서 [IMP.request_pay - param, rsp 객체 - Callback 함수의 rsp 객제](https://docs.iamport.kr/tech/imp#callback)를 참고해주세요.

| key           |  Description       | 
| ------------- | ------------------ | 
| success       | 성공 여부            |
| imp_uid       | 아임포트 번호         |
| merchant_uid  | 주문번호             |
| error_msg     | 실패한 경우, 에러메시지  |

response에 따라 결제/본인인증 성공/실패 여부를 판단해 아래와 같이 각기 다른 로직을 구성할 수 있습니다. 아래 코드는 예시일 뿐 실제 결제 성공/실패여부는 결제 유효성 검사 후 아임포트 REST API로 결제내역을 조회해 판단해야 합니다. 자세한 내용은 아임포트 공식 문서 [일반결제 연동하기 - STEP5. 서버에서 거래 검증 및 데이터 동기화](https://docs.iamport.kr/implementation/payment#server-side-logic)를 참고해주세요.

```dart
import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  bool getIsSuccessed(Map<String, String> result) {
    if (result['imp_success'] == 'true') {
      return true;
    }
    if (result['success'] == 'true') {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    Map<String, String> result = ModalRoute.of(context).settings.arguments;
    bool isSuccessed = getIsSuccessed(result);

    return Scaffold(
      appBar: new AppBar(
        title: Text('아임포트 결과'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message: isSuccessed ? '성공하였습니다' : '실패하였습니다',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(50.0, 30.0, 50.0, 50.0),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(0, 5.0, 0, 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text('아임포트 번호', style: TextStyle(color: Colors.grey))
                      ),
                      Expanded(
                        flex: 5,
                        child: Text(result['imp_uid'] ?? '-'),
                      ),
                    ],
                  ),
                ),
                isSuccessed ? Container(
                  padding: EdgeInsets.fromLTRB(0, 5.0, 0, 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text('주문 번호', style: TextStyle(color: Colors.grey))
                      ),
                      Expanded(
                        flex: 5,
                        child: Text(result['merchant_uid'] ?? '-'),
                      ),
                    ],
                  ),
                ) : Container(
                  padding: EdgeInsets.fromLTRB(0, 5.0, 0, 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text('에러 메시지', style: TextStyle(color: Colors.grey)),
                      ),
                      Expanded(
                        flex: 5,
                        child: Text(result['error_msg'] ?? '-'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
```