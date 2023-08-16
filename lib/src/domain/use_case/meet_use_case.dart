import 'package:dart_flutter/src/data/repository/mock_meet_repository.dart';
import 'package:dart_flutter/src/domain/entity/meet_team.dart';
import 'package:dart_flutter/src/domain/repository/meet_repository.dart';

class MeetUseCase {
  final MeetRepository _meetRepository = MockMeetRepository();

  void createNewTeam(MeetTeam meetTeam) {
    _meetRepository.createNewTeam(meetTeam);
  }

  Future<MeetTeam> getTeam(String teamId) async {
    return _meetRepository.getTeam(teamId);
  }

  Future<List<MeetTeam>> getMyTeams() {
    return _meetRepository.getMyTeams();
  }

  void removeTeam(String teamId) {
    _meetRepository.removeMyTeam(teamId);
  }

  void updateMyTeam(MeetTeam meetTeam) {
    _meetRepository.updateMyTeam(meetTeam);
  }

}