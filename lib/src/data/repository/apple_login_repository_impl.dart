import 'package:dart_flutter/src/data/datasource/apple_login_remote_datasource.dart';
import 'package:dart_flutter/src/domain/repository/apple_login_repository.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleLoginRepositoryImpl implements AppleLoginRepository {
  Future<AuthorizationCredentialAppleID> login() async {
    return AppleLoginRemoteDatasource.login();
  }

  Future<void> logout() async {
    print("구현필요~~~~~~~~~~~~~~~");
    return await AppleLoginRemoteDatasource.logout();
  }

  Future<void> withdrawal() async {
    print("구현필요~~~~~~~~~~~~~~~");
    return await AppleLoginRemoteDatasource.withdrawal();
  }
}
