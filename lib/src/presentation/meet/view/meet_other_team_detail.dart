import 'package:dart_flutter/src/domain/entity/blind_date_team_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../res/config/size_config.dart';
import '../../../common/util/toast_util.dart';
import '../../component/meet_one_member_cardview.dart';
import '../viewmodel/meet_cubit.dart';
import '../viewmodel/state/meet_state.dart';

class MeetOtherTeamDetail extends StatelessWidget {
  int teamId;

  MeetOtherTeamDetail({super.key, required this.teamId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MeetCubit, MeetState>(
      builder: (context, state) {
        return FutureBuilder<BlindDateTeamDetail>(
          future: context.read<MeetCubit>().getBlindDateTeam(teamId),
          builder: (context, futureState) {
            if (futureState.connectionState == ConnectionState.waiting) {
              return Scaffold(
                body: Container(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(color: Color(0xffFE6059)),
                          SizedBox(height: SizeConfig.defaultSize * 5,),
                        Text("팀 정보를 불러오고 있어요 . . .", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.8),)
                      ],
                    ),
                ),
              );
            } else if (futureState.hasError) {
              return Text('Error: ${futureState.error}');
            } else if (futureState.hasData) {
              BlindDateTeamDetail blindDateTeamDetail = futureState.data!;
              return Scaffold(
                backgroundColor: Colors.grey.shade50,

                appBar: AppBar(
                  toolbarHeight: SizeConfig.defaultSize * 7,
                  automaticallyImplyLeading: false,
                  surfaceTintColor: Colors.white,
                  title: _TopBarSection(team: blindDateTeamDetail),
                ),

                body: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(SizeConfig.defaultSize * 1.5),
                      child: Column(
                        children: [
                          ...List.generate(blindDateTeamDetail.teamUsers.length, (index) {
                            return Column(
                              children: [
                                MeetOneMemberCardview(userResponse: blindDateTeamDetail.teamUsers[index]),
                                SizedBox(height: SizeConfig.defaultSize),
                              ],
                            );
                          }),
                        ],
                      ),
                    )
                ),

                bottomNavigationBar: Container(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.defaultSize * 17,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(SizeConfig.defaultSize * 1.5),
                    child: Column(
                      children: [
                        Container(
                          width: SizeConfig.screenWidth,
                          height: SizeConfig.defaultSize * 5.5,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Colors.grey.shade200,
                                  width: 2
                              )
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: SizeConfig.defaultSize * 2, right: SizeConfig.defaultSize * 1.5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("우리 팀 이름", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.8),),  // TODO : 팀 이름
                                Row(
                                  children: [
                                    Text("팀 바꾸기"),
                                    Icon(Icons.expand_more_rounded, color: Colors.grey,)
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: SizeConfig.defaultSize,),
                        Container(
                          width: SizeConfig.screenWidth,
                          height: SizeConfig.defaultSize * 5.5,
                          decoration: BoxDecoration(
                            color: Color(0xffFE6059),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("2000", style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: SizeConfig.defaultSize * 1.5,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white
                                  ),),
                                  Text(" 500 포인트로 대화 시작하기", style: TextStyle(
                                      fontSize: SizeConfig.defaultSize * 2,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white
                                  ),),
                                ],
                              )),
                        ),
                        SizedBox(height: SizeConfig.defaultSize * 2)
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Text("데이터 정보가 없습니다.");
            }
          }
        );
      }
    );
  }
}

class _TopBarSection extends StatelessWidget {
  BlindDateTeamDetail team;

  _TopBarSection({
    super.key,
    required this.team
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios_new_rounded, size: SizeConfig.defaultSize * 2,),
                    padding: EdgeInsets.zero,
                  ),
                  Text(team.name, style: TextStyle(
                      fontSize: SizeConfig.defaultSize * 1.7,
                      fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Row(
                children: [
                  Text("${(2023-team.averageBirthYear+1).toStringAsFixed(1)}세", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.7),),
                  PopupMenuButton<String>(
                    icon: Icon(Icons.more_horiz_rounded, color: Colors.grey.shade300,),
                    padding: EdgeInsets.zero,
                    color: Colors.white,
                    surfaceTintColor: Colors.white,
                    onSelected: (value) {
                      if (value == 'report') {
                        // AnalyticsUtil.logEvent("내정보_마이_내친구더보기_신고");
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('팀을 신고하시겠어요?'),
                            content: const Text('팀을 신고하면 엔대생에서 빠르게 신고 처리를 해드려요!'),
                            backgroundColor: Colors.white,
                            surfaceTintColor: Colors.white,
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, '취소');
                                  // AnalyticsUtil.logEvent("내정보_마이_내친구신고_취소");
                                },
                                child: const Text('취소', style: TextStyle(color: Color(0xffFE6059)),),
                              ),
                              TextButton(
                                onPressed: () => {
                                  // AnalyticsUtil.logEvent("내정보_마이_내친구신고_신고확정"), // TODO : properties로 신고한 팀 넘기기
                                  Navigator.pop(context, '신고'),
                                  ToastUtil.showMeetToast("사용자가 신고되었어요!", 1),
                                  // TODO : 신고 기능 (서버 연결)
                                },
                                child: const Text('신고', style: TextStyle(color: Color(0xffFE6059)),),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem<String>(
                          value: 'report',
                          child: Text("신고하기", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.5)),
                        ),
                      ];
                    },
                  ),
                ],
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 1.4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(team.universityName, style: TextStyle(
                  fontSize: SizeConfig.defaultSize * 1.7,),
                ),
                Text("       "),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Text(team.regions.map((location) => location.name).join(' '),
                      style: TextStyle(fontSize: SizeConfig.defaultSize * 1.7, color: Colors.grey, overflow: TextOverflow.ellipsis),),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: SizeConfig.defaultSize * 1.5,)
        ],
      ),
    );
  }
}
