class SnsRequest {
  final String deviceId, phone;

  SnsRequest({
    required this.deviceId,
    required this.phone,
  });

  SnsRequest.from(Map<String, dynamic> json)
      : deviceId = json['deviceId'],
        phone = json['phone'];
}
