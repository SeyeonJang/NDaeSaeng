import 'dart:io';

import 'package:dart_flutter/src/domain/entity/user.dart';

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
  late List<TitleVote> myAllVotes;
  late String appVersion;

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
    required this.myAllVotes,
    required this.appVersion,
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
    myAllVotes = [];
    appVersion = "";
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
        titleVotes: titleVotes,
        myAllVotes: myAllVotes,
        appVersion: appVersion
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

  MyPagesState setMyAllVotes(List<TitleVote> myAllVotes) {
    // this.myAllVotes = myAllVotes.where((vote) => !titleVotes.contains(vote)).toList();
    // this.myAllVotes = myAllVotes.where((vote) => vote.question.questionId != ( )).toList();

    this.myAllVotes = myAllVotes.where((vote) {
      for (var titleVote in titleVotes) {
        if (titleVote.question.questionId == vote.question.questionId) {
          return false; // 중복된 항목이므로 필터링
        }
      }
      return true; // 중복되지 않은 항목이므로 유지
    }).toList();

    // 내림차순 정렬
    this.myAllVotes.sort((a, b) => b.count.compareTo(a.count));

    // myAllVotes = myAllVotes.where((vote) {
    //   return !titleVotes.any((titleVote) => titleVote.question.questionId == vote.question.questionId);
    // }).toList();
    return this;
  }

  void addMyAllVotes(TitleVote vote) {
    myAllVotes.add(vote);
  }

  void removeMyAllVotes(TitleVote vote) {
    myAllVotes.remove(vote);
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
    this.titleVotes = titleVotes.toSet().toList();
    return this;
  }

  void setAppVersion(String appVersion) {
    this.appVersion = appVersion;
  }
}
