import 'package:dart_flutter/src/data/repository/mock_chat_repository.dart';
import 'package:dart_flutter/src/domain/entity/matched_teams.dart';
import 'package:dart_flutter/src/domain/repository/chat_repository.dart';

class ChatUseCase {
  final ChatRepository _chatRepository = MockChatRepository();

  Future<MatchedTeams> getMatchedTeam(int teamId) async {
    return _chatRepository.getMatchedTeam(teamId);
  }

  Future<List<MatchedTeams>> getMatchedTeams() async {
    return _chatRepository.getMatchedTeams();
  }
}