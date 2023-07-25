import 'package:dart_flutter/src/datasource/app_platform_remote_datasource.dart';

class AppPlatformRepository {
  Future<(String, String)> getAppVersion() async {
    return await AppPlatformRemoteDatasource.getAppVersion();
  }
}
