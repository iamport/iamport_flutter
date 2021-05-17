package kr.iamport.iamport_flutter;

import android.app.Activity;
import android.content.ActivityNotFoundException;
import android.content.Intent;
import android.net.Uri;

import androidx.annotation.NonNull;

import java.net.URISyntaxException;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** IamportFlutterPlugin */
public class IamportFlutterPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {
  private final static String MARKET_PREFIX = "market://details?id=";

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
  private static Activity activity;


  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
    channel = new MethodChannel(binding.getFlutterEngine().getDartExecutor(), "iamport_flutter");
    channel.setMethodCallHandler(this);
  }

  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    activity = registrar.activity();

    final MethodChannel channel = new MethodChannel(registrar.messenger(), "iamport_flutter");
    channel.setMethodCallHandler(new IamportFlutterPlugin());
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    Intent intent = null;
    switch (call.method) {
      case "launch": {
        try {
          String url = call.argument("url");
          intent = Intent.parseUri(url, Intent.URI_INTENT_SCHEME);
          startNewActivity(intent.getDataString());
          result.success(null);
        } catch (URISyntaxException e){
          result.notImplemented();
        } catch (ActivityNotFoundException e) {
          String marketUrl = getMarketUrl(intent);
          if (marketUrl == null) {
            result.notImplemented();
          } else {
            startNewActivity(marketUrl);
            result.success(null);
          }
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

  protected void startNewActivity(String parsingUri) {
    Uri uri = Uri.parse(parsingUri);
    Intent newIntent = new Intent(Intent.ACTION_VIEW, uri);

    activity.startActivity(newIntent);
  }

  protected String getMarketUrl(Intent intent) {
    String scheme = intent.getScheme();
    if (ISP.equalsIgnoreCase(scheme)) {
      return MARKET_PREFIX + PACKAGE_ISP;
    }
    if (BANKPAY.equalsIgnoreCase(scheme)) {
      return MARKET_PREFIX + PACKAGE_BANKPAY;
    }
    if (KB_BANKPAY.equalsIgnoreCase(scheme)) {
      return MARKET_PREFIX + PACKAGE_KB_BANKPAY;
    }
    if (NH_BANKPAY.equalsIgnoreCase(scheme)) {
      return MARKET_PREFIX + PACKAGE_NH_BANKPAY;
    }
    if (MG_BANKPAY.equalsIgnoreCase(scheme)) {
      return MARKET_PREFIX + PACKAGE_MG_BANKPAY;
    }
    if (KN_BANKPAY.equalsIgnoreCase(scheme)) {
      return MARKET_PREFIX + PACKAGE_KN_BANKPAY;
    }

    String packageName = intent.getPackage();
    if (packageName != null) {
      return MARKET_PREFIX + packageName;
    }
    return null;
  }

  @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding activityPluginBinding) {
    activity = activityPluginBinding.getActivity();
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {

  }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding activityPluginBinding) {
    activity = activityPluginBinding.getActivity();
  }

  @Override
  public void onDetachedFromActivity() {

  }
}
