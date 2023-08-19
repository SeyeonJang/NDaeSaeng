import 'package:dart_flutter/src/data/model/personal_info_dto.dart';
import 'package:dart_flutter/src/domain/entity/friend.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';

class StandbyState {
  late bool isLoading;
  late bool isFirstCommCompleted;
  late Set<User> addedFriends;
  late int friendsCount;
  late User userResponse;
  late Set<User> newFriends;

  StandbyState({
    required this.isLoading,
    required this.isFirstCommCompleted,
    required this.addedFriends,
    required this.friendsCount,
    required this.userResponse,
    required this.newFriends,
  });

  StandbyState.init() {
    addedFriends = {};
    friendsCount = 0;
    userResponse = User(
      personalInfo: null,
      university: null,
    );
    isLoading = false;
    isFirstCommCompleted = false;
    newFriends = {};
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
    this.addedFriends = addedFriends.toSet();
    return this;
  }

  StandbyState setRecommendedFriends(List<User> friends) {
    newFriends = friends.toSet();
    return this;
  }

  void addFriend(User friend) {
    addedFriends.add(friend);
    newFriends.remove(friend);
  }

  @override
  String toString() {
    return 'StandbyState{isLoading: $isLoading, addedFriends: $addedFriends, friendsCount: $friendsCount, userResponse: $userResponse}';
  }
}