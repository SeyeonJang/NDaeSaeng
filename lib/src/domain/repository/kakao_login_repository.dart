import 'package:dart_flutter/src/domain/entity/kakao_user.dart';

abstract class KakaoLoginRepository {
  Future<KakaoUser> loginWithKakaoTalk();
  Future<void> logout();
  Future<void> withdrawal();
}
