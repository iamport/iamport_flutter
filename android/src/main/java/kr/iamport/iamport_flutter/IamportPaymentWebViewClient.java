package kr.iamport.iamport_flutter;

import android.app.Activity;
import android.os.Build;
import android.webkit.WebView;

import java.util.HashMap;

public class IamportPaymentWebViewClient extends IamportWebViewClient {
    protected final static String BANKPAY = "kftc-bankpay";
    private final static String ISP = "ispmobile"; // ISP 모바일(ispmobile://TID=nictest00m01011606281506341724)
    private final static String PACKAGE_ISP = "kvp.jjy.MispAndroid320";
    private final static String PACKAGE_BANKPAY = "com.kftc.bankpay.android";

    public IamportPaymentWebViewClient(Activity activity, HashMap<String, String> params) {
        super(activity, params);
    }

    /* WebView가 load되면 IMP.init, IMP.request_pay를 호출한다 */
    public void onPageFinished(WebView view, String url) {
        if (!loadingFinished && Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) { // 무한루프 방지
            view.evaluateJavascript("IMP.init('" + userCode + "');", null);
            view.evaluateJavascript("IMP.request_pay(" + data + ", " + triggerCallback + ");", null);

            loadingFinished = true;
        }
    }


    /* ActivityNotFoundException에서 market 실행여부 확인 */
    public boolean isSchemeNotFound(String scheme) {
        if (ISP.equalsIgnoreCase(scheme)) {
            startNewActivity(MARKET_PREFIX + PACKAGE_ISP);
            return true;
        }
        if (BANKPAY.equalsIgnoreCase(scheme)) {
            startNewActivity(MARKET_PREFIX + PACKAGE_BANKPAY);
            return true;
        }

        return false;
    }
}