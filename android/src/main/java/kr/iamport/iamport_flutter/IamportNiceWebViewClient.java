package kr.iamport.iamport_flutter;

import android.app.Activity;
import android.content.ComponentName;
import android.content.Intent;
import android.net.Uri;
import android.util.Log;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class IamportNiceWebViewClient extends IamportPaymentWebViewClient {
    private final static String NICE_TRANS_URL = "https://web.nicepay.co.kr/smart/bank/payTrans.jsp";    // 계좌이체 거래 요청 URL(V2부터는 가변적일 수 있음)

    private String BANK_TID = "";

    public IamportNiceWebViewClient(Activity activity, String params) {
        super(activity, params);
    }

    public boolean isNiceTransOver(String url) {
        return url.startsWith(BANKPAY);
    }

    public void startActivityForTrans(String url) {
        String reqParam = makeBankPayData(url);
        Intent intent = new Intent(Intent.ACTION_MAIN);

        intent.setComponent(new ComponentName("com.kftc.bankpay.android", "com.kftc.bankpay.android.activity.MainActivity"));
        intent.putExtra("requestInfo", reqParam);

        activity.startActivityForResult(intent, IamportFlutterPlugin.REQUEST_CODE_FOR_NICE_TRANS);
    }

    private String makeBankPayData(String url) {
        Uri uri = Uri.parse(url);
        Set<String> args = uri.getQueryParameterNames();

        StringBuilder ret_data = new StringBuilder();
        List<String> keys = Arrays.asList(new String[] {"firm_name", "amount", "serial_no", "approve_no", "receipt_yn", "user_key", "callbackparam2", ""});

        for (String arg: args) {
            if (keys.contains(arg)) {
                String value = uri.getQueryParameter(arg);
                if (arg.equals("user_key")) {
                    BANK_TID = value;
                }
                ret_data.append("&").append(arg).append("=").append(value);
            }
        }

        ret_data.append("&callbackparam1=" + "nothing");
        ret_data.append("&callbackparam3=" + "nothing");

        return ret_data.toString();
    }

    /* 나이스 - 실시간 계좌이체 인증 후 후속처리 루틴 */
    public void bankPayPostProcess(int requestCode, int resultCode, Intent data) {
        String resVal = data.getExtras().getString("bankpay_value");
        String resCode = data.getExtras().getString("bankpay_code");

        switch (resCode) {
            case "000": {
                try {
                    String postData = "callbackparam2=" + BANK_TID + "&bankpay_code=" + URLEncoder.encode(resCode, "euc-kr") + "&bankpay_value=" + URLEncoder.encode(resVal, "euc-kr");
                    webView.postUrl(NICE_TRANS_URL, postData.getBytes());
                } catch (UnsupportedEncodingException e) {
                    e.printStackTrace();
                }
                break;
            }
            case "091": {
                Log.e("iamport", "계좌이체를 취소하였습니다.");
                break;
            }
            case "060": {
                Log.e("iamport", "타임아웃");
                break;
            }
            case "050": {
                Log.e("iamport", "전자서명에 실패하였습니다.");
                break;
            }
            case "040": {
                Log.e("iamport", "OTP/보안카드 처리에 실패하였습니다.");
                break;
            }
            case "030": {
                Log.e("iamport", "인증모듈 초기화 오류가 발생하였습니다.");
                break;
            }
            default: {
                break;
            }
        }
    }
}
