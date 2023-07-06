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

  // DartApiRemoteDataSource.addAuthorizationToken("eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJrYWthb18yODE3MDU0MDM1IiwiaWQiOjQzLCJleHAiOjE2ODk0MjQzOTQsInVzZXJuYW1lIjoia2FrYW9fMjgxNzA1NDAzNSJ9.fU4FAbioW8u5KyVIhQ9vLsuVoEuSDtN0ScSUlaHh2doGMIgeBZR3ri8KDNiVY9Y4F1_Hap3Uu79WH0gPaLkc6AA");
  DartApiRemoteDataSource.addAuthorizationToken("eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJrYWthb18yODE3MDU0MDM1IiwiaWQiOjQzLCJleHAiOjE2ODk0MjQzOTQsInVzZXJuYW1lIjoia2FrYW9fMjgxNzA1NDAzNSJ9.fU4FAbioW8u5KyVIhQ9vLsuVoEuSDtN0ScSUlaHh2doGMIgeBZR3ri8KDNiVY9Y4F1_Hap3Uu79WH0gPaLkc6A");
  // List<Friend> friends = await DartApiRemoteDataSource.getMyFriends(suggested: false);
  // print(friends.toString());

  // var friends = await DartApiRemoteDataSource.getMyFriends(suggested: false);
  // print(friends.toString());
  
  var questions = await DartApiRemoteDataSource.getNewQuestions();
  print(questions.toString());
}
