import 'package:dart_flutter/src/domain/entity/friend.dart';

abstract class FriendRepository {
  Future<List<Friend>> getMyFriends();
  Future<List<Friend>> getRecommendedFriends({bool put});
  Future<String> addFriend(Friend friend);
  Future<Friend> addFriendBy(String inviteCode);
  Future<String> deleteFriend(Friend friend);
  void cleanUpCache();
}
