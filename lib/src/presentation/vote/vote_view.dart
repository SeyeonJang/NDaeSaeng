import 'package:dart_flutter/res/size_config.dart';
import 'package:dart_flutter/src/data/model/friend.dart';
import 'package:dart_flutter/src/presentation/vote/vimemodel/state/vote_state.dart';
import 'package:dart_flutter/src/presentation/vote/vimemodel/vote_cubit.dart';
import 'package:dart_flutter/src/presentation/vote/vote_result_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              List<Friend> shuffledFriends = state.getShuffleFriends();
              Friend friend1 = shuffledFriends[0];
              Friend friend2 = shuffledFriends[1];
              Friend friend3 = shuffledFriends[2];
              Friend friend4 = shuffledFriends[3];

              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  VoteStoryBar(voteIterator: state.voteIterator, maxVoteIterator: VoteState.MAX_VOTE_ITERATOR,),
                  Flexible(
                    flex: 1,
                    child: Icon(Icons.emoji_emotions, size: SizeConfig.defaultSize * 22),
                  ),
                  Flexible(
                    flex: 2,
                    child: Text(
                      state.votes[state.voteIterator].question.question,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: SizeConfig.defaultSize * 2.5,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ChoiceFriendButton(name: friend1.name, enterYear: friend1.admissionNumber, department: friend1.university.department),
                            ChoiceFriendButton(name: friend2.name, enterYear: friend2.admissionNumber, department: friend2.university.department),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ChoiceFriendButton(name: friend3.name, enterYear: friend3.admissionNumber, department: friend3.university.department),
                            ChoiceFriendButton(name: friend4.name, enterYear: friend4.admissionNumber, department: friend4.university.department),
                          ],
                        ),
                        const SizedBox(
                          height: 3,
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
                                  // Navigator.push(context, MaterialPageRoute(builder: (context) => VoteResultView()));
                                  BlocProvider.of<VoteCubit>(context).nextVote(state.voteIterator, 0);  // 투표안함
                                },
                                icon: const Icon(Icons.skip_next)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(),
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
  final String name;
  final int enterYear;
  final String department;

  const ChoiceFriendButton({
    super.key,
    required this.name,
    required this.enterYear,
    required this.department,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        BlocProvider.of<VoteCubit>(context).nextVote(0, 1); // TODO 실제 선택을 반영하도록 수정
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
