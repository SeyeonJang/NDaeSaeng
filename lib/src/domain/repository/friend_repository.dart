import 'package:dart_flutter/src/domain/entity/user.dart';

abstract class FriendRepository {
  Future<List<User>> getMyFriends();
  Future<List<User>> getRecommendedFriends({bool put});
  Future<String> addFriend(User friend);
  Future<User> addFriendBy(String inviteCode);
  Future<String> deleteFriend(User friend);
  void cleanUpCache();
}
