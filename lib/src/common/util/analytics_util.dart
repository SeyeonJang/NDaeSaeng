import 'package:dart_flutter/res/environment/app_environment.dart';
import 'package:dart_flutter/src/common/analytics/amplitude.dart';
import 'package:dart_flutter/src/common/analytics/google_analytics.dart';

import '../analytics/analytics.dart';

class AnalyticsUtil {
  static late Analytics amplitudeTool;
  static late Analytics googleAnalyticsTool;

  static void initialize() {
    amplitudeTool = AmplitudeTool()..initialize(
      name: AppEnvironment.buildType.toString(),
      key: AppEnvironment.getEnv.getAmplitudeKey()
    );

    googleAnalyticsTool = GoogleAnalytics()..initialize(
      name: AppEnvironment.buildType.toString(),
      key: "파이어베이스는_별도의_JSON파일로_분리되어있음"
    );
  }

  static void logEvent(String eventName, {Map<String, dynamic> properties = const {}}) {
    print("LogEventWith: $eventName, $properties");
    amplitudeTool.logEvent(eventName, properties: properties);
    googleAnalyticsTool.logEvent(eventName, properties: properties);
  }

  static void setUserId(String userId) {
    print("setUserId: $userId");
    amplitudeTool.setUserId(userId);
    googleAnalyticsTool.setUserId(userId);
  }

  static void setUserInformation(Map<String, dynamic> properties) {
    print("setUserInformation: $properties");
    amplitudeTool.setUserInformation(properties);
    googleAnalyticsTool.setUserInformation(properties);
  }
}
