import 'package:dart_flutter/src/data/datasource/kakao_login_remote_datasource.dart';
import 'package:dart_flutter/src/domain/entity/kakao_user.dart';
import 'package:dart_flutter/src/domain/repository/kakao_login_repository.dart';

class KakaoLoginRepositoryImpl implements KakaoLoginRepository {
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
