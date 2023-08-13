import 'package:dart_flutter/src/domain/entity/meet_team.dart';
import 'package:dart_flutter/src/domain/repository/meet_repository.dart';

class MockMeetRepository implements MeetRepository {
  final List<MeetTeam> mockTeams = [];

  @override
  MeetTeam createNewTeam(MeetTeam meetTeam) {
    mockTeams.add(meetTeam);
    return meetTeam;
  }

  @override
  MeetTeam getTeam(String teamId) {
    return mockTeams.map((mockTeam) => mockTeam.id == teamId ? mockTeam : throw Error()).first;
  }

  @override
  List<MeetTeam> getMyTeams() {
    return mockTeams;
  }

  @override
  void removeMyTeam(String teamId) {
    mockTeams.removeWhere((mockTeam) => mockTeam.id == teamId);
  }

  @override
  MeetTeam updateMyTeam(MeetTeam meetTeam) {
    mockTeams.removeWhere((mockTeam) => mockTeam.id == meetTeam.id);
    mockTeams.add(meetTeam);
    return meetTeam;
  }
}
