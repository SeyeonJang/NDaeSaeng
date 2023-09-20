import 'package:dart_flutter/res/config/size_config.dart';
import 'package:dart_flutter/src/common/util/toast_util.dart';
import 'package:dart_flutter/src/domain/entity/meet_team.dart';
import 'package:dart_flutter/src/domain/mapper/student_mapper.dart';
import 'package:dart_flutter/src/presentation/component/meet_one_member_cardview_novote.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entity/blind_date_team_detail.dart';
import '../../component/meet_one_member_cardview.dart';
import '../viewmodel/meet_cubit.dart';
import '../viewmodel/state/meet_state.dart';

class MeetMyTeamDetail extends StatelessWidget {
  final int teamId;

  MeetMyTeamDetail({super.key, required this.teamId});

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
                      title: _TopBarSection(team: blindDateTeamDetail, ancestorContext: context,),
                    ),

                    body: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.all(SizeConfig.defaultSize * 1.5),
                          child: Column(
                            children: [
                              ...List.generate(blindDateTeamDetail.teamUsers.length, (index) {
                                return Column(
                                  children: [
                                    MeetOneMemberCardview(userResponse: StudentMapper.toBlindDateUserDetail(blindDateTeamDetail.teamUsers[index])),
                                    // MeetOneMemberCardview(userResponse: blindDateTeamDetail.teamUsers[index]),
                                    MeetOneMemberCardviewNoVote(userResponse: blindDateTeamDetail.teamUsers[index], university: blindDateTeamDetail.universityName,),
                                    SizedBox(height: SizeConfig.defaultSize),
                                  ],
                                );
                              }),
                            ],
                          ),
                        )
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
  BuildContext ancestorContext;

  _TopBarSection({
    super.key,
    required this.team,
    required this.ancestorContext
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
                    color: Colors.white,
                    surfaceTintColor: Colors.white,
                    onSelected: (value) {
                      // AnalyticsUtil.logEvent("과팅_대기_내팀보기_내팀_더보기_터치", properties: {
                      //   "teamName": context.read<MeetCubit>().state.myTeams[i].name,
                      //   "members": context.read<MeetCubit>().state.myTeams[i].members.length,
                      // });
                      if (value == 'delete') {
                        // AnalyticsUtil.logEvent("과팅_대기_내팀보기_내팀_더보기_삭제_터치", properties: {
                        //   "teamName": context.read<MeetCubit>().state.myTeams[i].name,
                        //   "members": context.read<MeetCubit>().state.myTeams[i].members.length,
                        // });
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext dialogContext) => AlertDialog(
                            content: Text('\'${team.name=='' ? '(팀명 없음)' : team.name}\' 팀을 삭제하시겠어요?', style: TextStyle(fontSize: SizeConfig.defaultSize * 1.8),),
                            backgroundColor: Colors.white,
                            surfaceTintColor: Colors.white,
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(dialogContext, '취소');
                                },
                                child: const Text('취소', style: TextStyle(color: Color(0xffFF5C58)),),
                              ),
                              TextButton(
                                onPressed: () async {
                                  await ancestorContext.read<MeetCubit>().removeTeam(team.id.toString());
                                  ToastUtil.showMeetToast("팀을 삭제했어요!", 0);
                                  Navigator.pop(dialogContext);
                                  Navigator.pop(context);
                                  ancestorContext.read<MeetCubit>().initMeet();
                                },
                                child: const Text('삭제', style: TextStyle(color: Color(0xffFF5C58)),),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem<String>(
                          value: 'delete',
                          child: Text("삭제하기", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.5)),
                        ),
                        // PopupMenuItem<String>(
                        //   value: 'edit',
                        //   child: Text("수정하기", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.5)),
                        // ),
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