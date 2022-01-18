import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CertificationResult extends StatelessWidget {
  static const Color successColor = Color(0xff52c41a);
  static const Color failureColor = Color(0xfff5222d);

  @override
  Widget build(BuildContext context) {
    Map<String, String> result = Get.arguments as Map<String, String>;
    String message;
    IconData icon;
    Color color;
    bool isErrorMessageRendering;
    if (result['success'] == 'true') {
      message = '본인인증에 성공하였습니다';
      icon = Icons.check_circle;
      color = successColor;
      isErrorMessageRendering = false;
    } else {
      message = '본인인증에 실패하였습니다';
      icon = Icons.error;
      color = failureColor;
      isErrorMessageRendering = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('본인인증 결과'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: color,
              size: 200,
            ),
            Text(
              message,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(50, 30, 50, 50),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 4,
                            child: Text('아임포트 번호',
                                style: TextStyle(color: Colors.grey))),
                        Expanded(
                          flex: 5,
                          child: Text(result['imp_uid'] != null
                              ? result['imp_uid']!
                              : ""),
                        ),
                      ],
                    ),
                  ),
                  if (isErrorMessageRendering)
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Text('에러 메시지',
                                style: TextStyle(color: Colors.grey)),
                          ),
                          Expanded(
                            flex: 5,
                            child: Text(result['error_msg'] != null
                                ? result['error_msg']!
                                : ""),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            ElevatedButton.icon(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Get.offAllNamed('/');
              },
              label: Text(
                '돌아가기',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                shadowColor: Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
