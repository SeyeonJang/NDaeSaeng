import 'package:dart_flutter/src/data/model/friend_dto.dart';
import 'package:dart_flutter/src/data/model/user_dto.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../data/model/user_response_dto.dart';

@JsonSerializable()
class MyPagesState {
  late bool isLoading;
  late UserResponseDto userResponse;
  late Set<FriendDto> friends;
  late Set<FriendDto> newFriends;
  late int newFriendId;
  late bool isMyLandPage;

  MyPagesState({
    required this.isLoading,
    required this.userResponse,
    required this.isMyLandPage,
    required this.friends,
    required this.newFriends,
    required this.newFriendId,
  });

  MyPagesState.init() {
    isLoading = false;
    userResponse = UserResponseDto(
      user: null,
      university: null,
    );
    friends = {};
    newFriends = {};
    newFriendId = 0;
    isMyLandPage = true;
  }

  MyPagesState copy() => MyPagesState(
        isLoading: isLoading,
        isMyLandPage: isMyLandPage,
        userResponse: userResponse,
        friends: friends,
        newFriends: newFriends,
        newFriendId: newFriendId,
      );

  void setIsLoading(bool isLoading) {
    this.isLoading = isLoading;
  }

  MyPagesState setUserResponse(UserResponseDto userResponse) {
    this.userResponse = userResponse;
    return this;
  }

  MyPagesState setMyLandPage(bool isMyLandPage) {
    this.isMyLandPage = isMyLandPage;
    return this;
  }

  MyPagesState setMyFriends(List<FriendDto> friends) {
    this.friends = friends.toSet();
    return this;
  }

  MyPagesState setRecommendedFriends(List<FriendDto> friends) {
    newFriends = friends.toSet();
    return this;
  }

  MyPagesState setFriendId(int friendId) {
    this.newFriendId = friendId;
    return this;
  }

  void addFriend(FriendDto friend) {
    friends.add(friend);
    newFriends.remove(friend);
  }

  void deleteFriend(FriendDto friend) {
    friends.remove(friend);
    newFriends.add(friend);
  }
}
