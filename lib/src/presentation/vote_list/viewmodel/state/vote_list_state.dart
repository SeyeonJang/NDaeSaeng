import 'package:dart_flutter/src/domain/entity/vote_response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';

part 'vote_list_state.g.dart';

@JsonSerializable()
class VoteListState {
  late bool isLoading;
  late List<VoteResponse> votes;
  late Map<int, bool> visited;
  late bool isFirstTime;
  late int nowVoteId;
  late User userMe;

  VoteListState({
    required this.isLoading,
    required this.votes,
    required this.isFirstTime,
    required this.visited,
    required this.nowVoteId,
    required this.userMe
  });

  VoteListState.init() {
    isLoading = false;
    votes = [];
    isFirstTime = true;
    visited = {};
    nowVoteId = 0;
    userMe = User(
      personalInfo: null,
      university: null,
      titleVotes: [],
    );
  }

  VoteListState copy() => VoteListState(
    isLoading: isLoading,
    votes: votes,
    isFirstTime: isFirstTime,
    visited: visited,
    nowVoteId: nowVoteId,
    userMe: userMe
  );

  VoteListState setUserMe(userMe) {
    this.userMe = userMe;
    return this;
  }

  VoteListState setIsLoading(bool isLoading) {
    this.isLoading = isLoading;
    return this;
  }

  VoteListState setVotes(List<VoteResponse> votes) {
    this.votes = votes;
    return this;
  }

  VoteListState firstTime() {
    isFirstTime = false;
    return this;
  }

  VoteListState setVoteId(int voteId) {
    this.nowVoteId = voteId;
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

  Map<String, dynamic> toJson() => _$VoteListStateToJson(this);
  VoteListState fromJson(Map<String, dynamic> json) {
    return _$VoteListStateFromJson(json);
  }

  @override
  String toString() {
    return 'VoteListState{isLoading: $isLoading, votes: $votes, visited: $visited, isFirstTime: $isFirstTime, nowVoteId: $nowVoteId}';
  }
}
