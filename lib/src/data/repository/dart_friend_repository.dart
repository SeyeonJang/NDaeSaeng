import 'package:dart_flutter/src/datasource/dart_api_remote_datasource.dart';

import '../model/contact.dart';

class DartFriendRepository {
  Future<List<Contact>> postContacts(List<Contact> contacts) async {
    return await DartApiRemoteDataSource.postContacts(contacts);
  }

  Future<List<Contact>> getMyFriends(String accessToken) async {
    return await DartApiRemoteDataSource.getMyFriends(accessToken, "y");
  }

  Future<List<Contact>> getRecommendedFriends(String accessToken) async {
    return await DartApiRemoteDataSource.getMyFriends(accessToken, "n");
  }
}
