
import 'package:dart_flutter/res/environment/app_environment.dart';
import 'package:dart_flutter/src/common/exception/custom_exception.dart';
import 'package:dart_flutter/src/data/datasource/dart_api_remote_datasource.dart';
import 'package:dart_flutter/src/data/model/user_request_dto.dart';
import 'package:dart_flutter/src/data/model/user_response_dto.dart';
import 'package:dio/dio.dart';

void main() async {
 AppEnvironment.setupEnv(BuildType.dev);

 // expired - customException
 String accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJrYWthb18yODE3MDU0MDM1IiwiaWQiOjM1MDUsImV4cCI6MTY5MzA1NDY0MCwidXNlcm5hbWUiOiJrYWthb18yODE3MDU0MDM1In0.YBpsDtXfpngZs71AhRyxTyyco6dlatweuJCZDebR7CJ6pb8LNIjGbzS2bnk3vltYf4uKBoHpGtOzehc8Z1Ju9g";

 // sign
 // String accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJrYWthb18yODE3MDU0MDM1IiwiaWQiOjM1MDUsImV4cCI6MTY5MzA1NzE5NCwidXNlcm5hbWUiOiJrYWthb18yODE3MDU0MDM1In0.JZ3xLlc3a_2Jzhxwtv7ucjAIPF5vpMQVmRLcITTLdVHtV0Y0T7lFylxFWnDh_gCydUNdhWfAviJnbOBhqcIbrw";

 // normal
 // String accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJrYWthb18yODE3MDU0MDM1IiwiaWQiOjM1MDUsImV4cCI6MTY5MzA1NzE5NCwidXNlcm5hbWUiOiJrYWthb18yODE3MDU0MDM1In0.JZ3xLlc3a_2Jzhxwtv7ucjAIPF5vpMQVmRLcITTLdVHtV0Y0T7lFylxFWnDh_gCydUNdhWfAviJnbOBhqcIbrw";

 // String accessToken = "";

 try {
  DartApiRemoteDataSource.addAuthorizationToken(accessToken);
  UserDto response = await DartApiRemoteDataSource.getMyInformation();
  print(response.toString());

  var conv = response.newUserResponse();
  print(conv.toString());

  var conv2 = UserRequestDto.fromUserResponse(conv);
  print(conv2.toString());

  DartApiRemoteDataSource.patchMyInformation(conv2);
 } on DioException catch(e) {
  if (e.error is CustomException) {
   print(e.error);
   var a = e.error;
  }
 }

 var res = await DartApiRemoteDataSource.getVotesSummary();
 print(res);


 // final response = await DartUserRepositoryImpl().verifyStudentIdCard("최현식", "https://khzdhqlbzmnzibbfrrgc.supabase.co/storage/v1/object/public/idcard/280");
 // print(response.toString());

  // dynamic response = await DartApiRemoteDataSource.getVotes();
  // print(response);
  //
  // response = await DartApiRemoteDataSource.getVote(83);
  // print(response);
}
