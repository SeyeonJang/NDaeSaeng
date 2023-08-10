import 'package:firebase_remote_config/firebase_remote_config.dart';

class FirebaseRemoteConfigRemoteDatasource {
  static final remoteConfig = FirebaseRemoteConfig.instance;

  static Future<(String, String)> getAppVersion() async {
    _fetch();
    String minAppVersion = remoteConfig.getString('minimum_version');
    String latestAppVersion = remoteConfig.getString('latest_version');
    return (minAppVersion, latestAppVersion);
  }

  static Future<String> getUpdateComment() async {
    _fetch();
    return remoteConfig.getString("update_comment");
  }

  static void _fetch() async {
    await remoteConfig.fetch();
    await remoteConfig.fetchAndActivate();
  }
}
