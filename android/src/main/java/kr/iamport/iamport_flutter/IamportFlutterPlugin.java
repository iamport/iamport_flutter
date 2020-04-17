package kr.iamport.iamport_flutter;

import android.app.Activity;
import android.content.ActivityNotFoundException;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;

import java.net.URISyntaxException;
import java.util.HashMap;

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
  private Result result;

  static final String WEBVIEW_PATH = "file:///android_asset/html/webview_source.html";
  static final int REQUEST_CODE = 6018;
  static final int REQUEST_CODE_FOR_NICE_TRANS = 4117;

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
  public void onMethodCall(MethodCall call, Result resultObj) {
    switch (call.method) {
      case "launch": {
        Intent intent = new Intent(activity.getApplicationContext(), IamportActivity.class);

        String type = call.argument("type");
        HashMap<String, String> titleOptions = call.argument("titleOptions");
        HashMap<String, String> params = call.argument("params");
        intent.putExtra("type", type);
        intent.putExtra("titleOptions", titleOptions);
        intent.putExtra("params", params);

        activity.startActivityForResult(intent, REQUEST_CODE);

        result = resultObj;
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
    if (requestCode == REQUEST_CODE && data != null) {
      Bundle extras = data.getExtras();
      String url = extras.getString("url");

      result.success(url);
    }
    return false;
  }
}
