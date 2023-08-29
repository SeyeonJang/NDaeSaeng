import 'package:dart_flutter/src/domain/entity/title_vote.dart';
import 'package:dart_flutter/src/domain/entity/university.dart';
import 'package:dart_flutter/src/domain/entity/personal_info.dart';

class User {
  PersonalInfo? personalInfo;
  University? university;
  late List<TitleVote> titleVotes;

  User({this.personalInfo, this.university, required this.titleVotes});

  User.fromJson(Map<String, dynamic> json) {
    personalInfo = json['user'] != null ? PersonalInfo.fromJson(json['user']) : null;
    university = json['university'] != null
        ? University.fromJson(json['university'])
        : null;
    titleVotes = (json['titleVote'] as List<dynamic>).map((e) => TitleVote.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (personalInfo != null) {
      data['user'] = personalInfo!.toJson();
    }
    if (university != null) {
      data['university'] = university!.toJson();
    }
    data['titleVote'] = titleVotes.map((titleVote) => titleVote.toJson()).toList();
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

  void addTitleVote(TitleVote titleVote) {
    titleVotes.add(titleVote);
  }

  void removeTitleVote(int questionId) {
    titleVotes.removeWhere((e) => e.question.questionId == questionId);
  }

  @override
  int get hashCode {
    return personalInfo!.id.hashCode;
  }

  @override
  bool operator == (Object other) {
    return personalInfo!.id.hashCode == (other as User).personalInfo!.id.hashCode;
  }

  @override
  String toString() {
    return 'UserResponse{user: $personalInfo, university: $university, titleVote: $titleVotes}';
  }
}
