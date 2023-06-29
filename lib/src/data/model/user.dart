class UserResponse {
  final int? userId, univId;
  final int? admissionNumber, point;
  final String? name, phone;
  final String? universityName, department;
  final DateTime? nextVoteDateTime;

  UserResponse({
    required this.userId,
    required this.univId,
    required this.admissionNumber,
    required this.point,
    required this.name,
    required this.phone,
    required this.universityName,
    required this.department,
    required this.nextVoteDateTime
  });

  UserResponse.from(Map<String, dynamic> json)
  : userId = json['userId'],
    univId = json['universityId'],
    admissionNumber = json['admissionNumber'],
    point = json['point'],
    name = json['name'],
    phone = json['phone'],
    universityName = json['universityName'],
    department = json['department'],
    nextVoteDateTime = json['nextVoteDateTime'];

  @override
  String toString() {
    return 'UserResponse{userId: $userId, univId: $univId, admissionNumber: $admissionNumber, point: $point, name: $name, phone: $phone, universityName: $universityName, department: $department, nextVoteDateTime: $nextVoteDateTime}';
  }
}

class UserRequest {
  final int univId;
  final int admissionNumber;
  final String name, phone;

  UserRequest({
    required this.univId,
    required this.admissionNumber,
    required this.name,
    required this.phone,
  });

  UserRequest.from(Map<String, dynamic> json)
  : univId = json['univId'],
    admissionNumber = json['admissionNumber'],
    name = json['name'],
    phone = json['phone'];

  Map<String, dynamic> toJson() {
    return {
      'universityId': univId,
      'admissionNum': admissionNumber,
      'name': name,
      'phone': phone
    };
  }

  @override
  String toString() {
    return 'UserRequest{univId: $univId, admissionNumber: $admissionNumber, name: $name, phone: $phone}';
  }
}
