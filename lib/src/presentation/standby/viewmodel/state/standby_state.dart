import 'package:dart_flutter/src/domain/entity/user.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class StandbyState {
  late bool isLoading;
  late bool isFirstCommCompleted;
  late List<User> addedFriends;
  late int friendsCount;
  late User userResponse;
  late List<User> newFriends;

  StandbyState({
    required this.isLoading,
    required this.isFirstCommCompleted,
    required this.addedFriends,
    required this.friendsCount,
    required this.userResponse,
    required this.newFriends,
  });

  StandbyState.init() {
    addedFriends = [];
    friendsCount = 0;
    userResponse = User(
      personalInfo: null,
      university: null,
    );
    isLoading = false;
    isFirstCommCompleted = false;
    newFriends = [];
  }

  StandbyState copy() => StandbyState(
    isLoading: isLoading,
    isFirstCommCompleted: isFirstCommCompleted,
    addedFriends: addedFriends,
    friendsCount: friendsCount,
    userResponse: userResponse,
    newFriends: newFriends,
  );

  StandbyState setAddedFriends(List<User> addedFriends) {
    this.addedFriends = addedFriends;
    return this;
  }

  StandbyState setRecommendedFriends(List<User> friends) {
    newFriends = friends;
    return this;
  }

  void addFriend(User friend) {
    addedFriends.add(friend); // List에 추가
    newFriends.remove(friend);
  }

  @override
  String toString() {
    return 'StandbyState{isLoading: $isLoading, addedFriends: $addedFriends, friendsCount: $friendsCount, userResponse: $userResponse}';
  }
}