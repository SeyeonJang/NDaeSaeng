import 'package:firebase_remote_config/firebase_remote_config.dart';

class AppPlatformRemoteDatasource {
  static Future<(String, String)> getAppVersion() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    // await remoteConfig.setConfigSettings(RemoteConfigSettings(fetchTimeout: const Duration(seconds: 60), minimumFetchInterval: const Duration(minutes: 5)));

    print(remoteConfig.lastFetchTime);
    await remoteConfig.fetch();
    await remoteConfig.fetchAndActivate();

    String minAppVersion = remoteConfig.getString('minimum_version');
    String latestAppVersion = remoteConfig.getString('latest_version');
    return (minAppVersion, latestAppVersion);
  }
}
