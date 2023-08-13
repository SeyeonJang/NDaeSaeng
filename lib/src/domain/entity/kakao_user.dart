class KakaoUser {
  final String uuid, accessToken;
  final String? profileImageUrl, gender;

  KakaoUser({
    required this.uuid,
    required this.profileImageUrl,
    required this.gender,
    required this.accessToken,
  });
}
