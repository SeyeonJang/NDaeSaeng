import 'package:dart_flutter/src/data/model/vote.dart';
import 'package:dart_flutter/src/presentation/vote_list/viewmodel/state/vote_list_state.dart';
import 'package:dart_flutter/src/presentation/vote_list/viewmodel/vote_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../res/size_config.dart';

class VoteDetailView extends StatelessWidget {
  const VoteDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              // horizontal: SizeConfig.defaultSize * 5,
              vertical: SizeConfig.defaultSize * 2),
          child: BlocBuilder<VoteListCubit,VoteListState> (
            builder: (context, state) {
              VoteResponse vote = state.getVoteById(state.nowVoteId);
              return VoteDetail(
                voteId: vote.voteId,
                pickedUserSex: vote.pickUserSex,
                question: vote.question.question,
              );
            }
          ),
        ),
      ),
    );
  }
}

class VoteDetail extends StatelessWidget {
  final int voteId;
  final String pickedUserSex;
  final String question;

  const VoteDetail({
    super.key, required this.voteId, required this.pickedUserSex, required this.question,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {
                  BlocProvider.of<VoteListCubit>(context).backToVoteList();
                  // Navigator.pop(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => VoteListView()));
                },
                icon: Icon(Icons.arrow_back_ios_new_rounded,
                    size: SizeConfig.defaultSize * 3)),
            Text("$pickedUserSex학생이 보낸 Dart",
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: SizeConfig.defaultSize * 2.5)),
            SizedBox(width: SizeConfig.defaultSize * 5),
          ],
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.defaultSize * 5,
                vertical: SizeConfig.defaultSize * 2),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(height: SizeConfig.defaultSize * 3),
                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: Column(
                      children: [
                        Icon(Icons.emoji_emotions,
                            size: SizeConfig.defaultSize * 22),
                        Text(
                          question,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: SizeConfig.defaultSize * 2.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Flexible(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("누가 보냈는지 궁금하다면?"),
                        HintButton(buttonName: '학번 보기', point: 100),
                        HintButton(buttonName: '학과 보기', point: 150),
                        HintButton(buttonName: '초성 보기 한 글자 보기', point: 500),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class HintButton extends StatelessWidget {
  final String buttonName;
  final int point;

  const HintButton({
    super.key,
    required this.buttonName,
    required this.point,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.defaultSize * 40,
      child: ElevatedButton(
        onPressed: () {},
        child: Text(
          "$buttonName (${point}P)",
          style: TextStyle(
            fontSize: SizeConfig.defaultSize * 2,
          ),
        ),
      ),
    );
  }
}
