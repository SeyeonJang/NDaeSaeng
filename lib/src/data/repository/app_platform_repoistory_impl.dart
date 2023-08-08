import 'package:dart_flutter/src/data/datasource/firebase_remote_config_remote_datasource.dart';
import 'package:dart_flutter/src/domain/repository/app_platform_repository.dart';

class AppPlatformRepositoryImpl implements AppPlatformRepository {
  @override
  Future<(String, String)> getAppVersion() async {
    return await FirebaseRemoteConfigRemoteDatasource.getAppVersion();
  }
}
