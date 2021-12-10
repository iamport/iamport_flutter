import 'package:flutter/material.dart';
import 'package:iamport_flutter/widget/iamport_webview.dart';

class IamportError extends StatelessWidget {
  static final Color failureColor = Color(0xfff5222d);

  final ActionType actionType;
  final String? errorMessage;

  IamportError(this.actionType, this.errorMessage);

  @override
  Widget build(BuildContext context) {
    String? actionText;
    if (actionType == ActionType.auth) {
      actionText = '본인인증';
    } else if (actionType == ActionType.payment) {
      actionText = '결제';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('아임포트 $actionText 결과'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error,
                    color: failureColor,
                    size: 200,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      '아임포트 $actionText 파라메터 오류',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(50, 10, 50, 50),
                    child: Text(
                      errorMessage!,
                      style: TextStyle(
                        height: 1.2,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ElevatedButton.icon(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    label: Text(
                      '돌아가기',
                      style: TextStyle(fontSize: 16, color: failureColor),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shadowColor: Colors.transparent,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
