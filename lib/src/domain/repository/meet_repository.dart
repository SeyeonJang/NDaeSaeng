import 'package:dart_flutter/src/data/model/proposal_request_dto.dart';
import 'package:dart_flutter/src/domain/entity/meet_team.dart';

abstract class MeetRepository {
  Future<MeetTeam> createNewTeam(MeetTeam meetTeam);
  Future<MeetTeam> getTeam(String teamId);
  Future<List<MeetTeam>> getMyTeams();
  Future<void> removeMyTeam(String teamId);
  Future<MeetTeam> updateMyTeam(MeetTeam meetTeam);
  Future<int> getTeamCount();
  Future<void> postProposal(ProposalRequestDto proposalRequestDto);
}
