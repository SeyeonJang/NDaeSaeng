import 'dart:math';

import 'package:dart_flutter/res/size_config.dart';
import 'package:dart_flutter/src/common/util/timeago_util.dart';
import 'package:dart_flutter/src/data/model/vote.dart';
import 'package:dart_flutter/src/presentation/vote_list/viewmodel/state/vote_list_state.dart';
import 'package:dart_flutter/src/presentation/vote_list/viewmodel/vote_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VoteListView extends StatefulWidget {
  const VoteListView({Key? key}) : super(key: key);

  @override
  State<VoteListView> createState() => _VoteListViewState();
}

class _VoteListViewState extends State<VoteListView> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<VoteListCubit>(context).initVotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(SizeConfig.defaultSize * 1.5),
        child: BlocBuilder<VoteListCubit, VoteListState>(
          builder: (context, state) {
            if (state.votes.length == 0) {
              return const Center(child: Text("아직 받은 투표가 없어요!"));
            }
            return makeList(state.votes);
          },
        ),
      ),
    );
  }

  ListView makeList(List<VoteResponse> snapshot) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var vote = snapshot[index];
        var timeago = TimeagoUtil().format(vote.pickedTime!);
        var visited = BlocProvider.of<VoteListCubit>(context).isVisited(vote.voteId!);
        return Column(
          children: [
            dart(
              voteId: vote.voteId!,
              gender: vote.pickedUser!.gender ?? "",
              question: vote.question!.content ?? "(알수없음)",
              datetime: timeago,
              isVisited: visited,
            ),
            SizedBox(height: SizeConfig.defaultSize * 1.4),
          ],
        );
      },
      itemCount: snapshot.length,
    );
  }
}

class dart extends StatelessWidget {
  final int voteId;
  final String gender;
  final String question;
  final String datetime;
  final bool isVisited;

  const dart({
    super.key,
    required this.voteId,
    required this.gender,
    required this.question,
    required this.datetime,
    required this.isVisited,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // BlocProvider.of<VoteListCubit>(context).pressedVoteInList(voteId);
      },
      child: Container(
        padding: EdgeInsets.all(SizeConfig.defaultSize * 1),
        decoration: BoxDecoration(
          border: Border.all(
            width: SizeConfig.defaultSize * 0.1,
            color: isVisited ? Colors.grey : Colors.blueAccent,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              flex: 1,
              child: Icon(Icons.person, size: SizeConfig.defaultSize * 5),
            ),
            // Flexible(  // TODO : MVP 이후 지우기
            //   flex: 3,
            //   fit: FlexFit.tight,
            //   child: Row(
            //     children: [
            //       const SizedBox(width: 10),
            //       Text("아직 받은 투표가 없어요!", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.5, fontWeight: FontWeight.w500)),
            //     ],
            //   ),
            // ),

            Flexible(
              // TODO : MVP 이후 복구하기
              flex: 3,
              fit: FlexFit.tight,
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("$gender학생이 Dart를 보냈어요!", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.2)),
                      Text("$question",
                          style: TextStyle(
                            fontSize: SizeConfig.defaultSize *
                                1.5 *
                                ((question.length <= 15 ? 1 : 1 - ((question.length - 15) * 0.035))),
                            fontWeight: FontWeight.w500,
                          )),
                    ],
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                alignment: Alignment.centerRight,
                child: Text("$datetime", style: TextStyle(fontSize: SizeConfig.defaultSize * 1)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
