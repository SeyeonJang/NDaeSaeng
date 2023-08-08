import 'package:dart_flutter/src/data/model/university_dto.dart';
import 'package:dart_flutter/src/data/model/user_dto.dart';
import 'package:dart_flutter/src/domain/entity/user_response.dart';

class UserResponseDto {
  UserDto? user;
  UniversityDto? university;

  UserResponseDto({this.user, this.university});

  UserResponseDto.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? UserDto.fromJson(json['user']) : null;
    university = json['university'] != null
        ? UniversityDto.fromJson(json['university'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (university != null) {
      data['university'] = university!.toJson();
    }
    return data;
  }

  // 분석툴에 넘길 사용자 정보 (전화번호 등 민감정보 제외)
  Map<String, dynamic> toAnalytics() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['gender'] = user!.gender;
      data['admissionYear'] = user!.admissionYear;
      data['birthYear'] = user!.birthYear;
    }
    if (university != null) {
      data['university'] = university!.name;
      data['department'] = university!.department;
    }
    return data;
  }

  UserResponse newUserResponse() {
    return UserResponse(
      user: user?.newUser(),
      university: university?.newUniversity(),
    );
  }

  @override
  String toString() {
    return 'UserResponse{user: $user, university: $university}';
  }
}
