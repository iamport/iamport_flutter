import 'package:flutter/material.dart';

import 'package:iamport_flutter/widget/iamport_webview.dart';

class IamportError extends StatelessWidget {
  const IamportError(this.actionType, this.errorMessage, {super.key});

  static const Color failureColor = Color(0xFFF5222D);

  final ActionType actionType;
  final String? errorMessage;

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
                children: [
                  const Icon(Icons.error, color: failureColor, size: 200),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      '아임포트 $actionText 파라메터 오류',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(50, 10, 50, 50),
                    child: Text(
                      errorMessage!,
                      style: const TextStyle(height: 1.2, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    label: const Text(
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
