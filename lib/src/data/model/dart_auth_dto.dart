class DartAuthDto {
  final String providerId;
  final String accessToken;

  DartAuthDto({
    required this.providerId,
    required this.accessToken,
  });

  DartAuthDto.from(Map<String, dynamic> json)
      : providerId = json['providerId'],
        accessToken = json['jwtToken'];

  @override
  String toString() {
    return 'DartAuth{userId: $providerId, accessToken: $accessToken}';
  }
}
