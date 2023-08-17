import 'package:dart_flutter/src/domain/entity/title_vote.dart';
import 'package:dart_flutter/src/domain/repository/title_vote_repository.dart';

class DartTitleVoteRepository implements TitleVoteRepository {
  static final List<TitleVote> titleVotes = [];

  @override
  Future<List<TitleVote>> addTitleVote(TitleVote titleVote) async {
    titleVotes.add(titleVote);
    return titleVotes;
  }

  @override
  Future<List<TitleVote>> getMyTitleVote() async {
    return titleVotes;
 }

  @override
  Future<List<TitleVote>> removeTitleVote(int questionId) async {
    titleVotes.removeWhere((e) => e.question.questionId == questionId);
    return titleVotes;
  }
}
