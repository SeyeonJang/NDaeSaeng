import 'package:dart_flutter/src/data/model/title_vote_dto.dart';
import 'package:dart_flutter/src/data/model/university_dto.dart';
import 'package:dart_flutter/src/data/model/personal_info_dto.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';

class UserDto {
  PersonalInfoDto? personalInfo;
  UniversityDto? university;
  List<TitleVoteDto>? profileQuestions;

  UserDto({this.personalInfo, this.university, this.profileQuestions});

  UserDto.fromJson(Map<String, dynamic> json) {
    personalInfo = json['user'] != null ? PersonalInfoDto.fromJson(json['user']) : null;
    university = json['university'] != null
        ? UniversityDto.fromJson(json['university'])
        : null;
    // profileQuestions = json['profileQuestions'] != null ? List<TitleVoteDto>.from(json['profileQuestions'].map((x) => TitleVoteDto.fromJson(x))) : [];
    if (json['profileQuestions'] != null) {
      profileQuestions = [];
      json['profileQuestions'].forEach((v) {
        profileQuestions!.add(TitleVoteDto.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (personalInfo != null) {
      data['user'] = personalInfo!.toJson();
    }
    if (university != null) {
      data['university'] = university!.toJson();
    }
    if (profileQuestions != null) {
      data['profileQuestions'] = profileQuestions!.map((v) => v.toJson()).toList();
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
      titleVotes: profileQuestions?.map((titleVoteDto) => titleVoteDto.newTitleVote()).toList() ?? [],
    );
  }

  static UserDto fromUserResponse(User userResponse) {
    return UserDto(
      personalInfo: PersonalInfoDto.fromUser(userResponse.personalInfo!),
      university: UniversityDto.fromUniversity(userResponse.university!),
      profileQuestions: userResponse.titleVotes.map((titleVote) => TitleVoteDto.fromTitleVote(titleVote)).toList(),
    );
  }

  @override
  String toString() {
    return 'UserResponse{user: $personalInfo, university: $university}';
  }
}
