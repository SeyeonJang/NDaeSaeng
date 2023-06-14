class VoteRequest {
  final int userId, voteId;
  final int pickUserId, firstUserId, secondUserId, ThirdUserId, FourthUserId;
  final Question question;

  VoteRequest(
      {required this.userId,
      required this.voteId,
      required this.pickUserId,
      required this.firstUserId,
      required this.secondUserId,
      required this.ThirdUserId,
      required this.FourthUserId,
      required this.question});

  VoteRequest.from(Map<String, dynamic> json)
  : userId = json['userId'],
    voteId = json['voteId'],
    pickUserId = json['pickUserId'],
    firstUserId = json['firstUserId'],
    secondUserId = json['secondUserId'],
    ThirdUserId = json['ThirdUserId'],
    FourthUserId = json['FourthUserId'],
    question = json['question'];
}

class VoteResponse {
  final int userId, voteId;
  final Hint hint;
  final Question question;

  VoteResponse(
      {required this.userId,
      required this.voteId,
      required this.hint,
      required this.question});

  VoteResponse.from(Map<String, dynamic> json)
  : userId = json['userId'],
    voteId = json['voteId'],
    hint = json['hint'],
    question = json['question'];
}

class Question {
  final int questionId;
  final String div1, div2, question;

  Question(
      {required this.questionId,
      required this.div1,
      required this.div2,
      required this.question});

  Question.from(Map<String, dynamic> json)
  : questionId = json['questionId'],
    div1 = json['div1'],
    div2 = json['div2'],
    question = json['question'];
}

class Hint {
  final int voteId;
  final String hint1;
  final String hint2;
  final String hint3;
  final String hint4;
  final String hint5;

  Hint(
      {required this.voteId,
      required this.hint1,
      required this.hint2,
      required this.hint3,
      required this.hint4,
      required this.hint5});

  Hint.from(Map<String, dynamic> json)
  : voteId = json['voteId'],
    hint1 = json['hint1'],
    hint2 = json['hint2'],
    hint3 = json['hint3'],
    hint4 = json['hint4'],
    hint5 = json['hint5'];
}
