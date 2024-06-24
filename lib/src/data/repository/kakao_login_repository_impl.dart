import 'package:dart_flutter/src/data/datasource/kakao_login_remote_datasource.dart';
import 'package:dart_flutter/src/domain/entity/kakao_user.dart';
import 'package:dart_flutter/src/domain/repository/kakao_login_repository.dart';

class KakaoLoginRepositoryImpl implements KakaoLoginRepository {
  @override
  Future<KakaoUser> loginWithKakaoTalk() async {
    return (await KakaoLoginRemoteDatasource.loginWithKakaoTalk()).newKakaoUser();
  }

  @override
  Future<void> logout() {
    return KakaoLoginRemoteDatasource().logout();
  }

  @override
  Future<void> withdrawal() {
    return KakaoLoginRemoteDatasource().withdrawal();
  }
}
