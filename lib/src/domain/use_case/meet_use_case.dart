import 'package:dart_flutter/src/data/model/proposal_request_dto.dart';
import 'package:dart_flutter/src/data/repository/dart_location_repository.dart';
import 'package:dart_flutter/src/data/repository/dart_meet_repository.dart';
import 'package:dart_flutter/src/domain/entity/blind_date_team.dart';
import 'package:dart_flutter/src/domain/entity/location.dart';
import 'package:dart_flutter/src/domain/entity/meet_team.dart';
import 'package:dart_flutter/src/domain/repository/blind_date_team_repository.dart';
import 'package:dart_flutter/src/domain/repository/location_repository.dart';
import 'package:dart_flutter/src/domain/repository/meet_repository.dart';

import '../../common/pagination/pagination.dart';
import '../../data/repository/dart_team_repository_impl.dart';
import '../entity/blind_date_team_detail.dart';

class MeetUseCase {
  final MeetRepository _meetRepository = DartMeetRepository();
  final LocationRepository _locationRepository = DartLocationRepository();
  final BlindDateTeamRepository _blindDateTeamRepository = DartTeamRepositoryImpl();

  Future<MeetTeam> createNewTeam(MeetTeam meetTeam) async {
    return await _meetRepository.createNewTeam(meetTeam);
  }

  Future<MeetTeam> getTeam(String teamId) async {
    return _meetRepository.getTeam(teamId);
  }

  Future<List<MeetTeam>> getMyTeams() async {
    return _meetRepository.getMyTeams();
  }

  Future<void> removeTeam(String teamId) async {
    await _meetRepository.removeMyTeam(teamId);
    print("usecase - 팀 삭제 완료");
  }

  void updateMyTeam(MeetTeam meetTeam) {
    _meetRepository.updateMyTeam(meetTeam);
  }

  Future<int> getTeamCount() async {
    return _meetRepository.getTeamCount();
  }

  Future<List<Location>> getLocations() async {
    return _locationRepository.getLocations();
  }

  Future<BlindDateTeamDetail> getBlindDateTeam(int id) async {
    return _blindDateTeamRepository.getTeam(id);
  }

  Future<Pagination<BlindDateTeam>> getBlindDateTeams({int page = 0, int size = 10, int targetLocationId = 0}) async {
    return _blindDateTeamRepository.getTeams(page: page, size: size, targetLocationId: targetLocationId);
  }

  Future<void> postProposal(ProposalRequestDto proposalRequest) async {
    _meetRepository.postProposal(proposalRequest);
  }
}
