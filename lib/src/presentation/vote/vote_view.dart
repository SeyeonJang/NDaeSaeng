import 'package:dart_flutter/res/size_config.dart';
import 'package:dart_flutter/src/data/model/friend.dart';
import 'package:dart_flutter/src/data/model/vote.dart';
import 'package:dart_flutter/src/presentation/vote/vimemodel/state/vote_state.dart';
import 'package:dart_flutter/src/presentation/vote/vimemodel/vote_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/question.dart';

class VoteView extends StatelessWidget {
  const VoteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 5, vertical: SizeConfig.defaultSize * 2),
        child: Center(
          child: BlocBuilder<VoteCubit, VoteState>(
            builder: (context, state) {
              Question question = state.questions[state.voteIterator];
              List<Friend> shuffledFriends = state.getShuffleFriends();
              Friend friend1 = shuffledFriends[0];
              Friend friend2 = shuffledFriends[1];
              Friend friend3 = shuffledFriends[2];
              Friend friend4 = shuffledFriends[3];

              print(state.votes.toString());

              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  VoteStoryBar(voteIterator: state.voteIterator, maxVoteIterator: VoteState.MAX_VOTE_ITERATOR,),
                  Flexible(
                    flex: 10,
                    child: Icon(Icons.emoji_emotions, size: SizeConfig.defaultSize * 22),
                  ),
                  Flexible(
                    flex: 20,
                    child: Text(
                      question.content!,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: SizeConfig.defaultSize * 2.5,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 12,
                    // fit: FlexFit.tight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ChoiceFriendButton(
                                userId: friend1.userId, name: friend1.name, enterYear: friend1.admissionNumber, department: friend1.university.department,
                                questionId: int.parse(question.questionId!),
                                firstUserId: friend1.userId,
                                secondUserId: friend2.userId,
                                thirdUserId: friend3.userId,
                                fourthUserId: friend4.userId
                            ),
                            ChoiceFriendButton(userId: friend2.userId, name: friend2.name, enterYear: friend2.admissionNumber, department: friend2.university.department,
                                questionId: int.parse(question.questionId!),
                                firstUserId: friend1.userId,
                                secondUserId: friend2.userId,
                                thirdUserId: friend3.userId,
                                fourthUserId: friend4.userId
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ChoiceFriendButton(userId: friend3.userId, name: friend3.name, enterYear: friend3.admissionNumber, department: friend3.university.department,
                                questionId: int.parse(question.questionId!),
                                firstUserId: friend1.userId,
                                secondUserId: friend2.userId,
                                thirdUserId: friend3.userId,
                                fourthUserId: friend4.userId),
                            ChoiceFriendButton(userId: friend4.userId, name: friend4.name, enterYear: friend4.admissionNumber, department: friend4.university.department,
                                questionId: int.parse(question.questionId!),
                                firstUserId: friend1.userId,
                                secondUserId: friend2.userId,
                                thirdUserId: friend3.userId,
                                fourthUserId: friend4.userId),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  BlocProvider.of<VoteCubit>(context).refresh();
                                },
                                icon: const Icon(CupertinoIcons.shuffle)),
                            IconButton(
                                onPressed: () {
                                  // TODO 스킵 제거해야함
                                  // Navigator.push(context, MaterialPageRoute(builder: (context) => VoteResultView()));
                                  // BlocProvider.of<VoteCubit>(context).nextVote(state.voteIterator, 0);  // 투표안함
                                },
                                icon: const Icon(Icons.skip_next)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 0,
                    child: Container(color: Colors.red,),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class VoteStoryBar extends StatefulWidget {
  final int voteIterator;
  final int maxVoteIterator;

  const VoteStoryBar({
    super.key, required this.voteIterator, required this.maxVoteIterator,
  });

  @override
  State<VoteStoryBar> createState() => _VoteStoryBarState();
}

class _VoteStoryBarState extends State<VoteStoryBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: BlocBuilder<VoteCubit, VoteState>(
            builder: (context, state) {
              return Row(
                children: [
                  for (var i = 0; i <= widget.voteIterator; i++) ...[
                    Expanded(child: Container(height: SizeConfig.defaultSize * 0.4, color: Colors.black,)),
                    const SizedBox(width: 2,),
                  ],
                  for (var i = widget.voteIterator; i < widget.maxVoteIterator - 1; i++) ...[
                    Expanded(child: Container(height: SizeConfig.defaultSize * 0.4, color: Colors.grey,)),
                    const SizedBox(width: 2,),
                  ],
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class ChoiceFriendButton extends StatelessWidget {
  final int userId;
  final String name;
  final int enterYear;
  final String department;

  final int questionId;
  final int firstUserId;
  final int secondUserId;
  final int thirdUserId;
  final int fourthUserId;

  const ChoiceFriendButton({
    super.key,
    required this.userId,
    required this.name,
    required this.enterYear,
    required this.department,

    required this.questionId,
    required this.firstUserId,
    required this.secondUserId,
    required this.thirdUserId,
    required this.fourthUserId,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        VoteRequest voteRequest = VoteRequest(
          questionId: questionId,
          pickUserId: userId,
          firstUserId: firstUserId,
          secondUserId: secondUserId,
          thirdUserId: thirdUserId,
          fourthUserId: fourthUserId,
        );
        BlocProvider.of<VoteCubit>(context).nextVote(voteRequest);
      },
      child: Container(
        width: SizeConfig.defaultSize * 10.5,
        height: SizeConfig.defaultSize * 6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: SizeConfig.defaultSize * 2.5,
              ),
            ),
            Text(
              "$enterYear학번 $department",
              style: TextStyle(
                fontSize: SizeConfig.defaultSize * 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
