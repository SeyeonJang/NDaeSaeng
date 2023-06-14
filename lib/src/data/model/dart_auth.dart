class DartAuth {
  final int userId;
  final String accessToken;

  DartAuth({
    required this.userId,
    required this.accessToken,
  });

  DartAuth.from(Map<String, dynamic> json)
      : userId = json['userId'],
        accessToken = json['accessToken'];

  @override
  String toString() {
    return 'DartAuth{userId: $userId, accessToken: $accessToken}';
  }
}
