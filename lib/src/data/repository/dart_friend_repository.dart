import 'package:dart_flutter/src/data/model/friend_dto.dart';
import 'package:dart_flutter/src/datasource/dart_api_remote_datasource.dart';
import 'package:dart_flutter/src/domain/entity/friend.dart';

class DartFriendRepository {
  static const Duration cachingInterval = Duration(minutes: 10);
  static final FriendCache myFriendCache = FriendCache();
  static final FriendCache recommendedFriendCache = FriendCache();

  Future<List<Friend>> getMyFriends() async {
    if (myFriendCache.isUpdateBefore(DateTime.now().subtract(cachingInterval))) {
      myFriendCache.setFriends((
          await DartApiRemoteDataSource.getMyFriends()).map((friendDto) => friendDto.newFriend()).toList()
      );
    }
    return myFriendCache.friends;
  }

  Future<List<Friend>> getRecommendedFriends({bool put = false}) async {
    if (put || recommendedFriendCache.isUpdateBefore(DateTime.now().subtract(cachingInterval))) {
      recommendedFriendCache.setFriends((
          await DartApiRemoteDataSource.getMyFriends(suggested: true)).map((friendDto) => friendDto.newFriend()).toList()
      );
    }
    return recommendedFriendCache.friends;
  }

  Future<String> addFriend(Friend friend) async {
    myFriendCache.addFriend(friend);
    recommendedFriendCache.deleteFriend(friend);
    return await DartApiRemoteDataSource.postFriend(friend.userId!);
  }

  Future<Friend> addFriendBy(String inviteCode) async {
    FriendDto friend = await DartApiRemoteDataSource.postFriendBy(inviteCode);
    myFriendCache.addFriend(friend.newFriend());
    return friend.newFriend();
  }

  Future<String> deleteFriend(Friend friend) async {
    myFriendCache.deleteFriend(friend);
    recommendedFriendCache.addFriend(friend);
    return await DartApiRemoteDataSource.deleteFriend(friend.userId!);
  }

  void cleanUpCache() {
    myFriendCache.clean();
  }
}

class FriendCache {
  Set<Friend> _friends = {};
  DateTime _updateTime = DateTime.now().subtract(const Duration(days: 365));

  void clean() {
    _friends = {};
  }

  void addFriend(Friend friend) {
    _friends.add(friend);
  }

  void deleteFriend(Friend friend) {
    _friends.remove(friend);
  }

  void setFriends(List<Friend> friends) {
    _friends = friends.toSet();
    _updateTime = DateTime.now();
  }

  bool isUpdateBefore(DateTime dateTime) {
    return _updateTime.isBefore(dateTime);
  }

  List<Friend> get friends => List<Friend>.from(_friends);
  DateTime get updateTime => _updateTime;
}
