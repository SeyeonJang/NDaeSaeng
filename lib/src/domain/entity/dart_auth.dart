class DartAuth {
  final String accessToken;
  final String tokenType;
  final DateTime expiresAt;
  final String providerType;
  final String providerId;

  DartAuth({
    required this.accessToken,
    required this.tokenType,
    required this.expiresAt,
    required this.providerType,
    required this.providerId
  });

  DartAuth.from(Map<String, dynamic> json)
      : accessToken = json['jwtToken'],
        tokenType = json['tokenType'],
        expiresAt = json['expiresAt'],
        providerType = json['providerType'],
        providerId = json['providerId'];

  @override
  String toString() {
    return 'DartAuth{accessToken: $accessToken, tokenType: $tokenType, expiresAt: $expiresAt, providerType: $providerType, providerId: $providerId}';
  }
}
