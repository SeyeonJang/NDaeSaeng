import 'package:dart_flutter/src/common/pagination/pagination.dart';
import 'package:dart_flutter/src/domain/entity/survey.dart';
import 'package:dart_flutter/src/domain/entity/survey_detail.dart';

abstract class SurveyRepository {
  Future<Pagination<Survey>> getSurveys({final int page = 0, final int size = 10});
  Future<SurveyDetail> getSurvey(final int surveyId);
  Future<void> postSurvey(final int surveyId, final int answerId);
  Future<void> postComment(final int surveyId, final String content);
  Future<void> deleteComment(final int surveyId, final int commentId);
  Future<void> reportComment(final int surveyId, final int commentId);
  Future<void> likeComment(final int surveyId, final int commentId);
}