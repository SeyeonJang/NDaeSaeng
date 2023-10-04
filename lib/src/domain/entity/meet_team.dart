import 'package:dart_flutter/src/domain/entity/type/blind_date_user.dart';
import 'package:dart_flutter/src/domain/entity/type/student.dart';
import 'package:dart_flutter/src/domain/entity/type/team.dart';
import 'package:dart_flutter/src/domain/entity/university.dart';
import 'package:dart_flutter/src/domain/entity/location.dart';
import 'package:dart_flutter/src/domain/mapper/student_mapper.dart';

class MeetTeam implements Team {
  final int id;
  final String name;
  final University? university;
  final List<Location> locations;
  final bool canMatchWithSameUniversity;
  final List<Student> members;

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
  double getAverageAge() {
    double birthYear = 0;
    int count = 0;
    for (int i=0; i<members.length; i++) {
      birthYear += members[i].getBirthYear() ?? 0;
      if (members[i].getBirthYear() == null) continue;
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
      if (members[i].getIsCertifiedUser() ?? false) return true;
    }
    return false;
  }

  @override
  List<BlindDateUser> getTeamUsers() {
    return members.map((user) => StudentMapper.toBlindDateUser(user)).toList();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MeetTeam && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
