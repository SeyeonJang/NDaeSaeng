import 'dart:io';

import 'package:dart_flutter/src/domain/entity/user_request.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';

abstract class UserRepository {
  Future<User> signup(UserRequest user);
  Future<User> patchMyInfo(User user);
  void logout();
  Future<void> withdrawal();
  Future<User> myInfo();
  void cleanUpUserResponseCache();
  String getProfileImageUrl(String userId);
  Future<String> uploadProfileImage(File file, String userId);
  removeProfileImage(String userId);
  String getIdCardImageUrl(String userId);
  Future<String> uploadIdCardImage(File file, String userId);
  removeIdCardImage(String userId);
  Future<User> verifyStudentIdCard(String name, String idCardImageUrl);
}
