// import 'package:dart_flutter/src/data/model/vote.dart';
import 'package:dart_flutter/src/data/model/friend.dart';
import 'package:dart_flutter/src/data/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class MyPagesState {
  late List<Friend> friends;
  late List<Friend> newFriends;
  late int newfriendId;
  late bool isMyLandPage;
  late bool isSettings;
  late bool isTos1;
  late bool isTos2;
  late UserResponse userResponse;

  MyPagesState({
    required this.isMyLandPage,
    required this.friends,
    required this.newFriends,
    required this.isSettings,
    required this.newfriendId,
    required this.isTos1,
    required this.isTos2,
    required this.userResponse,
  });

  MyPagesState.init() {
    isMyLandPage = true;
    friends = [];
    newFriends = [];
    isSettings = false;
    newfriendId = 0;
    isTos1 = false;
    isTos2 = false;
    userResponse = UserResponse(
      userId: null,
      univId: null,
      admissionNumber: null,
      point: null,
      name: '',
      phone: '',
      universityName: '',
      department: '',
      nextVoteDateTime: null,
    );
  }

  MyPagesState copy() => MyPagesState(
        isMyLandPage: isMyLandPage,
        friends: friends,
        newFriends: newFriends,
        isSettings: isSettings,
        newfriendId: newfriendId,
        isTos1: isTos1,
        isTos2: isTos2,
        userResponse: userResponse,
      );

  MyPagesState setMyLandPage(bool isMyLandPage) {
    this.isMyLandPage = isMyLandPage;
    return this;
  }

  MyPagesState setUserInfo(List<Friend> friends) {
    this.friends = friends;
    return this;
  }

  MyPagesState setRecommendedFriends(List<Friend> friends) {
    newFriends = friends;
    return this;
  }

  MyPagesState setIsSettingPage(bool isSettings) {
    this.isSettings = isSettings;
    return this;
  }

  MyPagesState setFriendId(int friendId) {
    this.newfriendId = friendId;
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

  MyPagesState setIsTos1(bool isTos1) {
    this.isTos1 = isTos1;
    return this;
  }

  MyPagesState setIsTos2(bool isTos2) {
    this.isTos2 = isTos2;
    return this;
  }
}
