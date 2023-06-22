import '../../datasource/dart_api_remote_datasource.dart';
import '../model/vote.dart';

class DartVoteRepository {
  Future<List<VoteResponse>> getNewVotes(String acessToken) async {
    return await DartApiRemoteDataSource.getNewVotes(acessToken);
  }

  Future<void> sendMyVotes(String acessToken, List<VoteRequest> voteRequest) async {
    return await DartApiRemoteDataSource.postVotes(acessToken, voteRequest);
  }

  Future<List<VoteResponse>> getVotes(String accessToken) async {
    return await DartApiRemoteDataSource.getVotes(accessToken);
  }

  Future<VoteResponse> getVote(int voteId) async {
    return await DartApiRemoteDataSource.getVote(voteId);
  }

  Future<Hint> getHint(String accessToken, int voteId, String typeOfHint) async {
    return await DartApiRemoteDataSource.getHint(accessToken, voteId, typeOfHint);
  }

  Future<int> canIVote(String accessToken) async {
    return await DartApiRemoteDataSource.getCanIVote(accessToken);
  }

  Future<void> updateMyNextVoteTime(String accessToken) async {
    return await DartApiRemoteDataSource.updateMyNextVoteTime(accessToken);
  }
}
