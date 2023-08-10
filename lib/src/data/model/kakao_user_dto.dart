import 'package:dart_flutter/src/domain/entity/kakao_user.dart';

class KakaoUserDto {
  final String uuid, accessToken;
  final String? profileImageUrl, gender;

  KakaoUserDto({
    required this.uuid,
    required this.profileImageUrl,
    required this.gender,
    required this.accessToken,
  });

  KakaoUser newKakaoUser() {
    return KakaoUser(
      uuid: uuid,
      accessToken: accessToken,
      profileImageUrl: profileImageUrl,
      gender: gender,
    );
  }
}
