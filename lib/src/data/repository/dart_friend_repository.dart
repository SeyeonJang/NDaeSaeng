import 'package:dart_flutter/src/data/model/friend_dto.dart';
import 'package:dart_flutter/src/datasource/dart_api_remote_datasource.dart';

class DartFriendRepository {
  static const Duration cachingInterval = Duration(minutes: 10);
  static final FriendCache myFriendCache = FriendCache();
  static final FriendCache recommendedFriendCache = FriendCache();

  Future<List<FriendDto>> getMyFriends() async {
    if (myFriendCache.isUpdateBefore(DateTime.now().subtract(cachingInterval))) {
      myFriendCache.setFriends(await DartApiRemoteDataSource.getMyFriends());
    }
    return myFriendCache.friends;
  }

  Future<List<FriendDto>> getRecommendedFriends({bool put = false}) async {
    if (put || recommendedFriendCache.isUpdateBefore(DateTime.now().subtract(cachingInterval))) {
      recommendedFriendCache.setFriends(await DartApiRemoteDataSource.getMyFriends(suggested: true));
    }
    return recommendedFriendCache.friends;
  }

  Future<String> addFriend(FriendDto friend) async {
    myFriendCache.addFriend(friend);
    recommendedFriendCache.deleteFriend(friend);
    return await DartApiRemoteDataSource.postFriend(friend.userId!);
  }

  Future<FriendDto> addFriendBy(String inviteCode) async {
    FriendDto friend = await DartApiRemoteDataSource.postFriendBy(inviteCode);
    myFriendCache.addFriend(friend);
    return friend;
  }

  Future<String> deleteFriend(FriendDto friend) async {
    myFriendCache.deleteFriend(friend);
    recommendedFriendCache.addFriend(friend);
    return await DartApiRemoteDataSource.deleteFriend(friend.userId!);
  }

  void cleanUpCache() {
    myFriendCache.clean();
  }
}

class FriendCache {
  Set<FriendDto> _friends = {};
  DateTime _updateTime = DateTime.now().subtract(const Duration(days: 365));

  void clean() {
    _friends = {};
  }

  void addFriend(FriendDto friend) {
    _friends.add(friend);
  }

  void deleteFriend(FriendDto friend) {
    _friends.remove(friend);
  }

  void setFriends(List<FriendDto> friends) {
    _friends = friends.toSet();
    _updateTime = DateTime.now();
  }

  bool isUpdateBefore(DateTime dateTime) {
    return _updateTime.isBefore(dateTime);
  }

  List<FriendDto> get friends => List<FriendDto>.from(_friends);
  DateTime get updateTime => _updateTime;
}
