import 'package:dart_flutter/src/domain/entity/question.dart';
import 'package:dart_flutter/src/domain/entity/vote_request.dart';
import 'package:dart_flutter/src/domain/entity/vote_response.dart';
import 'package:dart_flutter/src/domain/repository/vote_repository.dart';

import '../../data/datasource/dart_api_remote_datasource.dart';
import '../model/vote_request_dto.dart';

class DartVoteRepositoryImpl implements VoteRepository {
  Future<List<Question>> getNewQuestions() async {
    return (await DartApiRemoteDataSource.getNewQuestions()).map((question) => question.newQuestion()).toList();
  }

  Future<void> sendMyVotes(List<VoteRequest> voteRequests) async {
    return await DartApiRemoteDataSource.postVotes(
      voteRequests.map((voteRequest) => VoteRequestDto.fromVoteRequest(voteRequest)).toList()
    );
  }

  Future<void> sendMyVote(VoteRequest voteRequest) async {
    return await DartApiRemoteDataSource.postVote(
        VoteRequestDto.fromVoteRequest(voteRequest)
    );
  }

  Future<List<VoteResponse>> getVotes() async {
    return (await DartApiRemoteDataSource.getVotes()).map((voteResponse) => voteResponse.newVoteResponse()).toList();
  }

  Future<VoteResponse> getVote(int voteId) async {
    return (await DartApiRemoteDataSource.getVote(voteId)).newVoteResponse();
  }

  Future<DateTime> getNextVoteTime() async {
    return await DartApiRemoteDataSource.getNextVoteTime();
  }

  Future<DateTime> postNextVoteTime() async {
    return await DartApiRemoteDataSource.postNextVoteTime();
  }
}
