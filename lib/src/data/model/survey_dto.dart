import 'package:dart_flutter/src/domain/entity/option.dart';
import 'package:dart_flutter/src/domain/entity/survey.dart';

class SurveyDto {
  int? surveyId;
  String? createdTime;
  String? lastModifiedTime;
  String? category;
  String? content;
  int? totalHeadCount;
  List<Answers>? answers;
  int? userAnswerId;
  String? latestComment;

  SurveyDto(
      {this.surveyId,
        this.createdTime,
        this.lastModifiedTime,
        this.category,
        this.content,
        this.totalHeadCount,
        this.answers,
        this.userAnswerId,
        this.latestComment});

  SurveyDto.fromJson(Map<String, dynamic> json) {
    surveyId = json['surveyId'];
    createdTime = json['createdTime'];
    lastModifiedTime = json['lastModifiedTime'];
    category = json['category'];
    content = json['content'];
    totalHeadCount = json['totalHeadCount'];
    if (json['answers'] != null) {
      answers = <Answers>[];
      json['answers'].forEach((v) {
        answers!.add(new Answers.fromJson(v));
      });
    }
    userAnswerId = json['userAnswerId'];
    latestComment = json['latestComment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['surveyId'] = this.surveyId;
    data['createdTime'] = this.createdTime;
    data['lastModifiedTime'] = this.lastModifiedTime;
    data['category'] = this.category;
    data['content'] = this.content;
    data['totalHeadCount'] = this.totalHeadCount;
    if (this.answers != null) {
      data['answers'] = this.answers!.map((v) => v.toJson()).toList();
    }
    data['userAnswerId'] = this.userAnswerId;
    data['latestComment'] = this.latestComment;
    return data;
  }

  Survey newSurvey() {
    return Survey(
        id: surveyId ?? 0,
        question: content ?? "질문 불러오기에 실패했습니다.",
        options: answers?.map((answer) => answer.toOption()).toList() ?? [],
        picked: userAnswerId == null ? false : true,
        pickedOption: userAnswerId ?? 0,
        createdAt: createdTime != null ? DateTime.parse(createdTime!) : DateTime.now(),
        latestComment: latestComment ?? "작성된 댓글이 없습니다."
    );
  }
}

class Answers {
  int? answerId;
  String? content;
  int? headCount;

  Answers({this.answerId, this.content, this.headCount});

  Answers.fromJson(Map<String, dynamic> json) {
    answerId = json['answerId'];
    content = json['content'];
    headCount = json['headCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['answerId'] = this.answerId;
    data['content'] = this.content;
    data['headCount'] = this.headCount;
    return data;
  }

  Option toOption() {
    return Option(id: answerId ?? 0, name: content ?? "불러오지 못했습니다.", headCount: headCount ?? 0);
  }
}
