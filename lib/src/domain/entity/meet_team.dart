import 'package:dart_flutter/src/domain/entity/university.dart';
import 'package:dart_flutter/src/domain/entity/location.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';

class MeetTeam {
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
    return 'MeetTeam{id: $id, name: $name, university: $university, locations: $locations, canMatchWithSameUniversity: $canMatchWithSameUniversity, members: $members}';
  }
}
