import 'package:dart_flutter/src/data/repository/apple_login_repository_impl.dart';
import 'package:dart_flutter/src/data/repository/dart_auth_repository_impl.dart';
import 'package:dart_flutter/src/data/repository/kakao_login_repository_impl.dart';
import 'package:dart_flutter/src/domain/entity/dart_auth.dart';
import 'package:dart_flutter/src/domain/entity/kakao_user.dart';
import 'package:dart_flutter/src/domain/repository/apple_login_repository.dart';
import 'package:dart_flutter/src/domain/repository/dart_auth_repository.dart';
import 'package:dart_flutter/src/domain/repository/kakao_login_repository.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthUseCase {
  final DartAuthRepository _dartAuthRepository = DartAuthRepositoryImpl();
  final KakaoLoginRepository _kakaoLoginRepository = KakaoLoginRepositoryImpl();
  final AppleLoginRepository _appleLoginRepository = AppleLoginRepositoryImpl();

  Future<DartAuth> loginWithKakao(String kakaoAccessToken) {  // TODO loginWith 메소드가 너무많아서 헷갈림
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

  Future<AuthorizationCredentialAppleID> loginWithAppleID() {
    return _appleLoginRepository.login();
  }

  void logoutWithApple() {
    _appleLoginRepository.logout();
  }

  void withdrawalWithApple() {
    _appleLoginRepository.withdrawal();
  }
}
