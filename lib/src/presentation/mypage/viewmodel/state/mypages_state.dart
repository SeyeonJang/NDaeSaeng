import 'dart:io';

import 'package:dart_flutter/src/domain/entity/friend.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/entity/question.dart';
import '../../../../domain/entity/title_vote.dart';

class MyPagesState {
  late bool isLoading;
  late User userResponse;
  late Set<User> friends;
  late Set<User> newFriends;
  late int newFriendId;
  late bool isMyLandPage;
  late bool isVertificateUploaded;
  late File profileImageFile;
  late List<TitleVote> titleVotes;

  MyPagesState({
    required this.isLoading,
    required this.userResponse,
    required this.isMyLandPage,
    required this.friends,
    required this.newFriends,
    required this.newFriendId,
    required this.isVertificateUploaded,
    required this.profileImageFile,
    required this.titleVotes,
  });

  MyPagesState.init() {
    isLoading = false;
    userResponse = User(
      personalInfo: null,
      university: null,
      titleVotes: [],
    );
    friends = {};
    newFriends = {};
    newFriendId = 0;
    isMyLandPage = true;
    isVertificateUploaded = false;
    profileImageFile = File('');
    titleVotes = [];
  }

  MyPagesState copy() => MyPagesState(
        isLoading: isLoading,
        isMyLandPage: isMyLandPage,
        userResponse: userResponse,
        friends: friends,
        newFriends: newFriends,
        newFriendId: newFriendId,
        isVertificateUploaded: isVertificateUploaded,
        profileImageFile: profileImageFile,
        titleVotes: titleVotes
      );

  void setIsLoading(bool isLoading) {
    this.isLoading = isLoading;
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

  MyPagesState setTitleVotes(List<TitleVote> titleVotes) {
    this.titleVotes = titleVotes;
    return this;
  }
}
