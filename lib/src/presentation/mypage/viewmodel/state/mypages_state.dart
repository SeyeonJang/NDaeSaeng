import 'package:dart_flutter/src/domain/entity/friend.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';
import 'package:json_annotation/json_annotation.dart';

class MyPagesState {
  late bool isLoading;
  late User userResponse;
  late Set<User> friends;
  late Set<User> newFriends;
  late int newFriendId;
  late bool isMyLandPage;
  late bool isVertificateUploaded;
  late String newNickName;

  MyPagesState({
    required this.isLoading,
    required this.userResponse,
    required this.isMyLandPage,
    required this.friends,
    required this.newFriends,
    required this.newFriendId,
    required this.isVertificateUploaded,
    required this.newNickName,
  });

  MyPagesState.init() {
    isLoading = false;
    userResponse = User(
      personalInfo: null,
      university: null,
    );
    friends = {};
    newFriends = {};
    newFriendId = 0;
    isMyLandPage = true;
    isVertificateUploaded = false;
    newNickName = '';
  }

  MyPagesState copy() => MyPagesState(
        isLoading: isLoading,
        isMyLandPage: isMyLandPage,
        userResponse: userResponse,
        friends: friends,
        newFriends: newFriends,
        newFriendId: newFriendId,
        isVertificateUploaded: isVertificateUploaded,
        newNickName: newNickName
      );

  void setIsLoading(bool isLoading) {
    this.isLoading = isLoading;
  }

  void setNickName(String name) {

  }

  MyPagesState setUserResponse(User userResponse) {
    this.userResponse = userResponse;
    return this;
  }

  MyPagesState setMyLandPage(bool isMyLandPage) {
    this.isMyLandPage = isMyLandPage;
    return this;
  }

  MyPagesState setMyFriends(List<User> friends) {
    this.friends = friends.toSet();
    return this;
  }

  MyPagesState setRecommendedFriends(List<User> friends) {
    newFriends = friends.toSet();
    return this;
  }

  MyPagesState setFriendId(int friendId) {
    this.newFriendId = friendId;
    return this;
  }

  void addFriend(User friend) {
    friends.add(friend);
    newFriends.remove(friend);
  }

  void deleteFriend(User friend) {
    friends.remove(friend);
    newFriends.add(friend);
  }
}
