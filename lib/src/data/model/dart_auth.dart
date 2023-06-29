class DartAuth {
  final String userId;
  final String accessToken;

  DartAuth({
    required this.userId,
    required this.accessToken,
  });

  DartAuth.from(Map<String, dynamic> json)
      : userId = json['providerId'],
        accessToken = json['jwtToken'];

  @override
  String toString() {
    return 'DartAuth{userId: $userId, accessToken: $accessToken}';
  }
}
