
import 'package:dart_flutter/src/domain/entity/title_vote.dart';
import 'package:dart_flutter/src/domain/entity/type/student.dart';

class BlindDateUser implements Student {
  final int id;
  final String name;
  final String profileImageUrl;
  final String department;

  BlindDateUser({required this.id, required this.name, required this.profileImageUrl, required this.department});

  factory BlindDateUser.fromJson(Map<String, dynamic> json) {
    final int parsedId = json['id'];
    final String parsedName = json['name'];
    final String parsedProfileImageUrl = json['profileImageUrl'];
    final String parsedDepartment = json['department'];

    return BlindDateUser(
      id: parsedId,
      name: parsedName,
      profileImageUrl: parsedProfileImageUrl,
      department: parsedDepartment,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['profileImageUrl'] = profileImageUrl;
    data['department'] = department;
    return data;
  }

  @override
  String toString() {
    return 'BlindDateUser{id: $id, name: $name, profileImageUrl: $profileImageUrl, department: $department}';
  }

  @override
  int getBirthYear() {
    return 0;
  }

  @override
  String getDepartment() {
    return department;
  }

  @override
  int getId() {
    return id;
  }

  @override
  String getName() {
    return name;
  }

  @override
  String getProfileImageUrl() {
    return profileImageUrl;
  }

  @override
  List<TitleVote> getTitleVotes() {
    return [];
  }

  @override
  bool getIsCertifiedUser() {
    return false;
  }

  @override
  String getUniversityName() {
    return "(알수없음)";
  }

  @override
  int getUniversityId() {
    return 0;
  }

  @override
  bool canCreateTeam() {
    // TODO: implement canCreateTeam
    throw UnimplementedError();
  }
}
