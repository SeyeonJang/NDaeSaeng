import 'package:dart_flutter/src/data/model/question.dart';

import '../../datasource/dart_api_remote_datasource.dart';
import '../model/vote.dart';

class DartVoteRepository {
  Future<List<Question>> getNewQuestions() async {
    return await DartApiRemoteDataSource.getNewQuestions();
  }

  Future<void> sendMyVotes(List<VoteRequest> voteRequests) async {
    return await DartApiRemoteDataSource.postVotes(voteRequests);
  }

  Future<void> sendMyVote(VoteRequest voteRequest) async {
    return await DartApiRemoteDataSource.postVote(voteRequest);
  }

  Future<List<VoteResponse>> getVotes() async {
    return await DartApiRemoteDataSource.getVotes();
  }

  Future<VoteResponse> getVote(int voteId) async {
    return await DartApiRemoteDataSource.getVote(voteId);
  }

  Future<DateTime> getNextVoteTime() async {
    return await DartApiRemoteDataSource.getNextVoteTime();
  }

  Future<DateTime> postNextVoteTime() async {
    return await DartApiRemoteDataSource.postNextVoteTime();
  }
}
