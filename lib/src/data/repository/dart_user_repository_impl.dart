import 'dart:io';

import 'package:dart_flutter/src/data/model/user_request_dto.dart';
import 'package:dart_flutter/src/data/model/user_response_dto.dart';
import 'package:dart_flutter/src/data/my_cache.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';
import 'package:dart_flutter/src/domain/entity/user_request.dart';
import 'package:dart_flutter/src/domain/entity/user_response.dart';
import 'package:dart_flutter/src/domain/repository/user_repository.dart';

import '../../data/datasource/dart_api_remote_datasource.dart';
import '../datasource/supabase_remote_datasource.dart';

class DartUserRepositoryImpl implements UserRepository {
  static const Duration cachingInterval = Duration(minutes: 10);
  static final UserResponseCache userResponseCache = UserResponseCache();

  static const String PROFILE_STORAGE_NAME = "profile";
  static const String IDCARD_STORAGE_NAME = "idcard";

  Future<UserResponse> signup(UserRequest user) async {
    var userRequestDto = UserRequestDto.fromUserRequest(user);
    return (await DartApiRemoteDataSource.postUserSignup(userRequestDto)).newUserResponse();
  }

  void logout() {  // auth?
    userResponseCache.clean();
  }

  Future<void> withdrawal() async {
    userResponseCache.clean();
    return await DartApiRemoteDataSource.deleteMyAccount();
  }

  Future<UserResponse> myInfo() async {
    if (userResponseCache.isUpdateBefore(DateTime.now().subtract(cachingInterval))) {
      userResponseCache.setObject((await DartApiRemoteDataSource.getMyInformation()).newUserResponse());
    }
    return userResponseCache.userResponse;
  }

  void cleanUpUserResponseCache() {
    userResponseCache.clean();
  }

  @override
  String getProfileImageUrl(String userId) {
    return SupabaseRemoteDatasource.getFileUrl(PROFILE_STORAGE_NAME, userId);
  }

  @override
  Future<String> uploadProfileImage(File file) async {
    String url = await SupabaseRemoteDatasource.uploadFileToStorage(PROFILE_STORAGE_NAME, "", file);
    UserResponseDto me = await DartApiRemoteDataSource.getMyInformation();
    // me.user.profileImage = url;
    DartApiRemoteDataSource.putMyInformation(me);
    return url;
  }

  @override
  Future<UserResponse> putMyInfo(UserResponse user) async {
    return (await DartApiRemoteDataSource.putMyInformation(UserResponseDto.fromUserResponse(user))).newUserResponse();
  }
}

class UserResponseCache extends MyCache {
  UserResponse? _userResponse;

  @override
  void setObject(dynamic userResponse) {
    super.setObject(() {});
    _userResponse = userResponse;
  }

  get userResponse => _userResponse;
}
