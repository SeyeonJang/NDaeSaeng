class DartAuth {
  final String providerId;
  final String accessToken;

  DartAuth({
    required this.providerId,
    required this.accessToken,
  });

  DartAuth.from(Map<String, dynamic> json)
      : providerId = json['providerId'],
        accessToken = json['jwtToken'];

  @override
  String toString() {
    return 'DartAuth{userId: $providerId, accessToken: $accessToken}';
  }
}
