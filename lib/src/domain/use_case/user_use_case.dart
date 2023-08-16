import 'dart:io';

import 'package:dart_flutter/src/common/util/image_util.dart';
import 'package:dart_flutter/src/data/repository/dart_user_repository_impl.dart';
import 'package:dart_flutter/src/domain/entity/user_request.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';
import 'package:dart_flutter/src/domain/repository/user_repository.dart';

class UserUseCase {
  final UserRepository _dartUserRepository = DartUserRepositoryImpl();

  Future<User> myInfo() async {
    // return _dartUserRepository.myInfo();
    var userResponse = await _dartUserRepository.myInfo();
    print(userResponse.toString());
    return userResponse;
  }

  Future<User> signup(UserRequest user) {
    return _dartUserRepository.signup(user);
  }

  void withdrawal() {
    _dartUserRepository.withdrawal();
  }

  void logout() {
    _dartUserRepository.logout();
  }

  Future<User> patchMyInfo(User user) {
    return _dartUserRepository.patchMyInfo(user);
  }

  String getProfileImageUrl(String userId) {
    // return _dartUserRepository.getProfileImageUrl(userId);
    String url = _dartUserRepository.getProfileImageUrl(userId);
    return url;
  }

  Future<String> uploadProfileImage(File file, User user) async {
    file = await ImageUtil.compressImage(file);

    await _dartUserRepository.removeProfileImage(user.personalInfo!.id.toString());
    String url = await _dartUserRepository.uploadProfileImage(file, user.personalInfo!.id.toString());

    user.personalInfo = user.personalInfo!.copyWith(profileImageUrl: url);

    _dartUserRepository.patchMyInfo(user);
    return url;
  }

  Future<String> uploadIdCardImage(File file, User user, String name) async {
    file = await ImageUtil.compressImage(file);

    await _dartUserRepository.removeIdCardImage(user.personalInfo!.id.toString());
    String url = await _dartUserRepository.uploadIdCardImage(file, user.personalInfo!.id.toString());

    _dartUserRepository.verifyStudentIdCard(name, url);

    return url;
  }

  void cleanUpUserResponseCache() {
    _dartUserRepository.cleanUpUserResponseCache();
  }
}
