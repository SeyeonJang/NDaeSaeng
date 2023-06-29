import 'package:dart_flutter/src/data/model/friend.dart';
import 'package:dart_flutter/src/datasource/dart_api_remote_datasource.dart';

import '../model/contact.dart';

class DartFriendRepository {
  Future<List<Friend>> getMyFriends() async {
    return await DartApiRemoteDataSource.getMyFriends();
  }

  Future<List<Friend>> getRecommendedFriends() async {
    return await DartApiRemoteDataSource.getMyFriends();
  }

  Future<String> addFriend(int userId) async {
    return await DartApiRemoteDataSource.postFriend(userId);
  }

  Future<String> deleteFriend(int userId) async {
    return await DartApiRemoteDataSource.deleteFriend(userId);
  }
}
