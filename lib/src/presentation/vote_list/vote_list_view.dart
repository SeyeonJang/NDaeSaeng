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
            return makeList(state.votes);
          },
        ),
      ),
    );
  }

  ListView makeList(List<VoteResponse> snapshot) {
    return ListView.separated(
      itemBuilder: (context, index) {
        var vote = snapshot[index];
        var timeago = TimeagoUtil().format(vote.pickedAt);
        var visited = BlocProvider.of<VoteListCubit>(context).isVisited(vote.voteId);
        return dart(
          voteId: vote.voteId,
          sex: vote.pickUserSex,
          question: vote.question.question,
          datetime: timeago,
          isVisited: visited,
        );
      },
      separatorBuilder: (context, index) => SizedBox(height: SizeConfig.defaultSize * 1.4),
      itemCount: snapshot.length,
    );
  }
}

class dart extends StatelessWidget {
  final int voteId;
  final String sex;
  final String question;
  final String datetime;
  final bool isVisited;

  const dart({
    super.key,
    required this.voteId,
    required this.sex,
    required this.question,
    required this.datetime,
    required this.isVisited,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<VoteListCubit>(context).pressedVoteInList(voteId);
      },
      child: Container(
        padding: EdgeInsets.all(SizeConfig.defaultSize * 1),
        decoration: BoxDecoration(
          border: Border.all(
            width: SizeConfig.defaultSize * 0.1,
            color: isVisited ? Colors.grey : Colors.red,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(Icons.heart_broken, size: SizeConfig.defaultSize * 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("$sex학생이 Dart를 보냈어요!"),
                Text("$question"),
              ],
            ),
            Text("$datetime"),
          ],
        ),
      ),
    );
  }
}
