import 'package:dart_flutter/res/config/size_config.dart';
import 'package:dart_flutter/src/common/util/analytics_util.dart';
import 'package:dart_flutter/src/common/util/toast_util.dart';
import 'package:dart_flutter/src/presentation/meet/view/meet_create_team.dart';
import 'package:dart_flutter/src/presentation/component/meet_one_team_cardview.dart';
import 'package:dart_flutter/src/presentation/meet/viewmodel/meet_cubit.dart';
import 'package:dart_flutter/src/presentation/meet/viewmodel/state/meet_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

class MeetBoard extends StatelessWidget {
  const MeetBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,

      appBar: AppBar(
        toolbarHeight: SizeConfig.defaultSize * 8.5,
        backgroundColor: Colors.white,
        title: BlocBuilder<MeetCubit, MeetState>(
          builder: (context, state) {
            return _TopSection(ancestorState: state);
          }
        ),
      ),

      body: BlocBuilder<MeetCubit, MeetState>(
        builder: (context, state) {
          return _BodySection(meetState: state,);
        }
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          AnalyticsUtil.logEvent("과팅_목록_팀만들기버튼_터치");
          if (context.read<MeetCubit>().state.isLoading) {
            ToastUtil.showMeetToast("다시 터치해주세요!", 2);
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
        backgroundColor: const Color(0xffFE6059),
      ),
    );
  }
}

class _BodySection extends StatelessWidget {
  MeetState meetState;

  _BodySection({
    super.key,
    required this.meetState
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 1, vertical: SizeConfig.defaultSize),
        child: Column(
          children: [
            MeetOneTeamCardview(meetState: meetState, isMyTeam: true), // 우리팀
            Column(
              children: [
                SizedBox(height: SizeConfig.defaultSize * 0.6,),
                MeetOneTeamCardview(meetState: meetState, isMyTeam: false) // 이성팀 for문
              ],
            )
          ],
        )
      ),
    );
  }
}

class _TopSection extends StatefulWidget {
  MeetState ancestorState;

  _TopSection({
    super.key,
    required this.ancestorState
  });

  @override
  State<_TopSection> createState() => _TopSectionState();
}

class _TopSectionState extends State<_TopSection> {
  @override
  Widget build(BuildContext context) {
    String selectedTeamName = "팀 1 dddddddddd"; // 초기 선택된 팀 이름
    List<String> teamNames = ["팀 1 dddddddddd", "팀 2", "팀 3", "팀 4"]; // Mockup 팀 이름 목록

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 0.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("과팅", style: TextStyle(
            fontSize: SizeConfig.defaultSize * 1.7,
            fontWeight: FontWeight.w600
          ),),
          SizedBox(height: SizeConfig.defaultSize * 0.4,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  DropdownButton<String>(
                    value: selectedTeamName,
                    padding: EdgeInsets.all(0),
                    onChanged: (newValue) {
                      setState(() {
                        selectedTeamName = newValue!;
                      });
                    },
                    items: teamNames.map((teamName) {
                      return DropdownMenuItem<String>(
                        value: teamName,
                        child: Text(
                          teamName,
                          style: TextStyle(
                            fontSize: SizeConfig.defaultSize * 1.6,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  Text("으로 보고 있어요!", style: TextStyle(
                    fontSize: SizeConfig.defaultSize * 1.6,
                    fontWeight: FontWeight.w400
                  ),),
                ],
              ),
              Text("필터링", style: TextStyle(
                fontSize: SizeConfig.defaultSize * 1.6,
                fontWeight: FontWeight.w400
              ),)
            ],
          ),
          SizedBox(height: SizeConfig.defaultSize,)
        ],
      ),
    );
  }
}
