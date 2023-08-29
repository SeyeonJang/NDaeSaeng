import 'package:dart_flutter/src/data/repository/dart_vote_repository_impl.dart';
import 'package:dart_flutter/src/domain/entity/question.dart';
import 'package:dart_flutter/src/domain/entity/vote_detail.dart';
import 'package:dart_flutter/src/domain/entity/vote_request.dart';
import 'package:dart_flutter/src/domain/entity/vote_response.dart';
import 'package:dart_flutter/src/domain/repository/vote_repository.dart';

class VoteUseCase {
  final VoteRepository _dartVoteRepository = DartVoteRepositoryImpl();

  Future<List<Question>> getNewQuestions() {
    return _dartVoteRepository.getNewQuestions();
  }

  void sendMyVote(VoteRequest voteRequest) {
    _dartVoteRepository.sendMyVote(voteRequest);
  }

  Future<List<VoteResponse>> getVotes() {
    return _dartVoteRepository.getVotes();
  }

  Future<VoteDetail> getVote(int voteId) {
    return _dartVoteRepository.getVote(voteId);
  }

  Future<DateTime> getNextVoteTime() {
    return _dartVoteRepository.getNextVoteTime();
  }

  Future<DateTime> setNextVoteTime() {
    return _dartVoteRepository.postNextVoteTime();
  }
}
