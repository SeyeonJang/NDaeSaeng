
import 'package:dart_flutter/src/data/model/title_vote_dto.dart';
import 'package:dart_flutter/src/domain/entity/type/blind_date_user_detail.dart';

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

  BlindDateUserDetail newBlindDateUserDetail() {
    return BlindDateUserDetail(
        id: id ?? 0,
        name: name ?? "(알수없음)",
        profileImageUrl: profileImageUrl ?? "DEFAULT",
        department: department ?? "(알수없음)",
        isCertifiedUser: isCertifiedUser ?? false,
        birthYear: birthYear ?? 0,
        profileQuestionResponses: profileQuestionResponses?.map((titleVoteDto) => titleVoteDto.newTitleVote()).toList() ?? []
    );
  }

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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['profileImageUrl'] = profileImageUrl;
    data['department'] = department;
    data['isCertifiedUser'] = isCertifiedUser;
    data['birthYear'] = birthYear;
    if (profileQuestionResponses != null) {
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
