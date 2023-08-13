class UserRequest {
  final int univId;
  final int admissionYear, birthYear;
  final String name, phone, gender;

  UserRequest({
    required this.univId,
    required this.admissionYear,
    required this.birthYear,
    required this.name,
    required this.phone,
    required this.gender
  });

  UserRequest.from(Map<String, dynamic> json)
      : univId = json['univId'],
        admissionYear = json['admissionYear'],
        birthYear = json['birthYear'],
        name = json['name'],
        phone = json['phone'],
        gender = json['gender'];

  Map<String, dynamic> toJson() {
    return {
      'universityId': univId,
      'admissionYear': admissionYear,
      'birthYear': birthYear,
      'name': name,
      'phone': phone,
      'gender': gender
    };
  }

  @override
  String toString() {
    return 'UserRequest{univId: $univId, admissionYear: $admissionYear, birthYear: $birthYear, name: $name, phone: $phone, gender: $gender}';
  }
}
