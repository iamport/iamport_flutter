import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: new Container(
        decoration: BoxDecoration(color: Color(0xff344e81)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 0,
                      top: 20.0,
                      right: 0,
                      bottom: 20.0,
                    ),
                    child: Text(
                      '아임포트 테스트',
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.white,
                        height: 2.0,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '아임포트 플러터 모듈 테스트 화면입니다.',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '아래 버튼을 눌러 결제 또는 본인인증 테스트를 진행해주세요.',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 0,
                  top: 50.0,
                  right: 0,
                  bottom: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 0.0,
                        top: 0.0,
                        right: 10.0,
                        bottom: 0.0,
                      ),
                      child: RaisedButton.icon(
                        icon: Icon(Icons.payment),
                        onPressed: () {
                          Navigator.pushNamed(context, '/payment-test');
                        },
                        label: Text('결제 테스트'),
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10.0,
                        top: 0.0,
                        right: 0.0,
                        bottom: 0.0,
                      ),
                      child: RaisedButton.icon(
                        icon: Icon(Icons.people),
                        onPressed: () {
                          Navigator.pushNamed(context, '/certification-test');
                        },
                        label: Text('본인인증 테스트'),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
