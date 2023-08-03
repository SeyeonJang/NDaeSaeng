import 'package:dart_flutter/res/environment/app_environment.dart';
import 'package:dart_flutter/src/common/analytics/amplitude.dart';

import '../analytics/analytics.dart';

class AnalyticsUtil {
  static late Analytics amplitudeTool;

  static void initialize() {
    amplitudeTool = AmplitudeTool()..initialize(
        name: AppEnvironment.buildType.toString(),
        key: AppEnvironment.getEnv.getAmplitudeKey()
    );
  }

  static void logEvent(String eventName, {Map<String, dynamic> properties = const {}}) {
    print("LogEventWith: $eventName, $properties");
    amplitudeTool.logEvent(eventName, properties: properties);
  }

  static void setUserId(String userId) {
    print("setUserId: $userId");
    amplitudeTool.setUserId(userId);
  }

  static void setUserInformation(Map<String, dynamic> properties) {
    print("setUserInformation: $properties");
    amplitudeTool.setUserInformation(properties);
  }
}
