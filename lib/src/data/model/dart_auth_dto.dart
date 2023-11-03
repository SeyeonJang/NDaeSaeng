import 'package:dart_flutter/src/domain/entity/dart_auth.dart';

class DartAuthDto {
  final String accessToken;
  final String? tokenType;
  final String? expiresAt;
  final String? providerType;
  final String providerId;

  DartAuthDto({
    required this.accessToken,
    this.tokenType,
    this.expiresAt,
    this.providerType,
    required this.providerId
  });

  DartAuthDto.from(Map<String, dynamic> json)
      : accessToken = json['jwtToken'],
        tokenType = json['tokenType'],
        expiresAt = json['expiresAt'],
        providerType = json['providerType'],
        providerId = json['providerId'];

  DartAuth newDartAuth() {
    return DartAuth(
        accessToken: accessToken,
        tokenType: tokenType ?? "NONE",
        expiresAt: expiresAt != null
            ? DateTime.parse(expiresAt!)
            : DateTime.now().add(const Duration(days: 3)),
        providerType: providerType ?? "NONE",
        providerId: providerId,
    );
  }

  @override
  String toString() {
    return 'DartAuthDto{accessToken: $accessToken, tokenType: $tokenType, expiresAt: $expiresAt, providerType: $providerType, providerId: $providerId}';
  }
}
