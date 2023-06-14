class SnsRequest {
  final String deviceId, phone, snsCode;

  SnsRequest({
    required this.deviceId,
    required this.phone,
    required this.snsCode,
  });

  SnsRequest.from(Map<String, dynamic> json)
      : deviceId = json['deviceId'],
        phone = json['phone'],
        snsCode = json['snsCode'];
}
