package kr.iamport.iamport_flutter;

import android.app.ActionBar;
import android.app.Activity;
import android.app.Application;
import android.content.Intent;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.os.Build;
import android.os.Bundle;
import android.view.MenuItem;
import android.webkit.WebSettings;
import android.webkit.WebView;

import org.json.JSONObject;

public class IamportActivity extends Activity {
    WebView webview;
    IamportWebViewClient webViewClient;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        Application application = getApplication();
        String packageName = application.getPackageName();

        Integer identifier = application.getResources().getIdentifier("iamport_activity", "layout", packageName);
        setContentView(identifier);

        int webViewId= getResources().getIdentifier("webview", "id", getPackageName());
        webview = (WebView) findViewById(webViewId);

        WebSettings settings = webview.getSettings();
        settings.setJavaScriptEnabled(true);
        settings.setDomStorageEnabled(true);

        webview.loadUrl(IamportFlutterPlugin.WEBVIEW_PATH);
        webview.setWebChromeClient(new IamportWebChromeClient());
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
            webview.setWebContentsDebuggingEnabled(true);
        }

        Bundle extras = getIntent().getExtras();
        /* SET ACTION BAR */
//        String title = extras.getString("title");
//        setActionBar(title);

        /* SET WEBVIEW */
        String type = extras.getString("type");
        String params = extras.getString("params");
        switch (type) {
            case "nice": { // 나이스 && 실시간 계좌이체
                webViewClient = new IamportNiceWebViewClient(this, params);
                break;
            }
            case "certification": {
                webViewClient = new IamportCertificationWebViewClient(this, params);
                break;
            }
            default: { // 결제
                webViewClient = new IamportPaymentWebViewClient(this, params);
                break;
            }
        }
        webview.setWebViewClient(webViewClient);
    }

    private void setActionBar(String title) {
        ActionBar ab = getActionBar();

        if (title.equals("{}")) {
            ab.hide();
        } else {
            try {
                JSONObject titleParams = new JSONObject(title);

                String name = titleParams.getString("name");
                String color = titleParams.getString("color");

                ab.setTitle(name);
                ab.setBackgroundDrawable(new ColorDrawable(Color.parseColor(color)));
                ab.setDisplayHomeAsUpEnabled(true);

            } catch (Exception e) {

            }
        }
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();

        webview.clearHistory();
        webview.clearCache(true);
        webview.destroy();
        webview = null;
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

        if (requestCode == IamportFlutterPlugin.REQUEST_CODE_FOR_NICE_TRANS) {
            webViewClient.bankPayPostProcess(requestCode, resultCode, data);
        }
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case android.R.id.home: {
                finish();
                break;
            }
            default:
                break;
        }

        return super.onOptionsItemSelected(item);
    }
}