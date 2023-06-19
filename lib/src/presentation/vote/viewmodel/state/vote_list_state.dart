import 'package:dart_flutter/src/data/model/vote.dart';

class VoteListState {
  late List<VoteResponse> votes;
  late Map<int, bool> visited;
  late bool isFirstTime;

  VoteListState({
    required this.votes,
    required this.isFirstTime,
    required this.visited,
  });

  VoteListState.init() {
    votes = [];
    isFirstTime = true;
    visited = {};
  }

  VoteListState copy() => VoteListState(
    votes: votes,
    isFirstTime: isFirstTime,
    visited: visited,
  );

  VoteListState setVotes(List<VoteResponse> votes) {
    this.votes = votes;
    return this;
  }

  VoteListState visitByVoteId(int voteId) {
    visited[voteId] = true;
    return this;
  }

  VoteResponse getVoteById(int id) {
    return votes.firstWhere((element) => element.voteId == id);
  }

  bool isVisited(int id) {
    return visited[id] ?? false;
  }
}
