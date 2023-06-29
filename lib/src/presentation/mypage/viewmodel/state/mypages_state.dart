// import 'package:dart_flutter/src/data/model/vote.dart';
import 'package:dart_flutter/src/data/model/friend.dart';
import 'package:dart_flutter/src/data/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class MyPagesState {
  late bool isMyLandPage;
  late List<Friend> friends;
  late bool isSettings;
  late Map<int, bool> addedFriend;
  late int newfriendId;
  late bool isTos1;
  late bool isTos2;
  late UserResponse userResponse;

  MyPagesState({
    required this.isMyLandPage,
    required this.friends,
    required this.isSettings,
    required this.addedFriend,
    required this.newfriendId,
    required this.isTos1,
    required this.isTos2,
    required this.userResponse,
  });

  MyPagesState.init() {
    isMyLandPage = true;
    friends = [];
    isSettings = false;
    addedFriend = {};
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
        isSettings: isSettings,
        addedFriend: addedFriend,
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

  MyPagesState setIsSettingPage(bool isSettings) {
    this.isSettings = isSettings;
    return this;
  }

  MyPagesState setFriendId(int friendId) {
    this.newfriendId = friendId;
    return this;
  }

  MyPagesState addFriendByFriendId(int friendId) {
    // ID로 친구 추가 확인
    addedFriend[friendId] = true;
    return this;
  }

  bool isaddedFriend(int friendId) {
    return addedFriend[friendId] ?? false;
  }

  MyPagesState setIsTos1(bool isTos1) {
    this.isTos1 = isTos1;
    return this;
  }

  MyPagesState setIsTos2(bool isTos2) {
    this.isTos2 = isTos2;
    return this;
  }

  // // ============================================= 현식오빠 state.g 따라함 // TODO: 다하고 이거 지우기
  //
  // MyPagesState _$MyPagesStateFromJson(Map<String, dynamic> json) => MyPagesState(
  //       isMyLandPage: json['isMyLandPage'] as bool,
  //       friends: (json['friends'] as List<dynamic>).map((e) => Friend.fromJson(e as Map<String, dynamic>)).toList(),
  //       isSettings: json['isSettings'] as bool,
  //       addedFriend: (json['addedFriend'] as Map<String, dynamic>).map(
  //         (k, e) => MapEntry(int.parse(k), e as bool),
  //       ),
  //       newfriendId: json['newfriendId'] as int,
  //       isTos1: json['isTos1'] as bool,
  //       isTos2: json['isTos2'] as bool,
  //     );
  //
  // Map<String, dynamic> _$MyPagesStateToJson(MyPagesState instance) => <String, dynamic>{
  //       'isMyLandPage': instance.isMyLandPage,
  //       'friends': instance.friends,
  //       'isSettings': instance.isSettings,
  //       'addedFriend': instance.addedFriend.map((k, e) => MapEntry(k.toString(), e)),
  //       'newfriendId': instance.newfriendId,
  //       'isTos1': instance.isTos1,
  //       'isTos2': instance.isTos2,
  //     };
  //
  // // ============================================= 현식오빠 state 따라함 // TODO: 다하고 이거 지우기
  //
  // Map<String, dynamic> toJson() => _$MyPagesStateToJson(this);
  //
  // MyPagesState fromJson(Map<String, dynamic> json) => _$MyPagesStateFromJson(json);
  //
  // @override
  // String toString() {
  //   return 'MyPagesState{isMyLandPage: $isMyLandPage, isSettings: $isSettings, isTos1: $isTos1, isTos2: $isTos2}';
  // }
}
