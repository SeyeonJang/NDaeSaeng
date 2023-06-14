class UserResponse {
  final int userId, univId;
  final int admissionNumber, point;
  final String name, phone;
  final String universityName, department;
  final DateTime nextVoteDateTime;

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
    univId = json['univId'],
    admissionNumber = json['admissionNumber'],
    point = json['point'],
    name = json['name'],
    phone = json['phone'],
    universityName = json['universityName'],
    department = json['department'],
    nextVoteDateTime = json['nextVoteDateTime'];
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
}
