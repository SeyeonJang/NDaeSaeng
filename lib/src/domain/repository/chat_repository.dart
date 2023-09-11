import 'package:dart_flutter/src/domain/entity/matched_teams.dart';

abstract class ChatRepository {
  Future<MatchedTeams> getMatchedTeam(int teamId);
  Future<List<MatchedTeams>> getMatchedTeams();
}