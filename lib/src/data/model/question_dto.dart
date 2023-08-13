import 'package:dart_flutter/src/domain/entity/question.dart';

class QuestionDto {
  int? questionId;
  String? content;
  String? icon;

  QuestionDto({this.questionId, this.content, this.icon});

  QuestionDto.fromJson(Map<String, dynamic> json) {
    questionId = json['questionId'];
    content = json['content'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['questionId'] = this.questionId;
    data['content'] = this.content;
    data['icon'] = this.icon;
    return data;
  }

  Question newQuestion() {
    return Question(
      questionId: questionId,
      content: content,
      icon: icon
    );
  }

  @override
  String toString() {
    return 'Question{questionId: $questionId, content: $content, icon: $icon}';
  }
}