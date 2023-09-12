import 'package:dart_flutter/src/domain/entity/matched_teams.dart';
import 'package:dart_flutter/src/domain/entity/matched_teams_detail.dart';

abstract class ChatRepository {
  Future<MatchedTeams> getMatchedTeam(int teamId);
  Future<List<MatchedTeams>> getMatchedTeams();
  // Future<MatchedTeamsDetail> getMatchedTeamsDetail(int teamId);
}