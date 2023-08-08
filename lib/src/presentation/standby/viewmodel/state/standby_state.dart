import 'package:dart_flutter/src/data/model/user_dto.dart';
import 'package:dart_flutter/src/domain/entity/friend.dart';
import 'package:dart_flutter/src/domain/entity/user_response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:dart_flutter/src/data/model/friend_dto.dart';

import '../../../../data/model/user_response_dto.dart';


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
    userResponse = UserResponse(
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
    newFriends.remove(friend);
  }

  @override
  String toString() {
    return 'StandbyState{isLoading: $isLoading, addedFriends: $addedFriends, friendsCount: $friendsCount, userResponse: $userResponse}';
  }
}