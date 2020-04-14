package kr.iamport.iamport_flutter;

import android.app.Activity;
import android.content.ActivityNotFoundException;
import android.content.Context;
import android.content.Intent;
import android.content.pm.ApplicationInfo;
import android.graphics.Point;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;
import android.view.Display;
import android.view.View;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.widget.FrameLayout;

import com.flutter_webview_plugin.ObservableWebView;

import org.json.JSONObject;

import java.net.URISyntaxException;
import java.security.acl.LastOwnerException;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import io.flutter.plugin.common.PluginRegistry.ActivityResultListener;

/** IamportFlutterPlugin */
public class IamportFlutterPlugin implements MethodCallHandler, ActivityResultListener {
  private Activity activity;
  private Context context;
  private IamportWebViewClient webViewClient;
  private WebView webview;

  static final int REQUEST_CODE = 6018;
  private static final String WEBVIEW_PATH = "file:///android_asset/html/webview_source.html";
  private final static String BANKPAY = "kftc-bankpay";
  private final static String ISP = "ispmobile";
  private final static String PACKAGE_ISP = "kvp.jjy.MispAndroid320";
  private final static String PACKAGE_BANKPAY = "com.kftc.bankpay.android";

  IamportFlutterPlugin(Activity activity, Context context) {
    this.activity = activity;
    this.context = context;
  }


  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "iamport_flutter");

    if (registrar.activity() != null) {
      final IamportFlutterPlugin instance = new IamportFlutterPlugin(registrar.activity(), registrar.activeContext());
      registrar.addActivityResultListener(instance);
      channel.setMethodCallHandler(instance);
    }
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    switch (call.method) {
      case "launch": {
        webview = new ObservableWebView(activity);
        WebSettings settings = webview.getSettings();
        settings.setJavaScriptEnabled(true);
        settings.setDomStorageEnabled(true);

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
          settings.setMixedContentMode(WebSettings.MIXED_CONTENT_COMPATIBILITY_MODE);
        }

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
          webview.setWebContentsDebuggingEnabled(true);
        }

        webview.loadUrl(WEBVIEW_PATH);
        webview.setWebChromeClient(new IamportWebChromeClient());

        String type= call.argument("type");
        String params = call.argument("params");
        switch (type) {
          case "nice": { // 나이스 && 실시간 계좌이체
            webViewClient = new IamportNiceWebViewClient(activity, params);
            break;
          }
          case "certification": { // 휴대폰 본인인증
            webViewClient = new IamportCertificationWebViewClient(activity, params);
            break;
          }
          default: { // 결제
            webViewClient = new IamportPaymentWebViewClient(activity, params);
            break;
          }
        }
        webview.setWebViewClient(webViewClient);

        FrameLayout.LayoutParams layoutParams = buildLayoutParams(call);
        activity.addContentView(webview, layoutParams);

        result.success(null);
        break;
      }
      case "getPlatformVersion": {
        result.success("Android " + android.os.Build.VERSION.RELEASE);
        break;
      }
      case "getAppUrl": {
        try {
          String url = call.argument("url");
          Log.i("url", url);
          Intent intent = Intent.parseUri(url, Intent.URI_INTENT_SCHEME);
          result.success(intent.getDataString());
        } catch (URISyntaxException e) {
          result.notImplemented();
        } catch (ActivityNotFoundException e) {
          result.notImplemented();
        }
        break;
      }
      case "getMarketUrl": {
        try {
          String url = call.argument("url");
          Log.i("url", url);
          Intent intent = Intent.parseUri(url, Intent.URI_INTENT_SCHEME);
          String scheme = intent.getScheme();
          if (ISP.equalsIgnoreCase(scheme)) {
            result.success("market://details?id=" + PACKAGE_ISP);
          } else if (BANKPAY.equalsIgnoreCase(scheme)) {
            result.success("market://details?id=" + PACKAGE_BANKPAY);
          } else {
            String packageName = intent.getPackage();
            if (packageName != null) {
              result.success("market://details?id=" + packageName);
            }
          }
          result.notImplemented();
        } catch (URISyntaxException e) {
          result.notImplemented();
        } catch (ActivityNotFoundException e) {
          result.notImplemented();
        }
        break;
      }
      default: {
        result.notImplemented();
        break;
      }
    }
  }

  @Override
  public boolean onActivityResult(int requestCode, int resultCode, Intent data) {
    if (requestCode == REQUEST_CODE) {
      Bundle extras = data.getExtras();
      String url = extras.getString("url");

//      JSONObject ret = new JSONObject();
//      ret.put("url", url);
//      notifyListeners("IMPOver", ret);
    }
    return false;
  }

  private FrameLayout.LayoutParams buildLayoutParams(MethodCall call) {
    Map<String, Number> rc = call.argument("rect");
    FrameLayout.LayoutParams params;
    if (rc != null) {
      params = new FrameLayout.LayoutParams(
              dp2px(activity, rc.get("width").intValue()), dp2px(activity, rc.get("height").intValue()));
      params.setMargins(dp2px(activity, rc.get("left").intValue()), dp2px(activity, rc.get("top").intValue()),
              0, 0);
    } else {
      Display display = activity.getWindowManager().getDefaultDisplay();
      Point size = new Point();
      display.getSize(size);
      int width = size.x;
      int height = size.y;
      params = new FrameLayout.LayoutParams(width, height);
    }

    return params;
  }

  private int dp2px(Context context, float dp) {
    final float scale = context.getResources().getDisplayMetrics().density;
    return (int) (dp * scale + 0.5f);
  }
}
