import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleLoginRemoteDatasource {
  static Future<AuthorizationCredentialAppleID> login() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    return credential;
  }

  static Future<void> logout() async {
  }

  static Future<void> withdrawal() async {
  }
}
