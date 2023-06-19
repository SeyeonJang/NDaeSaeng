import 'package:dart_flutter/src/data/model/vote.dart';

class VoteMock {
  final List<VoteResponse> _votes = [
    VoteResponse(
        userId: 1,
        voteId: 1,
        pickUserAdmissionNumber: 20,
        pickUserSex: "여",
        hint: Hint(voteId: 1, hint1: "a", hint2: "b", hint3: "c", hint4: "4", hint5: "5"),
        question: Question(questionId: 1, div1: "연애", div2: "관계", question: "에시 question")),
    VoteResponse(
        userId: 1,
        voteId: 2,
        pickUserAdmissionNumber: 20,
        pickUserSex: "여",
        hint: Hint(voteId: 2, hint1: "a", hint2: "b", hint3: "c", hint4: "4", hint5: "5"),
        question: Question(questionId: 1, div1: "연애", div2: "관계", question: "에시 question")),
    VoteResponse(
        userId: 1,
        voteId: 3,
        pickUserAdmissionNumber: 20,
        pickUserSex: "여",
        hint: Hint(voteId: 3, hint1: "a", hint2: "b", hint3: "c", hint4: "4", hint5: "5"),
        question: Question(questionId: 1, div1: "연애", div2: "관계", question: "에시 question")),
    VoteResponse(
        userId: 2,
        voteId: 4,
        pickUserAdmissionNumber: 21,
        pickUserSex: "여",
        hint: Hint(voteId: 4, hint1: "a", hint2: "b", hint3: "c", hint4: "4", hint5: "5"),
        question: Question(questionId: 1, div1: "연애", div2: "관계", question: "에시 question")),
    VoteResponse(
        userId: 2,
        voteId: 5,
        pickUserAdmissionNumber: 21,
        pickUserSex: "여",
        hint: Hint(voteId: 5, hint1: "a", hint2: "b", hint3: "c", hint4: "4", hint5: "5"),
        question: Question(questionId: 1, div1: "연애", div2: "관계", question: "에시 question")),
    VoteResponse(
        userId: 2,
        voteId: 6,
        pickUserAdmissionNumber: 20,
        pickUserSex: "여",
        hint: Hint(voteId: 6, hint1: "a", hint2: "b", hint3: "c", hint4: "4", hint5: "5"),
        question: Question(questionId: 1, div1: "연애", div2: "관계", question: "에시 question")),
    VoteResponse(
        userId: 2,
        voteId: 7,
        pickUserAdmissionNumber: 23,
        pickUserSex: "남",
        hint: Hint(voteId: 7, hint1: "a", hint2: "b", hint3: "c", hint4: "4", hint5: "5"),
        question: Question(questionId: 1, div1: "연애", div2: "관계", question: "에시 question")),
    VoteResponse(
        userId: 1,
        voteId: 8,
        pickUserAdmissionNumber: 23,
        pickUserSex: "여",
        hint: Hint(voteId: 8, hint1: "a", hint2: "b", hint3: "c", hint4: "4", hint5: "5"),
        question: Question(questionId: 1, div1: "연애", div2: "관계", question: "에시 question")),
    VoteResponse(
        userId: 1,
        voteId: 9,
        pickUserAdmissionNumber: 22,
        pickUserSex: "남",
        hint: Hint(voteId: 9, hint1: "a", hint2: "b", hint3: "c", hint4: "4", hint5: "5"),
        question: Question(questionId: 1, div1: "연애", div2: "관계", question: "에시 question")),
    VoteResponse(
        userId: 1,
        voteId: 10,
        pickUserAdmissionNumber: 21,
        pickUserSex: "여",
        hint: Hint(voteId: 10, hint1: "a", hint2: "b", hint3: "c", hint4: "4", hint5: "5"),
        question: Question(questionId: 1, div1: "연애", div2: "관계", question: "에시 question")),
    VoteResponse(
        userId: 1,
        voteId: 11,
        pickUserAdmissionNumber: 20,
        pickUserSex: "남",
        hint: Hint(voteId: 11, hint1: "a", hint2: "b", hint3: "c", hint4: "4", hint5: "5"),
        question: Question(questionId: 1, div1: "연애", div2: "관계", question: "에시 question")),
  ];

  List<VoteResponse> getVotes() {
    return _votes;
  }
}
