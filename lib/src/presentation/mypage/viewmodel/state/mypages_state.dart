import 'package:dart_flutter/src/domain/entity/friend.dart';
import 'package:dart_flutter/src/domain/entity/user_response.dart';
import 'package:json_annotation/json_annotation.dart';

class MyPagesState {
  late bool isLoading;
  late UserResponse userResponse;
  late Set<Friend> friends;
  late Set<Friend> newFriends;
  late int newFriendId;
  late bool isMyLandPage;
  late bool isVertificateUploaded;

  MyPagesState({
    required this.isLoading,
    required this.userResponse,
    required this.isMyLandPage,
    required this.friends,
    required this.newFriends,
    required this.newFriendId,
    required this.isVertificateUploaded,
  });

  MyPagesState.init() {
    isLoading = false;
    userResponse = UserResponse(
      user: null,
      university: null,
    );
    friends = {};
    newFriends = {};
    newFriendId = 0;
    isMyLandPage = true;
    isVertificateUploaded = false;
  }

  MyPagesState copy() => MyPagesState(
        isLoading: isLoading,
        isMyLandPage: isMyLandPage,
        userResponse: userResponse,
        friends: friends,
        newFriends: newFriends,
        newFriendId: newFriendId,
        isVertificateUploaded: isVertificateUploaded
      );

  void setIsLoading(bool isLoading) {
    this.isLoading = isLoading;
  }

  MyPagesState setUserResponse(UserResponse userResponse) {
    this.userResponse = userResponse;
    return this;
  }

  MyPagesState setMyLandPage(bool isMyLandPage) {
    this.isMyLandPage = isMyLandPage;
    return this;
  }

  MyPagesState setMyFriends(List<Friend> friends) {
    this.friends = friends.toSet();
    return this;
  }

  MyPagesState setRecommendedFriends(List<Friend> friends) {
    newFriends = friends.toSet();
    return this;
  }

  MyPagesState setFriendId(int friendId) {
    this.newFriendId = friendId;
    return this;
  }

  void addFriend(Friend friend) {
    friends.add(friend);
    newFriends.remove(friend);
  }

  void deleteFriend(Friend friend) {
    friends.remove(friend);
    newFriends.add(friend);
  }
}
