import 'package:dart_flutter/src/data/datasource/dart_api_remote_datasource.dart';
import 'package:dart_flutter/src/domain/entity/meet_team.dart';
import 'package:dart_flutter/src/domain/repository/meet_repository.dart';

import '../model/meet_team_request_dto.dart';

class DartMeetRepository implements MeetRepository {
  @override
  Future<MeetTeam> createNewTeam(MeetTeam meetTeam) async {
    var teamRequestDto = MeetTeamRequestDto.fromMeetTeam(meetTeam);
    return (await DartApiRemoteDataSource.postTeam(teamRequestDto)).newMeetTeam();
  }

  @override
  Future<List<MeetTeam>> getMyTeams() async {
    return (await DartApiRemoteDataSource.getMyTeams()).map((teamResponse) => teamResponse.newMeetTeam()).toList();
  }

  @override
  Future<MeetTeam> getTeam(String teamId) async {
    return (await DartApiRemoteDataSource.getTeam(teamId)).newMeetTeam();
  }

  @override
  void removeMyTeam(String teamId) async {
    await DartApiRemoteDataSource.deleteTeam(teamId);
  }

  @override
  Future<MeetTeam> updateMyTeam(MeetTeam meetTeam) async {
    return (await DartApiRemoteDataSource.putTeam(MeetTeamRequestDto.fromMeetTeam(meetTeam))).newMeetTeam();
  }

  @override
  Future<int> getTeamCount() async {
    return await DartApiRemoteDataSource.getTeamCount();
  }
}
