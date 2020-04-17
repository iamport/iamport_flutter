package kr.iamport.iamport_flutter;

import android.app.Activity;
import android.os.Build;
import android.webkit.WebView;

import java.util.HashMap;

public class IamportCertificationWebViewClient extends IamportWebViewClient {

    public IamportCertificationWebViewClient(Activity activity, HashMap<String, String> params) {
        super(activity, params);
    }

    /* WebView가 load되면 IMP.init, IMP.certification을 호출한다 */
    public void onPageFinished(WebView view, String url) {
        if (!loadingFinished && Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) { // 무한루프 방지
            view.evaluateJavascript("IMP.init('" + userCode + "');", null);
            view.evaluateJavascript("IMP.certification(" + data + ", " + triggerCallback + ");", null);

            loadingFinished = true;
        }
    }
}
