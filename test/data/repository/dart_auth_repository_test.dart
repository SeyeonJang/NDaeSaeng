import 'package:dart_flutter/src/data/model/dart_auth.dart';
import 'package:dart_flutter/src/data/model/friend.dart';
import 'package:dart_flutter/src/data/model/user.dart';
import 'package:dart_flutter/src/datasource/dart_api_remote_datasource.dart';

void main() async {
  DartApiRemoteDataSource dataSource = DartApiRemoteDataSource();

  // final String kakaoAccessToken = "4i-emZzCCzxksWy1XxwIXY-2Z4sxZJTr2UsrpojqCisM0gAAAYkBwzFt";
  // DartAuth dartAuth = await DartApiRemoteDataSource.postLoginWithKakao(kakaoAccessToken);
  // print(dartAuth);

  // var user = UserRequest(univId: 45, admissionNumber: 20, name: "가나다", phone: "010-1234-5678");
  // await DartApiRemoteDataSource.postUserSignup(user);

  // UserResponse userResponse = await DartApiRemoteDataSource.getMyInformation();
  // print(userResponse.toString());

  // await DartApiRemoteDataSource.getUniversities();

  DartApiRemoteDataSource.addAuthorizationToken("eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJrYWthb18yODE3MDU0MDM1IiwiaWQiOjEzLCJleHAiOjE2ODg4MzE3MzMsInVzZXJuYW1lIjoia2FrYW9fMjgxNzA1NDAzNSJ9.LE6dyVPecCGCKre8-J7yXZvRQW60M-huw2oZrOzffou-zuUv4DQd6mCTS-takx0agbmKgVaQfvn683s_GNGvYA");

  List<Friend> friends = await DartApiRemoteDataSource.getMyFriends(suggested: false);
  print(friends.toString());

  friends = await DartApiRemoteDataSource.getMyFriends(suggested: true);
  print(friends.toString());
}
