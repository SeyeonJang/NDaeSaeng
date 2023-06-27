
import 'package:dart_flutter/src/datasource/kakao_login_remote_datasource.dart';

import '../model/kakao_user.dart';

class KakaoLoginRepository {
  Future<KakaoUser> loginWithKakaoTalk() {
    return KakaoLoginRemoteDatasource.loginWithKakaoTalk();
  }

  Future<void> logout() {
    return KakaoLoginRemoteDatasource().logout();
  }
}
