class SnsRequest {
  final String _phone;

  SnsRequest({
    required String phone,
  }) : _phone = phone;

  SnsRequest.from(Map<String, dynamic> json)
      : _phone = json['phone'];

  get getPhone {
    return _phone;
  }
}

class SnsVerifyingRequest {
  final String _code;

  SnsVerifyingRequest({
    required String code,
  }) : _code = code;

  get getCode {
    return _code;
  }
}
