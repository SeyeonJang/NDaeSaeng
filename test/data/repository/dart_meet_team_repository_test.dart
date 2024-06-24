import 'package:dart_flutter/src/data/datasource/dart_api_remote_datasource.dart';
import 'package:dart_flutter/src/data/model/meet_team_request_dto.dart';
import 'package:dart_flutter/src/data/model/meet_team_response_dto.dart';
import 'package:dart_flutter/src/data/repository/dart_meet_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_information.dart';

void main() {
  String defaultIndex = "3717";
  DartMeetRepository meet = DartMeetRepository();
  setUpAll(() => {
    TestInformation.dartInit()
  });

  test('과팅 내 팀 목록 조회', () async {
    var response = await DartApiRemoteDataSource.getMyTeams();
    expect(response, isNotNull);
    print(response);
  });

  MeetTeamResponseDto? teamResponseDto;
  test('과팅 팀 생성', () async {
    var teamRequestDto = MeetTeamRequestDto(
      name: 'test',
      isVisibleToSameUniversity: true,
      teamRegionIds: [1, 2, 3],
      teamUserIds: [1539],
    );

    var response = await DartApiRemoteDataSource.postTeam(teamRequestDto);

    expect(response, isNotNull);
    print(response);
    teamResponseDto = response;
  });

  test('과팅 팀 조회', () async {
    String teamId = teamResponseDto?.teamId.toString() ?? defaultIndex;
    var response = await DartApiRemoteDataSource.getTeam(teamId);
    expect(response, equals(teamResponseDto));
  });

  test('과팅 팀 삭제', () async {
    String teamId = teamResponseDto?.teamId.toString() ?? defaultIndex;
    var response = await DartApiRemoteDataSource.deleteTeam(teamId);
  });

  test('전체 과팅 팀 갯수조회', () async {
    var response = await meet.getTeamCount();
    expect(response, isNotNull);
    print(response);
  });
}
