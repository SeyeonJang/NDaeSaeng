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
    // return _dartUserRepository.getProfileImageUrl(userId);
    String url = _dartUserRepository.getProfileImageUrl(userId);
    return url;
  }

  Future<String> uploadProfileImage(File file, UserResponse user) async {
    await _dartUserRepository.removeProfileImage(user.user!.id.toString());
    String url = await _dartUserRepository.uploadProfileImage(file, user.user!.id.toString());

    user.user = user.user!.copyWith(profileImageUrl: url);

    _dartUserRepository.patchMyInfo(user);
    return url;
  }

  Future<String> uploadIdCardImage(File file, UserResponse user) async {
    await _dartUserRepository.removeIdCardImage(user.user!.id.toString());
    String url = await _dartUserRepository.uploadIdCardImage(file, user.user!.id.toString());
    return url;
  }

  void cleanUpUserResponseCache() {
    _dartUserRepository.cleanUpUserResponseCache();
  }
}
