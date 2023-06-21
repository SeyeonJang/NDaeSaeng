import 'package:dart_flutter/src/data/model/friend.dart';
import 'package:dart_flutter/src/data/model/vote.dart';
import 'package:json_annotation/json_annotation.dart';
part 'vote_state.g.dart';

@JsonSerializable()
class VoteState {
  static const int MAX_VOTE_ITERATOR = 8;

  late VoteStep step;
  late int voteIterator;
  late List<VoteRequest> votes;
  late DateTime nextVoteDateTime;
  late List<Friend> friends;

  VoteState({
    required this.step,
    required this.voteIterator,
    required this.votes,
    required this.nextVoteDateTime,
    required this.friends,
  });

  VoteState.init() {
    step = VoteStep.start;
    voteIterator = 0;
    votes = [];
    nextVoteDateTime = DateTime.now();
    friends = [];
  }

  VoteState copy() => VoteState(
    step: step,
    voteIterator: voteIterator,
    votes: votes,
    nextVoteDateTime: nextVoteDateTime,
    friends: friends,
  );

  VoteState setStep(VoteStep step) {
    this.step = step;
    return this;
  }

  VoteState setNextVoteDateTime(DateTime nextVoteDateTime) {
    this.nextVoteDateTime = nextVoteDateTime;
    return this;
  }

  VoteState setFriends(List<Friend> friends) {
    this.friends = friends;
    return this;
  }

  List<Friend> getShuffleFriends() {
    return friends..shuffle();
  }

  void addVote(VoteRequest vote) {
    votes.add(vote);
  }

  void pickUserInVote(int numberOfVote, int pickUserId) {
    votes[numberOfVote].pickUserId = pickUserId;
  }

  bool isVoteTimeOver() {
    return nextVoteDateTime.isBefore(DateTime.now());
  }

  int leftNextVoteTime() {
    return nextVoteDateTime.difference(DateTime.now()).inSeconds;
  }

  void nextVote() {
    voteIterator++;
    if (voteIterator >= MAX_VOTE_ITERATOR) {
      step = VoteStep.done;
      voteIterator = 0;
    }
  }

  bool isVoteDone() {
    return step == VoteStep.done;
  }

  Map<String, dynamic> toJson() => _$VoteStateToJson(this);
  VoteState fromJson(Map<String, dynamic> json) => _$VoteStateFromJson(json);

  @override
  String toString() {
    return 'VoteState{step: $step, voteIterator: $voteIterator, votes: $votes, nextVoteDateTime: $nextVoteDateTime}';
  }
}

enum VoteStep {
  start, process, done, wait;

  get isStart => this == VoteStep.start;
  get isProcess => this == VoteStep.process;
  get isDone => this == VoteStep.done;
  get isWait => this == VoteStep.wait;
}
