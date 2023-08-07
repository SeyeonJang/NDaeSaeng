import 'package:dart_flutter/src/data/my_cache.dart';

import '../../datasource/dart_api_remote_datasource.dart';
import '../model/user_dto.dart';
import '../model/user_request_dto.dart';
import '../model/user_response_dto.dart';

class DartUserRepository {
  static const Duration cachingInterval = Duration(minutes: 10);
  static final UserResponseCache userResponseCache = UserResponseCache();

  Future<UserResponseDto> signup(UserRequestDto user) async {
    return await DartApiRemoteDataSource.postUserSignup(user);
  }

  void logout() {
    userResponseCache.clean();
  }

  Future<void> drawal() async {
    userResponseCache.clean();
    return await DartApiRemoteDataSource.deleteMyAccount();
  }

  Future<UserResponseDto> myInfo() async {
    if (userResponseCache.isUpdateBefore(DateTime.now().subtract(cachingInterval))) {
      userResponseCache.setObject(await DartApiRemoteDataSource.getMyInformation());
    }
    return userResponseCache.userResponse;
  }

  Future<void> updateMyInfo(String accessToken, UserRequestDto userRequest) async {
    return await DartApiRemoteDataSource.putUser(accessToken, userRequest);
  }

  void cleanUpUserResponseCache() {
    userResponseCache.clean();
  }
}

class UserResponseCache extends MyCache {
  UserResponseDto? _userResponse = null;

  @override
  void setObject(dynamic userResponse) {
    super.setObject(() {});
    _userResponse = userResponse;
  }

  get userResponse => _userResponse;
}
