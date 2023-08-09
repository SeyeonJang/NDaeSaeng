import 'dart:io';

import 'package:dart_flutter/src/domain/entity/user_request.dart';
import 'package:dart_flutter/src/domain/entity/user_response.dart';

abstract class UserRepository {
  Future<UserResponse> signup(UserRequest user);
  Future<UserResponse> patchMyInfo(UserResponse user);
  void logout();
  Future<void> withdrawal();
  Future<UserResponse> myInfo();
  void cleanUpUserResponseCache();
  Future<String> uploadProfileImage(File file);
  String getProfileImageUrl(String userId);
}
