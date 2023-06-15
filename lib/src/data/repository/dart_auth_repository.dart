import 'package:dart_flutter/src/data/model/sns_request.dart';
import 'package:dart_flutter/src/datasource/dart_api_remote_datasource.dart';

import '../model/dart_auth.dart';

class DartAuthRepository {
  Future<DartAuth> loginWithKakao(String kakaoAccessToken) async {
    return await DartApiRemoteDataSource.postLoginWithKakao(kakaoAccessToken);
  }

  Future<void> requestSns(SnsRequest snsRequest) async {
    return await DartApiRemoteDataSource.postSnsRequest(snsRequest);
  }

  Future<void> requestValidateSns(SnsRequest snsRequest) async {
    return await DartApiRemoteDataSource.postCheckSnsCode(snsRequest);
  }
}
