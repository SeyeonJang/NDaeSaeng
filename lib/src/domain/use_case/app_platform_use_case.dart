import 'package:dart_flutter/src/data/repository/app_platform_repoistory.dart';

class AppPlatformUseCase {
  final AppPlatformRepository _appPlatformRepository = AppPlatformRepository();

  Future<(String, String)> getRemoteConfigAppVersion() {
    return _appPlatformRepository.getAppVersion();
  }
}
