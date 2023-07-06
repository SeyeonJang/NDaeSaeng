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

  Future<List<VoteResponse>> getVotes(String accessToken) async {
    return await DartApiRemoteDataSource.getVotes(accessToken);
  }

  Future<VoteResponse> getVote(int voteId) async {
    return await DartApiRemoteDataSource.getVote(voteId);
  }

  Future<int> canIVote(String accessToken) async {
    return await DartApiRemoteDataSource.getCanIVote(accessToken);
  }

  Future<void> updateMyNextVoteTime(String accessToken) async {
    return await DartApiRemoteDataSource.updateMyNextVoteTime(accessToken);
  }
}
