package kr.iamport.iamport_flutter;

import android.app.ActionBar;
import android.app.Activity;
import android.app.Application;
import android.content.Intent;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.os.Build;
import android.os.Bundle;
import android.text.Html;
import android.view.MenuItem;
import android.webkit.WebSettings;
import android.webkit.WebView;

import java.util.HashMap;

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
        HashMap<String, String> titleOptions = (HashMap<String, String>) getIntent().getSerializableExtra("titleOptions");
        setActionBar(titleOptions);

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

    private void setActionBar(HashMap<String, String> titleOptions) {
        ActionBar ab = getActionBar();

        String show = titleOptions.get("show");
        if (show.equals("true")) {
            String text = titleOptions.get("text");
            String textColor= titleOptions.get("textColor");
            String backgroundColor = titleOptions.get("backgroundColor");

            ab.setTitle(Html.fromHtml("<font color='" + textColor + "'>" + text + "</font>"));
            ab.setBackgroundDrawable(new ColorDrawable(Color.parseColor(backgroundColor)));
            ab.setDisplayHomeAsUpEnabled(true);
        } else {
            ab.hide();
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