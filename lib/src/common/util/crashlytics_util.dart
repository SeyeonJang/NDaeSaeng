import 'dart:ui';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

class CrashlyticsUtil {
  static Future<void> init() async {
    // Pass all uncaught "fatal" errors from the framework to Crashlytics
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
    // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  static Future<void> setUserInformation(final Map<String, dynamic> userInformation) async {
    userInformation.forEach((key, value) async => await FirebaseCrashlytics.instance.setCustomKey(key, value));
  }

  static Future<void> setUserId(final String id) async {
    await FirebaseCrashlytics.instance.setUserIdentifier(id);
  }
}
