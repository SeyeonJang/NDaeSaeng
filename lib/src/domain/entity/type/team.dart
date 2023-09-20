import 'package:dart_flutter/src/domain/entity/location.dart';
import 'package:dart_flutter/src/domain/entity/type/blind_date_user.dart';

abstract interface class Team {
  int getId();
  String getName();
  double getAverageBirthYear();
  List<Location> getRegions();
  String getUniversityName();
  bool getIsCertifiedTeam();
  List<BlindDateUser> getTeamUsers();
}