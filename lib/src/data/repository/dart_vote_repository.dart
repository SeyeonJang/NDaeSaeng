import 'package:dart_flutter/src/data/model/question_dto.dart';

import '../../datasource/dart_api_remote_datasource.dart';
import '../model/vote_request_dto.dart';
import '../model/vote_response_dto.dart';

class DartVoteRepository {
  Future<List<QuestionDto>> getNewQuestions() async {
    return await DartApiRemoteDataSource.getNewQuestions();
  }

  Future<void> sendMyVotes(List<VoteRequestDto> voteRequests) async {
    return await DartApiRemoteDataSource.postVotes(voteRequests);
  }

  Future<void> sendMyVote(VoteRequestDto voteRequest) async {
    return await DartApiRemoteDataSource.postVote(voteRequest);
  }

  Future<List<VoteResponseDto>> getVotes() async {
    return await DartApiRemoteDataSource.getVotes();
  }

  Future<VoteResponseDto> getVote(int voteId) async {
    return await DartApiRemoteDataSource.getVote(voteId);
  }

  Future<DateTime> getNextVoteTime() async {
    return await DartApiRemoteDataSource.getNextVoteTime();
  }

  Future<DateTime> postNextVoteTime() async {
    return await DartApiRemoteDataSource.postNextVoteTime();
  }
}
