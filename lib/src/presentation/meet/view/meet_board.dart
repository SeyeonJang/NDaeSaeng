import 'package:dart_flutter/res/config/size_config.dart';
import 'package:dart_flutter/src/common/util/analytics_util.dart';
import 'package:dart_flutter/src/presentation/meet/view/meet_create_team.dart';
import 'package:dart_flutter/src/presentation/meet/viewmodel/meet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

class MeetBoard extends StatelessWidget {
  const MeetBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Text("meetBoard"),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          AnalyticsUtil.logEvent("과팅_목록_팀만들기버튼_터치");
          if (context.read<MeetCubit>().state.isLoading) {
            return;
          }
          await Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeftJoined, child: MeetCreateTeam(
            onFinish: () {
              // context.read<MeetCubit>().refreshMeetPage();
            },
            state: context.read<MeetCubit>().state,
          ), childCurrent: this)).then((value) async {
            if (value == null) return;
            await context.read<MeetCubit>().createNewTeam(value);
          });
          // context.read<MeetCubit>().refreshMeetPage();
          Navigator.pop(context);
        },
        shape: CircleBorder(),
        child: Icon(Icons.add_rounded),
        backgroundColor: Color(0xffFE6059),
      ),
    );
  }
}
