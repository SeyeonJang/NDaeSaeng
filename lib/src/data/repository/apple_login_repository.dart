import 'package:dart_flutter/src/datasource/apple_login_remote_datasource.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleLoginRepository {
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
