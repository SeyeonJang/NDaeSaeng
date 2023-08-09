import 'dart:io';

import 'package:dart_flutter/src/data/repository/dart_user_repository_impl.dart';
import 'package:dart_flutter/src/domain/entity/user_request.dart';
import 'package:dart_flutter/src/domain/entity/user_response.dart';
import 'package:dart_flutter/src/domain/repository/user_repository.dart';

class UserUseCase {
  final UserRepository _dartUserRepository = DartUserRepositoryImpl();

  Future<UserResponse> myInfo() async {
    // return _dartUserRepository.myInfo();
    var userResponse = await _dartUserRepository.myInfo();
    print(userResponse.toString());
    return userResponse;
  }

  Future<UserResponse> signup(UserRequest user) {
    return _dartUserRepository.signup(user);
  }

  void withdrawal() {
    _dartUserRepository.withdrawal();
  }

  void logout() {
    _dartUserRepository.logout();
  }

  Future<UserResponse> patchMyInfo(UserResponse user) {
    return _dartUserRepository.patchMyInfo(user);
  }

  String getProfileImageUrl(String userId) {
    return _dartUserRepository.getProfileImageUrl(userId);
  }

  Future<String> uploadProfileImage(File file, String userId) async {
    return _dartUserRepository.uploadProfileImage(file, userId);
  }

  void cleanUpUserResponseCache() {
    _dartUserRepository.cleanUpUserResponseCache();
  }
}
