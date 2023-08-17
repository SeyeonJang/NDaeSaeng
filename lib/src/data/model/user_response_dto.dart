import 'package:dart_flutter/src/data/model/university_dto.dart';
import 'package:dart_flutter/src/data/model/personal_info_dto.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';

import '../../domain/entity/question.dart';
import '../../domain/entity/title_vote.dart';

class UserDto {
  PersonalInfoDto? personalInfo;
  UniversityDto? university;

  UserDto({this.personalInfo, this.university});

  UserDto.fromJson(Map<String, dynamic> json) {
    personalInfo = json['user'] != null ? PersonalInfoDto.fromJson(json['user']) : null;
    university = json['university'] != null
        ? UniversityDto.fromJson(json['university'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (personalInfo != null) {
      data['user'] = personalInfo!.toJson();
    }
    if (university != null) {
      data['university'] = university!.toJson();
    }
    return data;
  }

  // 분석툴에 넘길 사용자 정보 (전화번호 등 민감정보 제외)
  Map<String, dynamic> toAnalytics() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (personalInfo != null) {
      data['gender'] = personalInfo!.gender;
      data['admissionYear'] = personalInfo!.admissionYear;
      data['birthYear'] = personalInfo!.birthYear;
    }
    if (university != null) {
      data['university'] = university!.name;
      data['department'] = university!.department;
    }
    return data;
  }

  User newUserResponse() {
    return User(
      personalInfo: personalInfo?.newUser(),
      university: university?.newUniversity(),
      titleVotes: [],
    );
  }

  static UserDto fromUserResponse(User userResponse) {
    return UserDto(
      personalInfo: PersonalInfoDto.fromUser(userResponse.personalInfo!),
      university: UniversityDto.fromUniversity(userResponse.university!),
    );
  }

  @override
  String toString() {
    return 'UserResponse{user: $personalInfo, university: $university}';
  }
}
