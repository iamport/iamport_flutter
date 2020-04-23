package kr.iamport.iamport_flutter;

import android.app.ActionBar;
import android.app.Activity;
import android.app.Application;
import android.content.Intent;
import android.graphics.Color;
import android.graphics.PorterDuff;
import android.graphics.drawable.ColorDrawable;
import android.graphics.drawable.Drawable;
import android.os.Build;
import android.os.Bundle;
import android.text.Html;
import android.view.Menu;
import android.view.MenuItem;
import android.webkit.CookieManager;
import android.webkit.WebSettings;
import android.webkit.WebView;

import java.util.HashMap;

public class IamportActivity extends Activity {
    WebView webview;
    IamportWebViewClient webViewClient;
    HashMap<String, String> titleOptions;

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

        if (android.os.Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            // 쿠키 허용 설정: 스마일페이 등
            CookieManager cookieManager = CookieManager.getInstance();
            cookieManager.setAcceptCookie(true);
            cookieManager.setAcceptThirdPartyCookies(webview, true);
        }

        Bundle extras = getIntent().getExtras();
        /* SET ACTION BAR */
        titleOptions = (HashMap<String, String>) getIntent().getSerializableExtra("titleOptions");
        setActionBar(titleOptions);

        /* SET WEBVIEW */
        String type = extras.getString("type");
        HashMap<String, String> params = (HashMap<String, String>) getIntent().getSerializableExtra("params");
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

            String leftButtonColor = titleOptions.get("leftButtonColor");
            String leftButtonType = titleOptions.get("leftButtonType");
            if (!leftButtonType.equals("hide")) {
                ab.setDisplayHomeAsUpEnabled(true);

                int iconId = getLeftIconId(leftButtonType);
                final Drawable closeIcon = getResources().getDrawable(iconId);
                closeIcon.setColorFilter(Color.parseColor(leftButtonColor), PorterDuff.Mode.SRC_IN);
                ab.setHomeAsUpIndicator(closeIcon);
            }
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
    public boolean onCreateOptionsMenu(Menu menu) {
        String rightButtonType = titleOptions.get("rightButtonType");
        String rightButtonColor = titleOptions.get("rightButtonColor");

        getMenuInflater().inflate(R.menu.actionbar_actions, menu);
        if (!rightButtonType.equals("hide")) {
            int iconId = getRightIconId(rightButtonType);
            MenuItem meniItem = menu.findItem(iconId);
            meniItem.setVisible(true);
            meniItem.getIcon().setColorFilter(Color.parseColor(rightButtonColor), PorterDuff.Mode.SRC_IN);
        }

        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        Integer itemId = item.getItemId();
        switch (itemId) {
            case android.R.id.home: {
                finish();
                break;
            }
            default: {
                if (itemId.equals(R.id.action_close)) {
                    finish();
                }
                break;
            }
        }

        return super.onOptionsItemSelected(item);
    }

    private int getLeftIconId(String buttonType) {
        if (buttonType.equals("back")) {
            return R.drawable.ic_action_back;
        }
        return R.drawable.ic_action_close;
    }

    private int getRightIconId(String buttonType) {
        if (buttonType.equals("back")) {
            return R.id.action_back;
        }
        return R.id.action_close;
    }
}