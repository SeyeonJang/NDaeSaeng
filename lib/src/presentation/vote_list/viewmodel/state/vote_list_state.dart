import 'package:dart_flutter/src/data/model/vote.dart';
import 'package:json_annotation/json_annotation.dart';
part 'vote_list_state.g.dart';

@JsonSerializable()
class VoteListState {
  late List<VoteResponse> votes;
  late Map<int, bool> visited;
  late bool isFirstTime;
  late bool isDetailPage;
  late int nowVoteId;

  VoteListState({
    required this.votes,
    required this.isFirstTime,
    required this.visited,
    required this.isDetailPage,
    required this.nowVoteId,
  });

  VoteListState.init() {
    votes = [];
    isFirstTime = true;
    visited = {};
    isDetailPage = false;
    nowVoteId = 0;
  }

  VoteListState copy() => VoteListState(
    votes: votes,
    isFirstTime: isFirstTime,
    visited: visited,
    isDetailPage: isDetailPage,
    nowVoteId: nowVoteId,
  );

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
  VoteListState fromJson(Map<String, dynamic> json) => _$VoteListStateFromJson(json);

  @override
  String toString() {
    return 'VoteListState{votes: $votes, visited: $visited, isFirstTime: $isFirstTime}';
  }
}
