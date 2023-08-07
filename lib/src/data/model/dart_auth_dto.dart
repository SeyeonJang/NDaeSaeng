import 'package:dart_flutter/src/domain/entity/dart_auth.dart';

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

  DartAuth newDartAuth() {
    return DartAuth(providerId: providerId, accessToken: accessToken);
  }

  @override
  String toString() {
    return 'DartAuth{userId: $providerId, accessToken: $accessToken}';
  }
}
