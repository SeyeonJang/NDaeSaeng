import 'package:dart_flutter/src/common/pagination/pagination.dart';
import 'package:dart_flutter/src/data/repository/dart_survey_repository_impl.dart';
import 'package:dart_flutter/src/domain/entity/survey.dart';
import 'package:dart_flutter/src/domain/entity/survey_detail.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';
import 'package:dart_flutter/src/domain/repository/survey_repository.dart';

class FeedUseCase {
  final SurveyRepository _surveyRepository = DartSurveyRepositoryImpl();

  Future<Pagination<Survey>> getSurveys({int page = 0, int size = 10}) async {
    return _surveyRepository.getSurveys(page: page, size: size);
  }

  Future<SurveyDetail> getSurvey(int id) async {
    return _surveyRepository.getSurvey(id);
  }

  Future<void> postOption(int surveyId, int optionId) async {
    await _surveyRepository.postSurvey(surveyId, optionId);
  }

  Future<void> postComment(int surveyId, String content) async {
    _surveyRepository.postComment(surveyId, content);
  }

  Future<void> deleteComment(int surveyId, int commentId) async {
    await _surveyRepository.deleteComment(surveyId, commentId);
  }

  void reportComment(int surveyId, int commentId) {
    _surveyRepository.reportComment(surveyId, commentId);
  }

  Future<void> postLikeComment(int surveyId, int commentId) async {
    await _surveyRepository.likeComment(surveyId, commentId);
  }

}