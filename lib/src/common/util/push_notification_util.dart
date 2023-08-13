import 'package:dart_flutter/res/environment/app_environment.dart';
import 'package:dart_flutter/src/common/util/analytics_util.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class PushNotificationUtil {
  static final String appId = AppEnvironment.getEnv.getOneSignalAppId();

  static void init() {
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    OneSignal.shared.setAppId(appId);
    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
      print("Accepted permission: $accepted");
    });
    _whenOpenedPushNotification();
  }

  static void _whenOpenedPushNotification() {
    OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      print("OneSignal: notification opened: ${result.notification.notificationId}");
      AnalyticsUtil.logEvent("푸시알림_접속", properties: {
        "notificationId": result.notification.notificationId
      });
    });
  }

  static void setUserId(final String userId) {
    OneSignal.shared.setExternalUserId(userId).then((results) {
    }).catchError((error) {
      print(error);
    });
  }
}
