import 'package:dart_flutter/src/domain/entity/university.dart';
import 'package:dart_flutter/src/domain/entity/personal_info.dart';

class User {
  PersonalInfo? personalInfo;
  University? university;

  User({this.personalInfo, this.university});

  User.fromJson(Map<String, dynamic> json) {
    personalInfo = json['user'] != null ? PersonalInfo.fromJson(json['user']) : null;
    university = json['university'] != null
        ? University.fromJson(json['university'])
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

  @override
  String toString() {
    return 'UserResponse{user: $personalInfo, university: $university}';
  }
}
