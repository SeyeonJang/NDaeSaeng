
import 'package:dart_flutter/src/domain/entity/title_vote.dart';

class BlindDateUserDetail {
  final int id;
  final String name;
  final String profileImageUrl;
  final String department;
  final bool isCertifiedUser;
  final int birthYear;
  final List<TitleVote> profileQuestionResponses;

  BlindDateUserDetail(
      {required this.id,
        required this.name,
        required this.profileImageUrl,
        required this.department,
        required this.isCertifiedUser,
        required this.birthYear,
        required this.profileQuestionResponses});

  factory BlindDateUserDetail.fromJson(Map<String, dynamic> json) {
    final int parsedId = json['id'];
    final String parsedName = json['name'];
    final String parsedProfileImageUrl = json['profileImageUrl'];
    final String parsedDepartment = json['department'];
    final bool parsedIsCertifiedUser = json['isCertifiedUser'];
    final int parsedBirthYear = json['birthYear'];

    List<TitleVote> parsedProfileQuestionResponses = [];
    if (json['profileQuestionResponses'] != null) {
      var responsesJsonList = json['profileQuestionResponses'] as List<dynamic>;
      parsedProfileQuestionResponses =
          responsesJsonList.map((v) => TitleVote.fromJson(v)).toList();
    }

    return BlindDateUserDetail(
        id: parsedId,
        name: parsedName,
        profileImageUrl:parsedProfileImageUrl ,
        department:parsedDepartment ,
        isCertifiedUser:parsedIsCertifiedUser ,
        birthYear:parsedBirthYear ,
        profileQuestionResponses :parsedProfileQuestionResponses
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['profileImageUrl'] = profileImageUrl;
    data['department'] = department;
    data['isCertifiedUser'] = isCertifiedUser;
    data['birthYear'] = birthYear;
    if (profileQuestionResponses.isNotEmpty) {
      data['profileQuestionResponses'] =
          profileQuestionResponses.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'BlindDateUserDetail{id: $id, name: $name, profileImageUrl: $profileImageUrl, department: $department, isCertifiedUser: $isCertifiedUser, birthYear: $birthYear, profileQuestionResponses: $profileQuestionResponses}';
  }
}
