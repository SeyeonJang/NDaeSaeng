import 'package:dart_flutter/src/domain/entity/dart_auth.dart';

abstract class DartAuthRepository {
  Future<DartAuth> loginWithKakao(String kakaoAccessToken);
  Future<DartAuth> loginWithApple(String appleIdentifyToken);
}
