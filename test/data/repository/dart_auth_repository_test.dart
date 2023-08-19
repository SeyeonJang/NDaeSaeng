
import 'package:dart_flutter/res/environment/app_environment.dart';
import 'package:dart_flutter/src/common/exception/custom_exception.dart';
import 'package:dart_flutter/src/data/datasource/dart_api_remote_datasource.dart';
import 'package:dart_flutter/src/data/repository/dart_user_repository_impl.dart';
import 'package:dio/dio.dart';

void main() async {
 AppEnvironment.setupEnv(BuildType.dev);

 // expired - customException
 String accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhcHBsZV8wMDE2MTIuZDhkM2E0MTcyMmQ2NDFlZWIxOWNlZWU2ZTg5YjliYjYuMDIxMSIsImlkIjoxMjEyLCJleHAiOjE2OTA4MTM3NzEsInVzZXJuYW1lIjoiYXBwbGVfMDAxNjEyLmQ4ZDNhNDE3MjJkNjQxZWViMTljZWVlNmU4OWI5YmI2LjAyMTEifQ.aNGH1x6WLPL5MPi6J5RCXouWbE6wpgbBZrebK7sxnTf5z14EAgAkCPTUT3s0imIGYDdLyx6L9YVh9O-edUA1pA";

 // sign
 // String accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJrYWthb18yODE3MDU0MDM1IiwiaWQiOjM1MDUsImV4cCI6MTY5MzA1NzE5NCwidXNlcm5hbWUiOiJrYWthb18yODE3MDU0MDM1In0.JZ3xLlc3a_2Jzhxwtv7ucjAIPF5vpMQVmRLcITTLdVHtV0Y0T7lFylxFWnDh_gCydUNdhWfAviJnbOBhqcIbrw";

 // normal
 // String accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJrYWthb18yODE3MDU0MDM1IiwiaWQiOjM1MDUsImV4cCI6MTY5MzA1NzE5NCwidXNlcm5hbWUiOiJrYWthb18yODE3MDU0MDM1In0.JZ3xLlc3a_2Jzhxwtv7ucjAIPF5vpMQVmRLcITTLdVHtV0Y0T7lFylxFWnDh_gCydUNdhWfAviJnbOBhqcIbrw";

 // String accessToken = "";

 try {
  DartApiRemoteDataSource.addAuthorizationToken(accessToken);
  var response = await DartApiRemoteDataSource.getMyInformation();
  print(response.toString());
 } on DioException catch(e) {
  if (e.error is CustomException) {
   print(e.error);
   var a = e.error;
  }
 }

 // final response = await DartUserRepositoryImpl().verifyStudentIdCard("최현식", "https://khzdhqlbzmnzibbfrrgc.supabase.co/storage/v1/object/public/idcard/280");
 // print(response.toString());

}
