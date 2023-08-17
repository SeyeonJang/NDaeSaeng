import 'package:dart_flutter/src/domain/entity/meet_team.dart';
import 'package:dart_flutter/src/domain/repository/meet_repository.dart';

class MockMeetRepository implements MeetRepository {
  static final List<MeetTeam> mockTeams = [];

  @override
  Future<MeetTeam> createNewTeam(MeetTeam meetTeam) async {
    mockTeams.add(meetTeam);
    print("repo - 생성된 팀 ${mockTeams}");
    return meetTeam;
  }

  @override
  Future<MeetTeam> getTeam(String teamId) async {
    return mockTeams.map((mockTeam) => mockTeam.id == teamId ? mockTeam : throw Error()).first;
  }

  @override
  Future<List<MeetTeam>> getMyTeams() async {
    return mockTeams;
  }

  @override
  void removeMyTeam(String teamId) {
    print("============================1");
    mockTeams.map((mockTeam) => print(mockTeam.id.toString()));
    print("============================2");
    mockTeams.removeWhere((mockTeam) => mockTeam.id.toString() == teamId);
    print("============================3");
    print("repo - 삭제된 팀 ID $teamId");
    print("repo - 팀 목록 ${mockTeams}");
  }

  @override
  Future<MeetTeam> updateMyTeam(MeetTeam meetTeam) async {
    mockTeams.removeWhere((mockTeam) => mockTeam.id == meetTeam.id);
    mockTeams.add(meetTeam);
    return meetTeam;
  }
}
