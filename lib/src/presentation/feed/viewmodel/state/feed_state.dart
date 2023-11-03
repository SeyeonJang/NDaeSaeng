import 'package:dart_flutter/src/domain/entity/option.dart';
import 'package:dart_flutter/src/domain/entity/survey.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class FeedState{
  late bool isLoading;
  late Survey survey;
  late User userResponse;

  FeedState({
    required this.isLoading,
    required this.survey,
    required this.userResponse
  });

  FeedState.init() {
    isLoading = false;
    survey = Survey(id: 0, question: '', options: [], picked: false, pickedOption: 0);
    userResponse = User(personalInfo: null, university: null, titleVotes: []);
  }

  FeedState copy() => FeedState(
    isLoading: isLoading,
    survey: survey,
    userResponse: userResponse
  );

  void setIsLoading(bool isLoading) {
    this.isLoading = isLoading;
  }

  void setSurvey(Survey survey) {
    this.survey = survey;
  }

  void setMyInfo(User userResponse) {
    this.userResponse = userResponse;
  }
}