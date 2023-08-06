import 'package:dart_flutter/src/datasource/dart_api_remote_datasource.dart';

import '../model/dart_auth.dart';

class DartAuthRepository {
  Future<DartAuth> loginWithKakao(String kakaoAccessToken) async {
    return await DartApiRemoteDataSource.postLoginWithKakao(kakaoAccessToken);
  }

  Future<DartAuth> loginWithApple(String appleIdentifyToken) async {
    return await DartApiRemoteDataSource.postLoginWithApple(appleIdentifyToken);
  }
}
