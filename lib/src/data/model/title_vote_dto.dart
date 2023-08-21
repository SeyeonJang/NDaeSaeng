import 'package:dart_flutter/src/data/model/question_dto.dart';
import 'package:dart_flutter/src/domain/entity/title_vote.dart';

class TitleVoteDto {
  QuestionDto question;
  int count;

  TitleVoteDto._internal({
    required this.question,
    required this.count,
  });

  factory TitleVoteDto({
    QuestionDto? question,
    int? count,
  }) {
    return TitleVoteDto._internal(
      question: question ?? QuestionDto(questionId: 0, content: "", icon: ""),
      count: count ?? 0,
    );
  }

  TitleVote newTitleVote() {
    return TitleVote(
      question: question.newQuestion(),
      count: count,
    );
  }

  static TitleVoteDto fromTitleVote(TitleVote titleVote) {
    return TitleVoteDto(
      question: QuestionDto.fromQuestion(titleVote.question),
      count: titleVote.count,
    );
  }

  static TitleVoteDto fromJson(Map<String, dynamic> json) {
    return TitleVoteDto(
      question: QuestionDto.fromJson(json['question']),
      count: json['count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question.toJson(),
      'count': count,
    };
  }

  @override
  String toString() {
    return 'TitleVote{question: $question, count: $count}';
  }
}
