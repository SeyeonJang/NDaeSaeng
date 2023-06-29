import 'package:dart_flutter/src/data/model/dart_auth.dart';
import 'package:dart_flutter/src/data/model/user.dart';
import 'package:dart_flutter/src/datasource/dart_api_remote_datasource.dart';

void main() async {
  DartApiRemoteDataSource dataSource = DartApiRemoteDataSource();

  final String kakaoAccessToken = "4i-emZzCCzxksWy1XxwIXY-2Z4sxZJTr2UsrpojqCisM0gAAAYkBwzFt";
  DartAuth dartAuth = await DartApiRemoteDataSource.postLoginWithKakao(kakaoAccessToken);
  print(dartAuth);

  var user = UserRequest(univId: 45, admissionNumber: 20, name: "가나다", phone: "010-1234-5678");
  await DartApiRemoteDataSource.postUserSignup(user);

  UserResponse userResponse = await DartApiRemoteDataSource.getMyInformation();
  print(userResponse.toString());

  // await DartApiRemoteDataSource.getUniversities();
}
