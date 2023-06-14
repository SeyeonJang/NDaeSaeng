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
}

class Question {
  final int questionId;
  final String div1, div2, question;

  Question(
      {required this.questionId,
      required this.div1,
      required this.div2,
      required this.question});
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
}
