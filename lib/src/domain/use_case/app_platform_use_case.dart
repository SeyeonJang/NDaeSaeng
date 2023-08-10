import 'package:dart_flutter/src/data/repository/app_platform_repoistory_impl.dart';
import 'package:dart_flutter/src/domain/repository/app_platform_repository.dart';

class AppPlatformUseCase {
  final AppPlatformRepository _appPlatformRepository = AppPlatformRepositoryImpl();

  Future<(String, String)> getRemoteConfigAppVersion() {
    return _appPlatformRepository.getAppVersion();
  }

  Future<String> getUpdateComment() {
    return _appPlatformRepository.getUpdateComment();
  }
}
