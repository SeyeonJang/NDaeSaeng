import 'package:dart_flutter/src/data/model/user.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:dart_flutter/src/data/model/friend.dart';


@JsonSerializable()
class StandbyState {
  late bool isLoading;
  late List<Friend> addedFriends;
  late int friendsCount;
  late UserResponse userResponse;

  StandbyState({
    required this.isLoading,
    required this.addedFriends,
    required this.friendsCount,
    required this.userResponse,
  });

  StandbyState.init() {
    print("init 확인3");
    addedFriends = [];
    friendsCount = 0;
    userResponse = UserResponse( // TODO : 초대코드를 받아와야함!!!!!!!!!
      user: null,
      university: null,
    );
    isLoading = false;
    print("init 확인");
  }

  StandbyState copy() => StandbyState(
    isLoading: isLoading,
    addedFriends: addedFriends,
    friendsCount: friendsCount,
    userResponse: userResponse,
  );

  StandbyState setAddedFriends(List<Friend> addedFriends) {
    this.addedFriends = addedFriends;
    return this;
  }

  void addFriend(Friend friend) {
    addedFriends.add(friend); // List에 추가
  }

}