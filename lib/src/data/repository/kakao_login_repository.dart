
import 'package:dart_flutter/src/datasource/kakao_login_remote_datasource.dart';

import '../model/kakao_user_dto.dart';

class KakaoLoginRepository {
  Future<KakaoUserDto> loginWithKakaoTalk() {
    return KakaoLoginRemoteDatasource.loginWithKakaoTalk();
  }

  Future<void> logout() {
    return KakaoLoginRemoteDatasource().logout();
  }

  Future<void> withdrawal() {
    return KakaoLoginRemoteDatasource().withdrawal();
  }
}
