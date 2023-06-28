import '../../datasource/dart_api_remote_datasource.dart';
import '../model/user.dart';

class DartUserRepository {
  Future<UserResponse> signup(UserRequest user) async {
    return await DartApiRemoteDataSource.postUserSignup(user);
  }

  Future<UserResponse> myInfo() async {
    return await DartApiRemoteDataSource.getMyInformation();
  }

  Future<void> updateMyInfo(String accessToken, UserRequest userRequest) async {
    return await DartApiRemoteDataSource.putUser(accessToken, userRequest);
  }
}
