import 'package:dart_flutter/res/config/size_config.dart';
import 'package:dart_flutter/src/common/util/analytics_util.dart';
import 'package:dart_flutter/src/common/util/toast_util.dart';
import 'package:dart_flutter/src/presentation/meet/view/meet_create_team.dart';
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
            return _TopSection(ancestorContext: state);
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
        child: Container( // 여기부터 Component화
          width: SizeConfig.screenWidth,
          height: SizeConfig.defaultSize * 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Padding( // Container 내부 패딩
            padding: EdgeInsets.symmetric(vertical: SizeConfig.defaultSize * 1.2, horizontal: SizeConfig.defaultSize * 1.5),
            child: Column(
              children: [
                Row( // 위층
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text("팀 이름", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.6, fontWeight: FontWeight.w600),),
                        Text("  21.5세", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.6),)
                      ],
                    ),
                    Text("서울 인천", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.4),),
                  ],
                ),
                  SizedBox(height: SizeConfig.defaultSize * 1.5,),

                Row( // 아래층
                  children: [
                    Container(
                      width: SizeConfig.defaultSize * 12,
                      child: Stack(
                        children: [
                          Container( // 버리는 사진
                            width: SizeConfig.defaultSize * 4,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Image.asset(
                                'assets/images/profile-mockup3.png',
                                width: SizeConfig.defaultSize * 4, // 이미지 크기
                                height: SizeConfig.defaultSize * 4,
                              ),
                            ),
                          ),
                          for (int i = 2; i >= 0 ; i--)
                            Positioned(
                              left: i * SizeConfig.defaultSize * 3,
                              child: Container(
                                width: SizeConfig.defaultSize * 4,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Image.asset(
                                    i == 0
                                      ? 'assets/images/profile-mockup.png'
                                      : (i == 1 ? 'assets/images/profile-mockup2.png' : 'assets/images/profile-mockup3.png'), // 이미지 경로를 각 이미지에 맞게 설정
                                    width: SizeConfig.defaultSize * 4, // 이미지 크기
                                    height: SizeConfig.defaultSize * 4,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("${meetState.userResponse.university?.name ?? '학교를 불러오지 못했어요'}",
                                style: TextStyle(fontSize: SizeConfig.defaultSize * 1.4, fontWeight: FontWeight.w600),),
                              if (meetState.userResponse.personalInfo?.verification.isVerificationSuccess ?? false)
                                Image.asset("assets/images/check.png", width: SizeConfig.defaultSize * 1.3),
                            ],
                          ),
                          Text("${meetState.userResponse.university?.department ?? '학과를 불러오지 못했어요'}",
                            style: TextStyle(fontSize: SizeConfig.defaultSize * 1.4, overflow: TextOverflow.ellipsis),)
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TopSection extends StatefulWidget {
  MeetState ancestorContext;

  _TopSection({
    super.key,
    required this.ancestorContext
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
