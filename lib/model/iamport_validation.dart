import 'package:iamport_flutter/model/certification_data.dart';
import 'package:iamport_flutter/model/payment_data.dart';

class IamportValidation {
  bool isValid = true;
  String? errorMessage;

  IamportValidation(String userCode, PaymentData data, Function callback) {
    if (data.payMethod == 'vbank') {
      if (data.vbankDue == null) {
        isValid = false;
        errorMessage = '가상계좌 결제시 입금기한(vbankDue)은 필수입력입니다.';
        return;
      }

      if (data.pg == 'danal_tpay' && data.bizNum == null) {
        isValid = false;
        errorMessage = '다날 - 가상계좌 결제시 사업자 등록번호(bizNum)은 필수입력입니다.';
        return;
      }
    }

    if (data.payMethod == 'phone' && data.digital == null) {
      isValid = false;
      errorMessage = '휴대폰 소액결제시 실물 컨텐츠 여부(digital)는 필수입력입니다.';
      return;
    }

    if (data.pg == 'kcp_billing' && data.customerUid == null) {
      isValid = false;
      errorMessage = '정기결제시 구매자 카드정보(customerUid)는 필수입력입니다.';
      return;
    }

    if (data.pg == 'syrup') {
      isValid = false;
      errorMessage = '해당 모듈은 해당 PG사를 지원하지 않습니다.';
      return;
    }

    if (data.pg == 'paypal' && data.popup == true) {
      isValid = false;
      errorMessage = '해당 모듈에서 페이팔 - 팝업 방식은 지원하지 않습니다.';
      return;
    }

    if ((data.pg == 'naverpay' || data.pg == 'naverco') &&
        data.naverPopupMode == true) {
      isValid = false;
      errorMessage = '해당 모듈에서 네이버페이 - 팝업 방식은 지원하지 않습니다.';
      return;
    }

    if (data.popup == true) {
      isValid = false;
      errorMessage = '해당 모듈은 팝업 방식을 지원하지 않습니다.';
      return;
    }
  }

  IamportValidation.fromCertificationData(
      String userCode, CertificationData data, Function callback) {
    if (data.popup == true) {
      isValid = false;
      errorMessage = '해당 모듈은 팝업 방식을 지원하지 않습니다.';
      return;
    }
  }

  bool getIsValid() {
    return isValid;
  }

  String? getErrorMessage() {
    return errorMessage;
  }
}
