import 'package:dart_flutter/src/data/model/friend.dart';
import 'package:dart_flutter/src/datasource/dart_api_remote_datasource.dart';

import '../model/contact.dart';

class DartFriendRepository {
  static const Duration cachingInterval = Duration(minutes: 10);
  static final FriendCache myFriendCache = FriendCache();
  static final FriendCache recommendedFriendCache = FriendCache();

  Future<List<Friend>> getMyFriends() async {
    if (myFriendCache.isUpdateBefore(DateTime.now().subtract(cachingInterval))) {
      myFriendCache.setFriends(await DartApiRemoteDataSource.getMyFriends());
    }
    return myFriendCache.friends;
  }

  Future<List<Friend>> getRecommendedFriends() async {
    if (recommendedFriendCache.isUpdateBefore(DateTime.now().subtract(cachingInterval))) {
      recommendedFriendCache.setFriends(await DartApiRemoteDataSource.getMyFriends(suggested: true));
    }
    return recommendedFriendCache.friends;
  }

  Future<String> addFriend(Friend friend) async {
    myFriendCache.addFriend(friend);
    recommendedFriendCache.deleteFriend(friend);
    return await DartApiRemoteDataSource.postFriend(friend.userId);
  }

  Future<String> deleteFriend(Friend friend) async {
    myFriendCache.deleteFriend(friend);
    recommendedFriendCache.addFriend(friend);
    return await DartApiRemoteDataSource.deleteFriend(friend.userId);
  }
}

class FriendCache {
  List<Friend> _friends = [];
  DateTime _updateTime = DateTime.now().subtract(const Duration(days: 365));

  void setFriends(List<Friend> friends) {
    _friends = friends;
    _updateTime = DateTime.now();
  }

  void addFriend(Friend friend) {
    _friends.add(friend);
  }

  void deleteFriend(Friend friend) {
    _friends.remove(friend);
  }

  bool isUpdateBefore(DateTime dateTime) {
    return _updateTime.isBefore(dateTime);
  }

  List<Friend> get friends => _friends;
  DateTime get updateTime => _updateTime;
}
