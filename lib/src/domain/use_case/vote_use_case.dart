import 'package:dart_flutter/src/data/repository/dart_vote_repository.dart';
import 'package:dart_flutter/src/domain/entity/question.dart';
import 'package:dart_flutter/src/domain/entity/vote_request.dart';
import 'package:dart_flutter/src/domain/entity/vote_response.dart';

class VoteUseCase {
  final DartVoteRepository _dartVoteRepository = DartVoteRepository();

  Future<List<Question>> getNewQuestions() {
    return _dartVoteRepository.getNewQuestions();
  }

  void sendMyVote(VoteRequest voteRequest) {
    _dartVoteRepository.sendMyVote(voteRequest);
  }

  Future<List<VoteResponse>> getVotes() {
    return _dartVoteRepository.getVotes();
  }

  Future<VoteResponse> getVote(int voteId) {
    return _dartVoteRepository.getVote(voteId);
  }

  Future<DateTime> getNextVoteTime() {
    return _dartVoteRepository.getNextVoteTime();
  }

  Future<DateTime> setNextVoteTime() {
    return _dartVoteRepository.postNextVoteTime();
  }
}
