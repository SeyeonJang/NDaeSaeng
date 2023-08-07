import 'package:dart_flutter/src/data/model/user_request_dto.dart';
import 'package:dart_flutter/src/data/my_cache.dart';
import 'package:dart_flutter/src/domain/entity/user_request.dart';
import 'package:dart_flutter/src/domain/entity/user_response.dart';
import 'package:dart_flutter/src/domain/repository/user_repository.dart';

import '../../datasource/dart_api_remote_datasource.dart';

class DartUserRepositoryImpl implements UserRepository {
  static const Duration cachingInterval = Duration(minutes: 10);
  static final UserResponseCache userResponseCache = UserResponseCache();

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
