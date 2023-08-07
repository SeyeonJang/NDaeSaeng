import 'package:dart_flutter/src/data/model/user_dto.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:dart_flutter/src/data/model/friend_dto.dart';

import '../../../../data/model/user_response_dto.dart';


@JsonSerializable()
class StandbyState {
  late bool isLoading;
  late bool isFirstCommCompleted;
  late List<FriendDto> addedFriends;
  late int friendsCount;
  late UserResponseDto userResponse;
  late List<FriendDto> newFriends;

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
    userResponse = UserResponseDto(
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

  StandbyState setAddedFriends(List<FriendDto> addedFriends) {
    this.addedFriends = addedFriends;
    return this;
  }

  StandbyState setRecommendedFriends(List<FriendDto> friends) {
    newFriends = friends;
    return this;
  }

  void addFriend(FriendDto friend) {
    addedFriends.add(friend); // List에 추가
    newFriends.remove(friend);
  }

  @override
  String toString() {
    return 'StandbyState{isLoading: $isLoading, addedFriends: $addedFriends, friendsCount: $friendsCount, userResponse: $userResponse}';
  }
}