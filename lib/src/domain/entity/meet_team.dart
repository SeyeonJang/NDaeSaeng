import 'package:dart_flutter/src/domain/entity/type/blind_date_user.dart';
import 'package:dart_flutter/src/domain/entity/type/team.dart';
import 'package:dart_flutter/src/domain/entity/university.dart';
import 'package:dart_flutter/src/domain/entity/location.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';
import 'package:dart_flutter/src/domain/mapper/meet_user_mapper.dart';

class MeetTeam extends Team {
  final int id;
  final String name;
  final University? university;
  final List<Location> locations;
  final bool canMatchWithSameUniversity;
  final List<User> members;

  MeetTeam({
    required this.id,
    required this.name,
    required this.university,
    required this.locations,
    required this.canMatchWithSameUniversity,
    required this.members,
  });

  @override
  String toString() {
    return 'MeetTeam{id: $id, name: $name, university: $university, locations: $locations}, canMatchWithSameUniversity: $canMatchWithSameUniversity, members: $members}';
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
  double getAverageBirthYear() {
    double birthYear = 0;
    int count = 0;
    for (int i=0; i<members.length; i++) {
      birthYear += members[i].personalInfo?.birthYear ?? 0;
      if (members[i].personalInfo?.birthYear == null) continue;
      count += 1;
    }
    return birthYear / count;
  }

  @override
  List<Location> getRegions() {
    return locations;
  }

  @override
  String getUniversityName() {
    return university?.name ?? '(알수없음)';
  }

  @override
  bool getIsCertifiedTeam() {
    for (int i=0; i<members.length; i++) {
      if (members[i].personalInfo?.verification.isVerificationSuccess ?? false) return true;
    }
    return false;
  }

  @override
  List<BlindDateUser> getTeamUsers() {
    return members.map((user) => MeetUserMapper.toBlindDateUser(user)).toList();
  }
}
