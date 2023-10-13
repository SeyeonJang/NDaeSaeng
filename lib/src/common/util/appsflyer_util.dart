import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:dart_flutter/res/environment/app_environment.dart';

class AppsflyerUtil {
  static final _devKey = AppEnvironment.getEnv.getAppsflyerApiKey();
  static final _appId = AppEnvironment.getEnv.getAppsflyerAppId();

  static void init() {
    AppsFlyerOptions appsFlyerOptions = AppsFlyerOptions(
      afDevKey: _devKey,
      appId: _appId,
      showDebug: true,
      // timeToWaitForATTUserAuthorization: 50, // for iOS 14.5
      // appInviteOneLink: oneLinkID, // Optional field
      // disableAdvertisingIdentifier: false, // Optional field
      // disableCollectASA: false
    ); // Optional field

    AppsflyerSdk appsflyerSdk = AppsflyerSdk(appsFlyerOptions);

    appsflyerSdk.initSdk(
        registerConversionDataCallback: true,
        registerOnAppOpenAttributionCallback: true,
        registerOnDeepLinkingCallback: true
    );
  }
}
