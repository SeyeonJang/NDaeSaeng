import 'package:dart_flutter/src/data/repository/apple_login_repository.dart';
import 'package:dart_flutter/src/data/repository/dart_auth_repository.dart';
import 'package:dart_flutter/src/data/repository/kakao_login_repository.dart';
import 'package:dart_flutter/src/domain/entity/dart_auth.dart';
import 'package:dart_flutter/src/domain/entity/kakao_user.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthUseCase {
  final DartAuthRepository _dartAuthRepository = DartAuthRepository();
  final KakaoLoginRepository _kakaoLoginRepository = KakaoLoginRepository();
  final AppleLoginRepository _appleLoginRepository = AppleLoginRepository();

  Future<DartAuth> loginWithKakao(String kakaoAccessToken) {
    return _dartAuthRepository.loginWithKakao(kakaoAccessToken);
  }

  Future<DartAuth> loginWithApple(String appleIdentifyToken) {
    return _dartAuthRepository.loginWithApple(appleIdentifyToken);
  }

  Future<KakaoUser> loginWithKakaoTalk() {
    return _kakaoLoginRepository.loginWithKakaoTalk();
  }

  void logoutWithKakaoTalk() {
    _kakaoLoginRepository.logout();
  }

  void withdrawalWithKakaoTalk() {
    _kakaoLoginRepository.withdrawal();
  }

  Future<AuthorizationCredentialAppleID> login() {
    return _appleLoginRepository.login();
  }

  void logoutWithApple() {
    _appleLoginRepository.logout();
  }

  void withdrawalWithApple() {
    _appleLoginRepository.withdrawal();
  }
}
