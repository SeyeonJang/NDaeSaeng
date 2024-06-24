import 'package:dart_flutter/src/domain/entity/survey_detail.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class FeedState{
  late bool isLoading;
  late SurveyDetail surveyDetail;
  late User userResponse;

  FeedState({
    required this.isLoading,
    required this.surveyDetail,
    required this.userResponse
  });

  FeedState.init() {
    isLoading = false;
    surveyDetail = SurveyDetail(id: 0, question: '', options: [], picked: false, pickedOption: 0, createdAt: DateTime.now(), latestComment: '', comments: []);
    userResponse = User(personalInfo: null, university: null, titleVotes: []);
  }

  FeedState copy() => FeedState(
    isLoading: isLoading,
    surveyDetail: surveyDetail,
    userResponse: userResponse
  );

  void setIsLoading(bool isLoading) {
    this.isLoading = isLoading;
  }

  void setSurvey(SurveyDetail surveyDetail) {
    this.surveyDetail = surveyDetail;
  }

  void setMyInfo(User userResponse) {
    this.userResponse = userResponse;
  }
}