package kr.iamport.iamport_flutter;

import android.app.Activity;
import android.content.ComponentName;
import android.content.Intent;
import android.net.Uri;
import android.util.Log;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Set;

public class IamportNiceWebViewClient extends IamportPaymentWebViewClient {
    private String NICE_TRANS_URL = "";    // 계좌이체 거래 요청 URL(V2부터는 가변적일 수 있음)
    private String BANK_TID = "";

    public IamportNiceWebViewClient(Activity activity, HashMap<String, String> params) {
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
        String prefix = BANKPAY + "://eftpay?";

        Uri uri = Uri.parse(url);
        BANK_TID = uri.getQueryParameter("user_key");
        NICE_TRANS_URL = uri.getQueryParameter("callbackparam1");

        String decodedUrl = null;
        try {
            decodedUrl = URLDecoder.decode(url.substring(prefix.length()), "utf-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        return decodedUrl;
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
