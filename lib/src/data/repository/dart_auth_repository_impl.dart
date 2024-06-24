import 'package:dart_flutter/src/data/datasource/dart_api_remote_datasource.dart';
import 'package:dart_flutter/src/domain/entity/dart_auth.dart';
import 'package:dart_flutter/src/domain/repository/dart_auth_repository.dart';

class DartAuthRepositoryImpl implements DartAuthRepository {
  @override
  Future<DartAuth> loginWithKakao(String kakaoAccessToken) async {
    return (await DartApiRemoteDataSource.postLoginWithKakao(kakaoAccessToken)).newDartAuth();
  }

  @override
  Future<DartAuth> loginWithApple(String appleIdentifyToken) async {
    return (await DartApiRemoteDataSource.postLoginWithApple(appleIdentifyToken)).newDartAuth();
  }

  @override
  Future<String> healthCheck() async {
    return await DartApiRemoteDataSource.healthCheck();
  }
}
