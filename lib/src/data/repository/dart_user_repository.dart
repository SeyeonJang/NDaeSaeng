import 'package:dart_flutter/src/data/my_cache.dart';

import '../../datasource/dart_api_remote_datasource.dart';
import '../model/user.dart';

class DartUserRepository {
  static const Duration cachingInterval = Duration(minutes: 10);
  static final UserResponseCache userResponseCache = UserResponseCache();

  Future<UserResponse> signup(UserRequest user) async {
    return await DartApiRemoteDataSource.postUserSignup(user);
  }

  Future<void> drawal() async {
    return await DartApiRemoteDataSource.deleteMyAccount();
  }

  Future<UserResponse> myInfo() async {
    if (userResponseCache.isUpdateBefore(DateTime.now().subtract(cachingInterval))) {
      userResponseCache.setObject(await DartApiRemoteDataSource.getMyInformation());
    }
    return userResponseCache.userResponse;
  }

  Future<void> updateMyInfo(String accessToken, UserRequest userRequest) async {
    return await DartApiRemoteDataSource.putUser(accessToken, userRequest);
  }
}

class UserResponseCache extends MyCache {
  UserResponse? _userResponse = null;

  @override
  void setObject(dynamic userResponse) {
    super.setObject(() {});
    _userResponse = userResponse;
  }

  get userResponse => _userResponse;
}
