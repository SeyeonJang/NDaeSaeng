import 'package:amplitude_flutter/amplitude.dart';
import 'package:amplitude_flutter/identify.dart';
import 'package:dart_flutter/src/common/analytics/analytics.dart';

class AmplitudeTool implements Analytics {
  late Amplitude amplitude;

  @override
  void initialize({String name = "", String key = ""}) {
    amplitude = Amplitude(name);
    amplitude.init(key);
  }

  @override
  void logEvent(String eventName, {Map<String, dynamic> properties = const {}}) {
    if (properties.isEmpty) {
      amplitude.logEvent(eventName);
    } else {
      amplitude.logEvent(eventName, eventProperties: properties);
    }
  }

  @override
  void setUserId(String userId) {
    amplitude.setUserId(userId);
  }

  @override
  void setUserInformation(Map<String, dynamic> properties) {
    final Identify identify = Identify();
    properties.forEach((key, value) {
      identify.set(key, value);
    });
    Amplitude.getInstance().identify(identify);
  }
}
