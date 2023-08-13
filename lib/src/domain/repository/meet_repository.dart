import 'package:dart_flutter/src/domain/entity/meet_team.dart';

abstract class MeetRepository {
  MeetTeam createNewTeam(MeetTeam meetTeam);
  MeetTeam getTeam(String teamId);
  List<MeetTeam> getMyTeams();
  void removeMyTeam(String teamId);
  MeetTeam updateMyTeam(MeetTeam meetTeam);
}
