import 'package:dart_flutter/src/datasource/dart_api_remote_datasource.dart';

import '../model/dart_auth_dto.dart';

class DartAuthRepository {
  Future<DartAuthDto> loginWithKakao(String kakaoAccessToken) async {
    return await DartApiRemoteDataSource.postLoginWithKakao(kakaoAccessToken);
  }

  Future<DartAuthDto> loginWithApple(String appleIdentifyToken) async {
    return await DartApiRemoteDataSource.postLoginWithApple(appleIdentifyToken);
  }
}
