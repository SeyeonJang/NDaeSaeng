
import 'package:dart_flutter/src/data/datasource/dart_api_remote_datasource.dart';

void main() async {
 DartApiRemoteDataSource.addAuthorizationToken("eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJrYWthb18yODE3MDU0MDM1IiwiaWQiOjEwMjgsImV4cCI6MTY5MDcwMzg4NCwidXNlcm5hbWUiOiJrYWthb18yODE3MDU0MDM1In0.ogBCznUadK-Z0l0CA1GoXl5CkotAEdXsKrQ7s1a7-uanLJuDA_cywuWJHF3T-zxuyCvnG54q9bZTYQNpVJ9g3Q");
  // var questions = await DartApiRemoteDataSource.getNewQuestions();
  // print(questions.toString());

  final response = await DartApiRemoteDataSource.getNextVoteTime();
  print(response.toString());

  // dynamic response = await DartApiRemoteDataSource.getVotes();
  // print(response);
  //
  // response = await DartApiRemoteDataSource.getVote(83);
  // print(response);
}
