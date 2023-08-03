import 'package:dart_flutter/src/data/model/user.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:dart_flutter/src/data/model/friend.dart';


@JsonSerializable()
class StandbyState {
  late bool isLoading;
  late bool isFirstCommCompleted;
  late List<Friend> addedFriends;
  late int friendsCount;
  late UserResponse userResponse;
  late List<Friend> newFriends;

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
    userResponse = UserResponse( // TODO : 초대코드를 받아와야함!!!!!!!!!
      user: null,
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

  StandbyState setAddedFriends(List<Friend> addedFriends) {
    this.addedFriends = addedFriends;
    return this;
  }

  StandbyState setRecommendedFriends(List<Friend> friends) {
    newFriends = friends;
    return this;
  }

  void addFriend(Friend friend) {
    addedFriends.add(friend); // List에 추가
    print("add - ${friend.toString()}");
    newFriends.remove(friend);
    print("removed - ${friend.toString()}");

    print("=========================[");
    print(addedFriends.toString());
    print(newFriends.toString());
  }

  @override
  String toString() {
    return 'StandbyState{isLoading: $isLoading, addedFriends: $addedFriends, friendsCount: $friendsCount, userResponse: $userResponse}';
  }
}