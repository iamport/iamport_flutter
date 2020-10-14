package kr.iamport.iamport_flutter;

import android.content.ActivityNotFoundException;
import android.content.Intent;
import android.util.Log;

import androidx.annotation.NonNull;

import java.net.URISyntaxException;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** IamportFlutterPlugin */
public class IamportFlutterPlugin implements FlutterPlugin, MethodCallHandler {
  private final static String BANKPAY = "kftc-bankpay";
  private final static String ISP = "ispmobile";
  private final static String KB_BANKPAY = "kb-bankpay";
	private final static String NH_BANKPAY = "nhb-bankpay";
	private final static String MG_BANKPAY = "mg-bankpay";
	private final static String KN_BANKPAY = "kn-bankpay";

  private final static String PACKAGE_ISP = "kvp.jjy.MispAndroid320";
  private final static String PACKAGE_BANKPAY = "com.kftc.bankpay.android";
  private final static String PACKAGE_KB_BANKPAY = "com.kbstar.liivbank";
	private final static String PACKAGE_NH_BANKPAY = "com.nh.cashcardapp";
	private final static String PACKAGE_MG_BANKPAY = "kr.co.kfcc.mobilebank";
	private final static String PACKAGE_KN_BANKPAY = "com.knb.psb";

  private MethodChannel channel;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
    channel = new MethodChannel(binding.getFlutterEngine().getDartExecutor(), "iamport_flutter");
    channel.setMethodCallHandler(this);
  }

  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "iamport_flutter");
    channel.setMethodCallHandler(new IamportFlutterPlugin());
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    switch (call.method) {
      case "getAppUrl": {
        try {
          String url = call.argument("url");
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
          } else if (KB_BANKPAY.equalsIgnoreCase(scheme)) {
            result.success("market://details?id=" + PACKAGE_KB_BANKPAY);
          } else if (NH_BANKPAY.equalsIgnoreCase(scheme)) {
            result.success("market://details?id=" + PACKAGE_NH_BANKPAY);
          } else if (MG_BANKPAY.equalsIgnoreCase(scheme)) {
            result.success("market://details?id=" + PACKAGE_MG_BANKPAY);
          } else if (KN_BANKPAY.equalsIgnoreCase(scheme)) {
            result.success("market://details?id=" + PACKAGE_KN_BANKPAY);
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
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
