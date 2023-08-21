import 'package:dart_flutter/res/environment/app_environment.dart';
import 'package:dart_flutter/src/data/datasource/dart_api_remote_datasource.dart';

class TestInformation {
  static const String dartApiKey = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhcHBsZV8wMDE2MTIuZDhkM2E0MTcyMmQ2NDFlZWIxOWNlZWU2ZTg5YjliYjYuMDIxMSIsImlkIjoyMjA0LCJleHAiOjE2OTI5MDEyMDgsInVzZXJuYW1lIjoiYXBwbGVfMDAxNjEyLmQ4ZDNhNDE3MjJkNjQxZWViMTljZWVlNmU4OWI5YmI2LjAyMTEifQ.IsIqF4gnb1e_P1oS0c12xMpJnoR7BqBQQotVNd2cmnorO0-aJcwrx0CRAgNIxNO3yEw-1gHn4X-FXrVy_tgpEQ";

  static void dartInit() {
      AppEnvironment.setupEnv(BuildType.dev);
      DartApiRemoteDataSource.addAuthorizationToken(dartApiKey);
  }
}
