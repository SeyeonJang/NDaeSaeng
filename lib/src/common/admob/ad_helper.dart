import 'dart:io';

import 'package:dart_flutter/res/environment/app_environment.dart';

class AdHelper {

  @Deprecated("테스트 광고 ID")
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  @Deprecated("테스트 광고 ID")
  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/1033173712";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/4411468910";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return AppEnvironment.getEnv.getAdmobRewardAos();
    } else if (Platform.isIOS) {
      return AppEnvironment.getEnv.getAdmobRewardIos();
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }
}
