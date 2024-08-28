import 'package:iamport_flutter/model/certification_data.dart';
import 'package:iamport_flutter/model/payment_data.dart';

// ignore_for_file: avoid_unused_constructor_parameters
class IamportValidation {
  IamportValidation(String userCode, PaymentData data, Function callback) {
    if (data.payMethod == 'vbank') {
      if (data.vbankDue == null) {
        _isValid = false;
        _errorMessage = '가상계좌 결제시 입금기한(vbankDue)은 필수입력입니다.';
        return;
      }

      if (data.pg == 'danal_tpay' && data.bizNum == null) {
        _isValid = false;
        _errorMessage = '다날 - 가상계좌 결제시 사업자 등록번호(bizNum)은 필수입력입니다.';
        return;
      }
    }

    if (data.payMethod == 'phone' && data.digital == null) {
      _isValid = false;
      _errorMessage = '휴대폰 소액결제시 실물 컨텐츠 여부(digital)는 필수입력입니다.';
      return;
    }

    if (data.pg == 'kcp_billing' && data.customerUid == null) {
      _isValid = false;
      _errorMessage = '정기결제시 구매자 카드정보(customerUid)는 필수입력입니다.';
      return;
    }

    if (data.pg == 'syrup') {
      _isValid = false;
      _errorMessage = '해당 모듈은 해당 PG사를 지원하지 않습니다.';
      return;
    }

    if (data.pg == 'paypal' && (data.popup ?? false)) {
      _isValid = false;
      _errorMessage = '해당 모듈에서 페이팔 - 팝업 방식은 지원하지 않습니다.';
      return;
    }

    if ((data.pg == 'naverpay' || data.pg == 'naverco') &&
        (data.naverPopupMode ?? false)) {
      _isValid = false;
      _errorMessage = '해당 모듈에서 네이버페이 - 팝업 방식은 지원하지 않습니다.';
      return;
    }

    if (data.popup ?? false) {
      _isValid = false;
      _errorMessage = '해당 모듈은 팝업 방식을 지원하지 않습니다.';
      return;
    }
  }

  IamportValidation.fromCertificationData(
    String userCode,
    CertificationData data,
    Function callback,
  ) {
    if (data.popup ?? false) {
      _isValid = false;
      _errorMessage = '해당 모듈은 팝업 방식을 지원하지 않습니다.';
      return;
    }
  }

  bool _isValid = true;
  String? _errorMessage;

  bool getIsValid() {
    return _isValid;
  }

  String? getErrorMessage() {
    return _errorMessage;
  }
}
