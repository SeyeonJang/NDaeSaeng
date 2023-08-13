import 'package:dart_flutter/src/data/model/friend_dto.dart';
import 'package:dart_flutter/src/data/datasource/dart_api_remote_datasource.dart';
import 'package:dart_flutter/src/data/model/user_response_dto.dart';
import 'package:dart_flutter/src/domain/entity/friend.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';
import 'package:dart_flutter/src/domain/repository/friend_repository.dart';

class DartFriendRepositoryImpl implements FriendRepository {
  static const Duration cachingInterval = Duration(minutes: 10);
  static final FriendCache myFriendCache = FriendCache();
  static final FriendCache recommendedFriendCache = FriendCache();

  Future<List<User>> getMyFriends() async {
    if (myFriendCache.isUpdateBefore(DateTime.now().subtract(cachingInterval))) {
      myFriendCache.setFriends(
          (await DartApiRemoteDataSource.getMyFriends()).map((userResponseDto) => userResponseDto.newUserResponse()).toList()
      );
    }
    print(myFriendCache.friends.toString());
    return myFriendCache.friends;
  }

  Future<List<User>> getRecommendedFriends({bool put = false}) async {
    if (put || recommendedFriendCache.isUpdateBefore(DateTime.now().subtract(cachingInterval))) {
      recommendedFriendCache.setFriends((
          await DartApiRemoteDataSource.getMyFriends(suggested: true)).map((userResponseDto) => userResponseDto.newUserResponse()).toList()
      );
    }
    return recommendedFriendCache.friends;
  }

  Future<String> addFriend(User friend) async {
    myFriendCache.addFriend(friend);
    recommendedFriendCache.deleteFriend(friend);
    return await DartApiRemoteDataSource.postFriend(friend.personalInfo!.id);
  }

  Future<User> addFriendBy(String inviteCode) async {
    UserDto friend = await DartApiRemoteDataSource.postFriendBy(inviteCode);
    myFriendCache.addFriend(friend.newUserResponse());
    return friend.newUserResponse();
  }

  Future<String> deleteFriend(User friend) async {
    myFriendCache.deleteFriend(friend);
    recommendedFriendCache.addFriend(friend);
    return await DartApiRemoteDataSource.deleteFriend(friend.personalInfo!.id);
  }

  void cleanUpCache() {
    myFriendCache.clean();
  }
}

class FriendCache {
  Set<User> _friends = {};
  DateTime _updateTime = DateTime.now().subtract(const Duration(days: 365));

  void clean() {
    _friends = {};
  }

  void addFriend(User friend) {
    _friends.add(friend);
  }

  void deleteFriend(User friend) {
    _friends.remove(friend);
  }

  void setFriends(List<User> friends) {
    _friends = friends.toSet();
    _updateTime = DateTime.now();
  }

  bool isUpdateBefore(DateTime dateTime) {
    return _updateTime.isBefore(dateTime);
  }

  List<User> get friends => List<User>.from(_friends);
  DateTime get updateTime => _updateTime;
}
