
import 'package:dart_flutter/src/data/model/title_vote_dto.dart';

class BlindDateUserDetailDto {
  int? id;
  String? name;
  String? profileImageUrl;
  String? department;
  bool? isCertifiedUser;
  int? birthYear;
  List<TitleVoteDto>? profileQuestionResponses;

  BlindDateUserDetailDto(
      {this.id,
        this.name,
        this.profileImageUrl,
        this.department,
        this.isCertifiedUser,
        this.birthYear,
        this.profileQuestionResponses});

  BlindDateUserDetailDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    profileImageUrl = json['profileImageUrl'];
    department = json['department'];
    isCertifiedUser = json['isCertifiedUser'];
    birthYear = json['birthYear'];
    if (json['profileQuestionResponses'] != null) {
      profileQuestionResponses = <TitleVoteDto>[];
      json['profileQuestionResponses'].forEach((v) {
        profileQuestionResponses!.add(TitleVoteDto.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['profileImageUrl'] = this.profileImageUrl;
    data['department'] = this.department;
    data['isCertifiedUser'] = this.isCertifiedUser;
    data['birthYear'] = this.birthYear;
    if (this.profileQuestionResponses != null) {
      data['profileQuestionResponses'] =
          this.profileQuestionResponses!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'BlindDateUserDetail{id: $id, name: $name, profileImageUrl: $profileImageUrl, department: $department, isCertifiedUser: $isCertifiedUser, birthYear: $birthYear, profileQuestionResponses: $profileQuestionResponses}';
  }
}
