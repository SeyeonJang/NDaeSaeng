import 'package:dart_flutter/src/domain/entity/matched_teams.dart';
import 'package:dart_flutter/src/domain/repository/chat_repository.dart';

class MockChatRepository implements ChatRepository {
  static final List<MatchedTeams> mockMatchedTeams = [];

  @override
  Future<MatchedTeams> getMatchedTeam(int teamId) async {
    return mockMatchedTeams.map((mockMatchedTeam) => mockMatchedTeam.id == teamId ? mockMatchedTeam : throw Error()).first;
  }

  @override
  Future<List<MatchedTeams>> getMatchedTeams() async {
    return mockMatchedTeams;
  }
}