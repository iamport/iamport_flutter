## [0.10.1](https://github.com/iamport/iamport_flutter/tree/master)
- 안드로이드 12에서 웹뷰에서 키보드가 나타니지 않는 문제를 해결했습니다.
- 임의의 m_redirect_url을 받고 처리할 수 있도록 수정했습니다.
- 본인인증시 팝업 파라미터를 추가했습니다.(명시적 false 필요할 경우 사용)

## [0.10.0](https://github.com/iamport/iamport_flutter/tree/v0.10.0)
- 예제 UI를 개선했습니다.
- 로딩 컴포넌트가 보이지 않는 문제를 해결했습니다.
- 로딩 컴포넌트 및 AppBar 커스터마이징 기능을 개선했습니다.
- json 라이브러리를 json_serializable로 교체했습니다.
- 우리페이 확대에 따른 우리WON뱅킹 지원을 추가했습니다.
- [iOS] 연속적인 자바스크립트 실행으로 인해 불필요한 로그가 생성되지 않도록 수정했습니다.

## [0.10.0-dev.6](https://github.com/iamport/iamport_flutter/tree/v0.10.0-dev.6)
- [안드로이드] 다날 일반결제에서 페이북을 통해 결제할 때 앱을 실행시 발생하는 오류를 해결했습니다.

## [0.10.0-dev.5](https://github.com/iamport/iamport_flutter/tree/v0.10.0-dev.5)
- [안드로이드] 리뉴얼된 다날 본인인증 UI에서 PASS 앱 실행을 위한 m_redirect_url을 추가했습니다.

## [0.10.0-dev.4](https://github.com/iamport/iamport_flutter/tree/v0.10.0-dev.4)
- JS SDK를 v1.2.0로 업데이트했습니다.
- 스마트로를 추가했습니다.

## [0.10.0-dev.3](https://github.com/iamport/iamport_flutter/tree/v0.10.0-dev.3)
- 토스 지원을 추가했습니다.
- 네이버페이 결제형에서 발생하는 json에 불필요한 값이 들어가는 오류를 수정했습니다.

## [0.10.0-dev.2](https://github.com/iamport/iamport_flutter/tree/v0.10.0-dev.2)
- [안드로이드] NH카드 V3 url 파싱 에러를 해결했습니다.
- [ios] 리브 앱 지원을 추가했습니다.
- 우리페이 앱 지원 종료에 따른 우리WON카드 지원을 추가했습니다.
- L.PAY 및 L.POINT 앱 통합에 따른 L.POINT 지원을 추가했습니다.
- 네이버페이 앱 로그인 기능을 추가했습니다.
- webview_flutter 사용에 따른 웹뷰 충돌을 해결했습니다.

## [0.10.0-dev.1](https://github.com/iamport/iamport_flutter/tree/v0.10.0-dev.1)
- [안드로이드] 외부 앱 로딩 방식을 변경했습니다.
- flutter v2로의 마이그레이션 및 dart 버전 업그레이드에 따른 null safety에 대한 대응을 완료했습니다.
- 네이버페이 및 체크아웃 결제용 파라미터를 추가했습니다.
- 일부 pg 결제화면에서 javascript 팝업이 제대로 나타나지 않는 현상을 해결했습니다.
- 결제 데이터를 json으로 변환하는 방식을 변경했습니다.
- 페이나우 지원을 추가했습니다.

## [0.9.15](https://github.com/iamport/iamport_flutter/tree/v0.9.15)
- [안드로이드] 코틀린 환경에서 registerWith 함수가 트리거되지 않는 상황을 대비해 ActivityAware 인터페이스를 implement 하도록 로직을 추가하였습니다.

## [0.9.14](https://github.com/iamport/iamport_flutter/tree/v0.9.14)
- [안드로이드] API 30 지원을 위해 url_launcher의 canLaunch 코드를 제거하였습니다.

## [0.9.13](https://github.com/iamport/iamport_flutter/tree/v0.9.13)
- [다날 - 휴대폰 소액결제] 주문명이 중복되는 것을 방지하기 위해 company 파라메터를 추가하였습니다.

## [0.9.12](https://github.com/iamport/iamport_flutter/tree/v0.9.12)
- [안드로이드] KG이니시스 - 실시간계좌이체시 국민리브, NH앱캐시, NG상상뱅크, BNK경남은행 앱의 링크가 누락된 부분을 추가하였습니다.
- uni_links 패키지의 버전을 0.4.0으로 올렸습니다.

## [0.9.11](https://github.com/iamport/iamport_flutter/tree/v0.9.11)
- 스마일페이, 차이페이, 페이플, 알리페이 예제 코드를 추가하였습니다.
- 다날 - 본인인증 방식을 리디렉션 방식으로 변경하였습니다.

## [0.9.10](https://github.com/iamport/iamport_flutter/tree/v0.9.10)
- iamport javascript sdk 버전을 v1.1.8로 올렸습니다.
- 안드로이드6에서 결제/본인인증 창 미렌더링 이슈를 해결하였습니다.

## [0.9.9](https://github.com/iamport/iamport_flutter/tree/v.0.9.9)
- 농협 올원페이 앱 스킴 값 오타를 수정하였습니다.
- build시 필요하지 않은 asset을 제거하기 위해 pubspec.yaml 파일을 수정하였습니다.

## [0.9.8](https://github.com/iamport/iamport_flutter/tree/v0.9.8)
- 할부개월수 설정 파라미터 오타를 고쳤습니다.

## [0.9.6](https://github.com/iamport/iamport_flutter/tree/v0.9.6)
- niceMobileV2를 true로 기본으로 적용하고 이와 관련된 실시간 계좌이체 대비 코드를 적용하였습니다.

## [0.9.5](https://github.com/iamport/iamport_flutter/tree/v0.9.5)
- 이니시스, 나이스 그리고 다날 일반결제시 제공기간 표기를 위한 파라미터(period)를 추가하였습니다.

## [0.9.4](https://github.com/iamport/iamport_flutter/tree/v0.9.4)
- 안드로이드에서 NH농협카드 일반결제시, intent uri를 파싱할때 발생하는 exception을 처리하였습니다.

## [0.9.3](https://github.com/iamport/iamport_flutter/tree/v0.9.3)
- CupertinoNavigationBar 지원을 위한 로직을 추가하였습니다.

## [0.9.2](https://github.com/iamport/iamport_flutter/tree/v0.9.2)
- 3rd-party 앱 URL scheme값에 하나멤버스를 추가하였습니다.

## [0.9.1](https://github.com/iamport/iamport_flutter/tree/v0.9.1)
- Health suggestions을 적용하였습니다.

## [0.9.0](https://github.com/iamport/iamport_flutter/tree/v0.9.0)
- IOS 및 안드로이드 플러터 프로젝트에서 아임포트 일반/정기결제 및 휴대폰 본인인증 연동 기능을 제공합니다.
