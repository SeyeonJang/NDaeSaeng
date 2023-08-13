import 'package:dart_flutter/src/domain/entity/university.dart';
import 'package:dart_flutter/src/domain/entity/location.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';

class MeetTeam {
  final String id;
  final String name;
  final University university;
  final Location location;
  final bool canMatchWithSameUniversity;
  final List<User> members;

  MeetTeam({
    required this.id,
    required this.name,
    required this.university,
    required this.location,
    required this.canMatchWithSameUniversity,
    required this.members,
  });
}
