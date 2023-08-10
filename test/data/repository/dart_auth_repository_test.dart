
import 'package:dart_flutter/res/environment/app_environment.dart';
import 'package:dart_flutter/src/data/datasource/dart_api_remote_datasource.dart';
import 'package:dart_flutter/src/data/repository/dart_user_repository_impl.dart';

void main() async {
 AppEnvironment.setupEnv(BuildType.dev);
 DartApiRemoteDataSource.addAuthorizationToken("eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJrYWthb18yODE3MDU0MDM1IiwiaWQiOjIsImV4cCI6MTY5MTkwODg5NywidXNlcm5hbWUiOiJrYWthb18yODE3MDU0MDM1In0.BZBAXd3FpI7RU328GNN7e5jGiwgHHfDoBMsV4TTy50h_RhtGScPQipX5MhlRI8bh9VlfocsOmgplQ9VOdPYDrA");
  // print(questions.toString());

 // await DartApiRemoteDataSource.verifyStudentIdCard("최현식", "https://khzdhqlbzmnzibbfrrgc.supabase.co/storage/v1/object/public/idcard/280");
 final response = await DartUserRepositoryImpl().verifyStudentIdCard("최현식", "https://khzdhqlbzmnzibbfrrgc.supabase.co/storage/v1/object/public/idcard/280");
 print(response.toString());

  // final response = await DartApiRemoteDataSource.getNextVoteTime();
  // print(response.toString());

  // dynamic response = await DartApiRemoteDataSource.getVotes();
  // print(response);
  //
  // response = await DartApiRemoteDataSource.getVote(83);
  // print(response);
}
