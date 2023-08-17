import 'package:dart_flutter/src/domain/entity/title_vote.dart';

abstract class TitleVoteRepository {
  Future<List<TitleVote>> addTitleVote(TitleVote titleVote);
  Future<List<TitleVote>> removeTitleVote(int questionId);
  Future<List<TitleVote>> getMyTitleVote();
}
