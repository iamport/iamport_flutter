package kr.iamport.iamport_flutter;

import android.app.Activity;
import android.content.ActivityNotFoundException;
import android.content.Intent;
import android.net.Uri;
import android.util.Log;
import android.webkit.WebView;
import android.webkit.WebViewClient;

import java.net.URISyntaxException;
import java.util.HashMap;

import org.json.JSONObject;

abstract public class IamportWebViewClient extends WebViewClient {
    Activity activity;
    WebView webView;

    protected String userCode;
    protected JSONObject data;
    protected String triggerCallback;
    private String redirectUrl;

    protected Boolean loadingFinished = false;

    protected final static String MARKET_PREFIX = "market://details?id=";

    public IamportWebViewClient(Activity activity, HashMap<String, String> params) {
        this.activity = activity;

        try {
            userCode = params.get("userCode");
            data = new JSONObject(params.get("data"));
            triggerCallback = params.get("triggerCallback");
            redirectUrl = params.get("redirectUrl");
        } catch (Exception e) {

        }
    }

    @Override
    public boolean shouldOverrideUrlLoading(WebView view, String url) {
        Log.i("url", url);
        this.webView = view;

        if (isOver(url)) {
            Intent data = new Intent();
            data.putExtra("url", url);
            activity.setResult(IamportFlutterPlugin.REQUEST_CODE, data);
            activity.finish();

            return true;
        }
        if (isUrlStartsWithProtocol(url)) return false;

        Intent intent = null;
        try {
            if (isNiceTransOver(url)) {
                startActivityForTrans(url);
                return true;
            }

            intent = Intent.parseUri(url, Intent.URI_INTENT_SCHEME); // Intent URI 처리
            if (intent == null) return false;

            startNewActivity(intent.getDataString());
            return true;
        } catch(URISyntaxException e) {
            return false;
        } catch(ActivityNotFoundException e) { // PG사에서 호출하는 url에 package 정보가 없는 경우
            String scheme = intent.getScheme();
            if (isSchemeNotFound(scheme)) return true;

            String packageName = intent.getPackage();
            if (packageName == null) return false;

            startNewActivity(MARKET_PREFIX + packageName);
            return true;
        }
    }

    /* WebView가 load되면 IMP.init, IMP.request_pay를 호출한다 */
    abstract public void onPageFinished(WebView view, String url);


    /* url이 https, http 또는 javascript로 시작하는지 체크 */
    protected boolean isUrlStartsWithProtocol(String url) {
        return url.startsWith("https://") || url.startsWith("http://") || url.startsWith("javascript:");
    }

    /* 결제/본인인증 종료되었는지 여부를 판단한다 */
    protected boolean isOver(String url) {
        return url.startsWith(redirectUrl);
    }

    protected boolean isNiceTransOver(String url) {
        return false;
    }

    protected void startActivityForTrans(String url) {}

    protected void startNewActivity(String parsingUri) {
        Uri uri = Uri.parse(parsingUri);
        Intent newIntent = new Intent(Intent.ACTION_VIEW, uri);

        activity.startActivity(newIntent);
    }

    /* ActivityNotFoundException에서 market 실행여부 확인 */
    protected boolean isSchemeNotFound(String scheme) {
        return false;
    }

    /* 나이스 - 실시간 계좌이체 인증 후 후속처리 루틴 */
    protected void bankPayPostProcess(int requestCode, int resultCode, Intent data) {}
}