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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['questionId'] = questionId;
    data['content'] = content;
    data['icon'] = icon;
    return data;
  }

  Question newQuestion() {
    return Question(
      questionId: questionId,
      content: content,
      icon: icon
    );
  }

  static QuestionDto fromQuestion(Question question) {
    return QuestionDto(
      questionId: question.questionId,
      content: question.content,
      icon: question.icon
    );
  }

  @override
  String toString() {
    return 'Question{questionId: $questionId, content: $content, icon: $icon}';
  }
}