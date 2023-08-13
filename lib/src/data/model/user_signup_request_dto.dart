import 'package:dart_flutter/src/domain/entity/user_request.dart';

class UserSignupRequestDto {
  final int univId;
  final int admissionYear, birthYear;
  final String name, phone, gender;

  UserSignupRequestDto({
    required this.univId,
    required this.admissionYear,
    required this.birthYear,
    required this.name,
    required this.phone,
    required this.gender
  });

  UserSignupRequestDto.from(Map<String, dynamic> json)
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

  UserRequest newUserRequest() {
    return UserRequest(univId: univId, admissionYear: admissionYear, birthYear: birthYear, name: name, phone: phone, gender: gender);
  }

  static UserSignupRequestDto fromUserRequest(UserRequest userRequest) {
    return UserSignupRequestDto(
      univId: userRequest.univId,
      admissionYear: userRequest.admissionYear,
      birthYear: userRequest.birthYear,
      name: userRequest.name,
      phone: userRequest.phone,
      gender: userRequest.gender
    );
  }

  @override
  String toString() {
    return 'UserRequest{univId: $univId, admissionYear: $admissionYear, birthYear: $birthYear, name: $name, phone: $phone, gender: $gender}';
  }
}
