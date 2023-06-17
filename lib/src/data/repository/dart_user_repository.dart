import '../../datasource/dart_api_remote_datasource.dart';
import '../model/user.dart';

class DartUserRepository {
  Future<void> signup(UserRequest user) async {
    return await DartApiRemoteDataSource.postUserSignup(user);
  }

  Future<UserResponse> myInfo(String accessToken) async {
    return await DartApiRemoteDataSource.getUser(accessToken);
  }

  Future<void> updateMyInfo(String accessToken, UserRequest userRequest) async {
    return await DartApiRemoteDataSource.putUser(accessToken, userRequest);
  }
}
