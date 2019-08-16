import 'package:flutter/material.dart';

class CertificationResult extends StatelessWidget {
  static const Color successColor = Color(0xff52c41a);
  static const Color failureColor = Color(0xfff5222d);

  @override
  Widget build(BuildContext context) {
    Map<String, String> result = ModalRoute.of(context).settings.arguments;
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
      appBar: new AppBar(
        title: Text('본인인증 결과'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: color,
            size: 200.0,
          ),
          Text(
            message,
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
                        child: Text(result['imp_uid']),
                      ),
                    ],
                  ),
                ),
                if (isErrorMessageRendering)
                  Container(
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
                          child: Text(result['error_msg']),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          RaisedButton.icon(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/certification-test');
            },
            label: Text('돌아가기', style: TextStyle(fontSize: 16.0)),
            color: Colors.white,
            textColor: color,
          ),
        ],
      ),
    );
  }
}