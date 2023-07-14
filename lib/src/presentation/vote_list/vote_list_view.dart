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
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(SizeConfig.defaultSize * 1.5),
        child: BlocBuilder<VoteListCubit, VoteListState>(
          builder: (context, state) {
            if (state.votes.length == 0) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("아직 받은 투표가 없어요!", style: TextStyle(
                        fontSize: SizeConfig.defaultSize * 2, fontWeight: FontWeight.w600
                    ),),
                    SizedBox(height: SizeConfig.defaultSize *2,),
                    Text("친구들이 나를 투표하면 알림이 쌓여요!", style: TextStyle(
                        fontSize: SizeConfig.defaultSize * 2, fontWeight: FontWeight.w600
                    ),),
                    // Container( // TODO HOTFIX : 투표 꿀팁 일단 보류 (넣으면 좋음)
                    //   child: Column(
                    //     children: [
                    //       Text("투표를 많이 받는 꿀팁"),
                    //       Text("Dart에서 이미지게임으로 친구들을 투표하면\n친구들에게 나의 존재를 알릴 수 있어요!\n투표를 하거나 친구들을 많이 초대해서 투표수를 늘려보세요!")
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              );
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
        // BlocProvider.of<VoteListCubit>(context).pressedVoteInList(voteId); // TODO : MVP 이후 복구하기 (힌트 & Point가 생겼을 때)
      },
      child: Container(
        padding: EdgeInsets.all(SizeConfig.defaultSize * 1),
        decoration: BoxDecoration(
          border: Border.all(
            width: SizeConfig.defaultSize * 0.1,
            color: isVisited ? Colors.grey : Color(0xff7C83FD),
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
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
            Row(
              children: [
                Icon(Icons.person_pin_rounded, size: SizeConfig.defaultSize * 4.5, color: Color(0xff7C83FD),),
                SizedBox(width: SizeConfig.defaultSize),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("$gender학생이 Dart를 보냈어요!", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.5, fontWeight: FontWeight.w500,)),
                    SizedBox(height: SizeConfig.defaultSize * 0.5,),
                    Text("$question",
                        style: TextStyle(
                          fontSize: SizeConfig.defaultSize *
                              1.3 *
                              ((question.length <= 25 ? 1 : 1 - ((question.length - 15) * 0.035))),
                          fontWeight: FontWeight.w400,
                        )),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Text("$datetime", style: TextStyle(fontSize: SizeConfig.defaultSize * 1)),
                SizedBox(width: SizeConfig.defaultSize,)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
