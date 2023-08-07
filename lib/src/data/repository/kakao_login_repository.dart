
import 'package:dart_flutter/src/datasource/kakao_login_remote_datasource.dart';
import 'package:dart_flutter/src/domain/entity/kakao_user.dart';

import '../model/kakao_user_dto.dart';

class KakaoLoginRepository {
  Future<KakaoUser> loginWithKakaoTalk() async {
    return (await KakaoLoginRemoteDatasource.loginWithKakaoTalk()).newKakaoUser();
  }

  Future<void> logout() {
    return KakaoLoginRemoteDatasource().logout();
  }

  Future<void> withdrawal() {
    return KakaoLoginRemoteDatasource().withdrawal();
  }
}
