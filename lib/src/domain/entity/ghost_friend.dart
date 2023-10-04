import 'package:dart_flutter/src/domain/entity/title_vote.dart';
import 'package:dart_flutter/src/domain/entity/type/student.dart';

class GhostFriend implements Student {
  String? name;
  int? birthYear;
  int? universityId;
  String? profileImageUrl;

  GhostFriend(
      {this.name, this.birthYear, this.universityId, this.profileImageUrl});

  GhostFriend.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    birthYear = json['birthyear'];
    universityId = json['universityId'];
    profileImageUrl = json['porfileimageurl'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['birthyear'] = birthYear;
    data['universityId'] = universityId;
    data['porfileimageurl'] = profileImageUrl;
    return data;
  }

  @override
  int getBirthYear() {
    return birthYear ?? 0;
  }

  @override
  String getDepartment() {
    return "(알수없음)";
  }

  @override
  int getId() {
    return 0;
  }

  @override
  bool getIsCertifiedUser() {
    return false;
  }

  @override
  String getName() {
    return name ?? "(알수없음)";
  }

  @override
  String getProfileImageUrl() {
    return profileImageUrl ?? "DEFAULT";
  }

  @override
  List<TitleVote> getTitleVotes() {
    return [];
  }

  @override
  String getUniversityName() {
    return "(알수없음)";
  }

  @override
  int getUniversityId() {
    return universityId ?? 0;
  }

  @override
  String toString() {
    return 'GhostFriend{name: $name, birthYear: $birthYear, universityId: $universityId, profileImageUrl: $profileImageUrl}';
  }
}
