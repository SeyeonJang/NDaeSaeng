import 'package:dart_flutter/src/domain/entity/title_vote.dart';
import 'package:dart_flutter/src/domain/repository/title_vote_repository.dart';

class CacheMyTitleVoteRepository implements TitleVoteRepository {
  static final Set<TitleVote> titleVotes = {};

  @override
  Future<List<TitleVote>> addTitleVote(TitleVote titleVote) async {
    titleVotes.add(titleVote);
    return titleVotes.toList();
  }

  @override
  Future<List<TitleVote>> getMyTitleVote() async {
    return titleVotes.toList();
 }

  @override
  Future<List<TitleVote>> removeTitleVote(int questionId) async {
    titleVotes.removeWhere((e) => e.question.questionId == questionId);
    return titleVotes.toList();
  }

  @override
  void setTitleVotes(List<TitleVote> titleVotes) {
    CacheMyTitleVoteRepository.titleVotes.addAll(titleVotes);
  }
}
