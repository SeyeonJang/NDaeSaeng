import 'package:dart_flutter/src/common/pagination/pagination.dart';
import 'package:dart_flutter/src/data/datasource/dart_api_remote_datasource.dart';
import 'package:dart_flutter/src/domain/entity/survey.dart';
import 'package:dart_flutter/src/domain/entity/survey_detail.dart';
import 'package:dart_flutter/src/domain/repository/survey_repository.dart';

class DartSurveyRepositoryImpl extends SurveyRepository {
  @override
  Future<SurveyDetail> getSurvey(int surveyId) async {
    var survey = await DartApiRemoteDataSource.getSurvey(surveyId);
    return survey.newSurveyDetail();
  }

  @override
  Future<Pagination<Survey>> getSurveys({int page = 0, int size = 10}) async {
    var surveys = await DartApiRemoteDataSource.getSurveys(page: 0, size: 10);
    return surveys.newContent(
      surveys.content?.map((survey) => survey.newSurvey()).toList() ?? []
    );
  }

  @override
  Future<void> postSurvey(int surveyId, int answerId) async {
    await DartApiRemoteDataSource.postSurvey(surveyId, answerId);
  }

  @override
  Future<void> likeComment(int surveyId, int commentId) async {
    await DartApiRemoteDataSource.likeComment(surveyId, commentId);
  }

  @override
  Future<void> postComment(int surveyId, String content) async {
    await DartApiRemoteDataSource.postComment(surveyId, content);
  }

  @override
  Future<void> reportComment(int surveyId, int commentId) async {
    await DartApiRemoteDataSource.reportComment(surveyId, commentId);
  }

  @override
  Future<void> deleteComment(int surveyId, int commentId) async {
    await DartApiRemoteDataSource.deleteComment(surveyId, commentId);
  }
}