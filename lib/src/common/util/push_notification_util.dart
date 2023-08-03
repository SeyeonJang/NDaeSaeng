import 'package:dart_flutter/res/environment/app_environment.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class PushNotificationUtil {
  static final String appId = AppEnvironment.getEnv.getOneSignalAppId();

  static void init() {
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    OneSignal.shared.setAppId(appId);
    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
      print("Accepted permission: $accepted");
    });
  }

  static void setUserId(final String userId) {
    OneSignal.shared.setExternalUserId(userId).then((results) {
    }).catchError((error) {
      print(error);
    });
  }
}
