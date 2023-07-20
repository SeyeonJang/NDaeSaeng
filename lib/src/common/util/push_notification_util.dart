import 'package:onesignal_flutter/onesignal_flutter.dart';

class PushNotificationUtil {
  static const String appId = "1f36be12-544d-4bb5-9d9a-c54789698647";

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
