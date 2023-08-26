import 'package:dart_flutter/src/common/analytics/analytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class GoogleAnalytics extends Analytics {
  late FirebaseAnalytics analytics;
  late String name;

  @override
  void initialize({String name = "default_instance", String key = ""}) {
    this.name = name;
    analytics = FirebaseAnalytics.instance;
  }

  @override
  void logEvent(String eventName, {Map<String, dynamic> properties = const {}}) {
    if (properties.isEmpty) {
      analytics.logEvent(name: eventName);
    } else {
      analytics.logEvent(name: eventName, parameters: properties);
    }
  }

  @override
  void setUserId(String userId) {
    analytics.setUserId(id: userId);
  }

  @override
  void setUserInformation(Map<String, dynamic> properties) {
    properties.forEach((key, value) => analytics.setUserProperty(name: key, value: value.toString()));
  }
}
