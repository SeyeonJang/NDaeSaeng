import 'package:dart_flutter/src/common/analytics/amplitude.dart';

import '../analytics/analytics.dart';

class AnalyticsUtil {
  static final Analytics amplitudeTool = AmplitudeTool()..initialize(name: "debug", key: "f5f0a3c27ca9f7ed5e85ea41016906aa");

  static void logEvent(String eventName, {Map<String, dynamic> properties = const {}}) {
    print("LogEventWith: $eventName, $properties");
    amplitudeTool.logEvent(eventName, properties: properties);
  }

  static void setUserId(String userId) {
    print("setUserId: $userId");
    amplitudeTool.setUserId(userId);
  }
}
