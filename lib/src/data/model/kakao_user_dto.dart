class KakaoUserDto {
  final String uuid, accessToken;
  final String? profileImageUrl, gender;

  KakaoUserDto({
    required this.uuid,
    required this.profileImageUrl,
    required this.gender,
    required this.accessToken,
  });
}
