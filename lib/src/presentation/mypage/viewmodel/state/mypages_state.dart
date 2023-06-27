// import 'package:dart_flutter/src/data/model/vote.dart';
import 'package:dart_flutter/src/data/model/friend.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class MyPagesState {
  late List<Friend> friends;
  late bool isSettings;
  late Map<int, bool> addedFriend;
  late int newfriendId;

  MyPagesState({
    required this.friends,
    required this.isSettings,
    required this.addedFriend,
    required this.newfriendId,
  });

  MyPagesState.init() {
    friends = [];
    isSettings = false;
    addedFriend = {};
    newfriendId = 0;
  }

  MyPagesState copy() => MyPagesState(
    friends: friends,
    isSettings: isSettings,
    addedFriend: addedFriend,
    newfriendId: newfriendId,
  );

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

  MyPagesState addFriendByFriendId(int friendId) { // ID로 친구 추가 확인
    addedFriend[friendId] = true;
    return this;
  }

  bool isaddedFriend(int friendId) {
    return addedFriend[friendId] ?? false;
  }

  // ============================================= 현식오빠 state.g 따라함 // TODO: 다하고 이거 지우기

  MyPagesState _$MyPagesStateFromJson(Map<String, dynamic> json) =>
      MyPagesState(
        friends: (json['friends'] as List<dynamic>)
          .map((e) => Friend.fromJson(e as Map<String, dynamic>))
          .toList(),
        isSettings: json['isSettings'] as bool,
        addedFriend: (json['addedFriend'] as Map<String, dynamic>).map(
            (k, e) => MapEntry(int.parse(k), e as bool),
        ),
        newfriendId: json['newfriendId'] as int,
      );

  Map<String, dynamic> _$MyPagesStateToJson(MyPagesState instance) =>
      <String, dynamic>{
        'friends': instance.friends,
        'isSettings': instance.isSettings,
        'addedFriend': instance.addedFriend.map((k, e) => MapEntry(k.toString(), e)),
        'newfriendId': instance.newfriendId,
      };

  // ============================================= 현식오빠 state 따라함 // TODO: 다하고 이거 지우기

  Map<String, dynamic> toJson() => _$MyPagesStateToJson(this);
  MyPagesState fromJson(Map<String, dynamic> json) => _$MyPagesStateFromJson(json);

  @override
  String toString() {
    return 'MyPagesState{isSettings: $isSettings}';
  }
}