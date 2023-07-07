import 'package:dart_flutter/src/data/model/vote.dart';
import 'package:json_annotation/json_annotation.dart';
part 'vote_list_state.g.dart';

@JsonSerializable()
class VoteListState {
  late bool isLoading;
  late List<VoteResponse> votes;
  late Map<int, bool> visited;
  late bool isFirstTime;
  late bool isDetailPage;
  late int nowVoteId;

  VoteListState({
    required this.isLoading,
    required this.votes,
    required this.isFirstTime,
    required this.visited,
    required this.isDetailPage,
    required this.nowVoteId,
  });

  VoteListState.init() {
    isLoading = false;
    votes = [];
    isFirstTime = true;
    visited = {};
    isDetailPage = false;
    nowVoteId = 0;
  }

  VoteListState copy() => VoteListState(
    isLoading: isLoading,
    votes: votes,
    isFirstTime: isFirstTime,
    visited: visited,
    isDetailPage: isDetailPage,
    nowVoteId: nowVoteId,
  );

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

  VoteListState setIsDetailPage(bool isDetailPage) {
    this.isDetailPage = isDetailPage;
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
    return 'VoteListState{isLoading: $isLoading, votes: $votes, visited: $visited, isFirstTime: $isFirstTime, isDetailPage: $isDetailPage, nowVoteId: $nowVoteId}';
  }
}
