import 'package:dart_flutter/src/domain/entity/question.dart';
import 'package:dart_flutter/src/domain/entity/title_vote.dart';
import 'package:dart_flutter/src/domain/entity/vote_request.dart';
import 'package:dart_flutter/src/domain/entity/vote_response.dart';
import 'package:dart_flutter/src/domain/repository/vote_repository.dart';

import '../../data/datasource/dart_api_remote_datasource.dart';
import '../model/vote_request_dto.dart';

class DartVoteRepositoryImpl implements VoteRepository {
  @override
  Future<List<Question>> getNewQuestions() async {
    return (await DartApiRemoteDataSource.getNewQuestions()).map((question) => question.newQuestion()).toList();
  }

  @override
  Future<void> sendMyVotes(List<VoteRequest> voteRequests) async {
    return await DartApiRemoteDataSource.postVotes(
      voteRequests.map((voteRequest) => VoteRequestDto.fromVoteRequest(voteRequest)).toList()
    );
  }

  @override
  Future<void> sendMyVote(VoteRequest voteRequest) async {
    return await DartApiRemoteDataSource.postVote(
        VoteRequestDto.fromVoteRequest(voteRequest)
    );
  }

  @override
  Future<List<VoteResponse>> getVotes() async {
    return (await DartApiRemoteDataSource.getVotes()).map((voteResponse) => voteResponse.newVoteResponse()).toList();
  }

  @override
  Future<VoteResponse> getVote(int voteId) async {
    return (await DartApiRemoteDataSource.getVote(voteId)).newVoteResponse();
  }

  @override
  Future<DateTime> getNextVoteTime() async {
    return await DartApiRemoteDataSource.getNextVoteTime();
  }

  @override
  Future<DateTime> postNextVoteTime() async {
    return await DartApiRemoteDataSource.postNextVoteTime();
  }

  @override
  Future<List<TitleVote>> getVotesssssssssssssssssss() async {
    List<TitleVote> mockData = [];
    mockData.add(TitleVote(question: Question(questionId: 1, content: "짱짱멋진사람", icon: ""), count: 10));
    mockData.add(TitleVote(question: Question(questionId: 2, content: "다트부셔버려", icon: ""), count: 1));
    mockData.add(TitleVote(question: Question(questionId: 3, content: "잠을자고싶다", icon: ""), count: 6));
    mockData.add(TitleVote(question: Question(questionId: 4, content: "101개입니다A", icon: ""), count: 101));
    mockData.add(TitleVote(question: Question(questionId: 4, content: "101개입니다A", icon: ""), count: 101));
    mockData.add(TitleVote(question: Question(questionId: 4, content: "101개입니다A", icon: ""), count: 101));
    mockData.add(TitleVote(question: Question(questionId: 4, content: "101개입니다A", icon: ""), count: 101));
    mockData.add(TitleVote(question: Question(questionId: 4, content: "101개입니다A", icon: ""), count: 101));
    mockData.add(TitleVote(question: Question(questionId: 4, content: "101개입니다A", icon: ""), count: 101));
    mockData.add(TitleVote(question: Question(questionId: 4, content: "101개입니다A", icon: ""), count: 101));
    mockData.add(TitleVote(question: Question(questionId: 4, content: "101개입니다A", icon: ""), count: 101));
    return mockData;
  }

}
