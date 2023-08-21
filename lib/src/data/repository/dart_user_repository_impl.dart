import 'dart:io';

import 'package:dart_flutter/src/data/model/user_request_dto.dart';
import 'package:dart_flutter/src/data/model/user_response_dto.dart';
import 'package:dart_flutter/src/data/model/user_signup_request_dto.dart';
import 'package:dart_flutter/src/data/my_cache.dart';
import 'package:dart_flutter/src/domain/entity/user_request.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';
import 'package:dart_flutter/src/domain/repository/user_repository.dart';

import '../../data/datasource/dart_api_remote_datasource.dart';
import '../datasource/supabase_remote_datasource.dart';

class DartUserRepositoryImpl implements UserRepository {
  static const Duration cachingInterval = Duration(minutes: 10);
  static final UserResponseCache userResponseCache = UserResponseCache();

  static const String PROFILE_STORAGE_NAME = "profile";
  static const String IDCARD_STORAGE_NAME = "idcard";

  @override
  Future<User> signup(UserRequest user) async {
    var userRequestDto = UserSignupRequestDto.fromUserRequest(user);
    return (await DartApiRemoteDataSource.postUserSignup(userRequestDto)).newUserResponse();
  }

  @override
  void logout() {  // auth?
    userResponseCache.clean();
  }

  @override
  Future<void> withdrawal() async {
    userResponseCache.clean();
    return await DartApiRemoteDataSource.deleteMyAccount();
  }

  @override
  Future<User> myInfo() async {
    if (userResponseCache.isUpdateBefore(DateTime.now().subtract(cachingInterval))) {
      userResponseCache.setObject((await DartApiRemoteDataSource.getMyInformation()).newUserResponse());
    }
    return userResponseCache.userResponse;
  }

  @override
  void cleanUpUserResponseCache() {
    userResponseCache.clean();
  }

  @override
  Future<User> verifyStudentIdCard(String name, String idCardImageUrl) async {
    return (await DartApiRemoteDataSource.verifyStudentIdCard(name, idCardImageUrl)).newUserResponse();
  }

  @override
  Future<User> patchMyInfo(User user) async {
    UserDto userDto = await DartApiRemoteDataSource.patchMyInformation(UserRequestDto.fromUserResponse(user));
    User patchedUser = userDto.newUserResponse();
    userResponseCache.setObject(patchedUser);

    print("==========================================================");
    print(user.toString());
    print(patchedUser.toString());
    print("==========================================================");

    return patchedUser;
  }

  @override
  String getProfileImageUrl(String userId) {
    return SupabaseRemoteDatasource.getFileUrl(PROFILE_STORAGE_NAME, userId);
  }

  @override
  Future<String> uploadProfileImage(File file, String userId) async {
    await SupabaseRemoteDatasource.uploadFileToStorage(PROFILE_STORAGE_NAME, userId, file);
    await Future.delayed(const Duration(seconds: 1));

    String url = getProfileImageUrl(userId);
    UserRequestDto userRequestDto = UserRequestDto(
      profileImageUrl: url,
    );

    return url;
  }

  @override
  removeProfileImage(String userId) async {
    await SupabaseRemoteDatasource.removeFile(PROFILE_STORAGE_NAME, userId);
  }

  @override
  String getIdCardImageUrl(String userId) {
    return SupabaseRemoteDatasource.getFileUrl(IDCARD_STORAGE_NAME, userId);
  }

  @override
  Future<String> uploadIdCardImage(File file, String userId) async {
    await SupabaseRemoteDatasource.uploadFileToStorage(IDCARD_STORAGE_NAME, userId, file);
    await Future.delayed(const Duration(seconds: 1));

    String url = getIdCardImageUrl(userId);
    return url;
  }

  @override
  removeIdCardImage(String userId) async {
    await SupabaseRemoteDatasource.removeFile(IDCARD_STORAGE_NAME, userId);
  }

}

class UserResponseCache extends MyCache {
  User? _userResponse;

  @override
  void setObject(dynamic userResponse) {
    super.setObject(() {});
    _userResponse = userResponse;
  }

  get userResponse => _userResponse;
}
