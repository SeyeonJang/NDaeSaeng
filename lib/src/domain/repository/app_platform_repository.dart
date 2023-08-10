abstract class AppPlatformRepository {
  Future<(String, String)> getAppVersion();
  Future<String> getUpdateComment();
}
