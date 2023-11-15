import 'package:dart_flutter/res/config/size_config.dart';
import 'package:dart_flutter/src/common/util/analytics_util.dart';
import 'package:dart_flutter/src/common/util/toast_util.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';
import 'package:dart_flutter/src/domain/mapper/student_mapper.dart';
import 'package:dart_flutter/src/presentation/component/meet_one_member_cardview_novote.dart';
import 'package:dart_flutter/src/presentation/mypage/view/student_vertification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entity/blind_date_team_detail.dart';
import '../viewmodel/meet_cubit.dart';
import '../viewmodel/state/meet_state.dart';

class MeetMyTeamDetail extends StatelessWidget {
  final int teamId;
  final User userResponse;

  const MeetMyTeamDetail({super.key, required this.teamId, required this.userResponse});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MeetCubit, MeetState>(
        builder: (context, state) {
          return FutureBuilder<BlindDateTeamDetail>(
              // future: context.read<MeetCubit>().getMyTeam(teamId.toString()),
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
                          const CircularProgressIndicator(color: Color(0xffFE6059)),
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
                                      MeetOneMemberCardviewNoVote(
                                        userResponse: StudentMapper.toBlindDateUserDetail(blindDateTeamDetail.teamUsers[index]),
                                        university: blindDateTeamDetail.universityName,
                                        isProfileImageCached: false,
                                      ),
                                    SizedBox(height: SizeConfig.defaultSize),
                                  ],
                                );
                              }),
                            ],
                          ),
                        )
                    ),
                    bottomNavigationBar: !(userResponse.personalInfo?.verification.isVerificationSuccess ?? true)
                        ? Padding(
                            padding: EdgeInsets.only(bottom: SizeConfig.defaultSize * 5, left: SizeConfig.defaultSize * 2, right: SizeConfig.defaultSize * 2),
                            child: Material(
                              child: InkWell(
                                onTap: () async {
                                  AnalyticsUtil.logEvent("홈_내팀보기_학생증인증버튼_터치", properties: {
                                    '인증 상태' : userResponse.personalInfo?.verification
                                  });
                                  if (!(userResponse.personalInfo?.verification.isVerificationSuccess ?? true)) {
                                    await Navigator.push(context, MaterialPageRoute(builder: (_) => StudentVertification(
                                      userResponse: userResponse,
                                    )));
                                  }
                                },
                                child: Container(
                                  height: SizeConfig.defaultSize * 6,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffFE6059),
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text("학생증 인증하고 인증 배지 얻기", style: TextStyle(
                                    fontSize: SizeConfig.defaultSize * 1.8,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),)
                                ),
                              ),
                            ),
                          )
                        : const SizedBox()
                  );
                } else {
                  return const Text("데이터 정보가 없습니다.");
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
                  Text("${(team.averageAge > 1000 ? 2023-team.averageAge+1 : team.averageAge).toStringAsFixed(1)}세", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.7),),
                  PopupMenuButton<String>(
                    icon: Icon(Icons.more_horiz_rounded, color: Colors.grey.shade300,),
                    color: Colors.white,
                    surfaceTintColor: Colors.white,
                    onSelected: (value) {
                      AnalyticsUtil.logEvent("홈_내팀보기_내팀_더보기_터치", properties: {
                        'teamId': team.id,
                        "teamName": team.name,
                        "members": team.teamUsers.toString(),
                        'teamUnivName': team.universityName
                      });
                      if (value == 'delete') {
                        AnalyticsUtil.logEvent("홈_내팀보기_내팀_더보기_삭제_터치", properties: {
                          'teamId': team.id,
                          "teamName": team.name,
                          "members": team.teamUsers.toString(),
                          'teamUnivName': team.universityName
                        });
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext dialogContext) => AlertDialog(
                            title: Text('\'${team.name=='' ? '(팀명 없음)' : team.name}\' 팀을 삭제하시겠어요?', style: TextStyle(fontSize: SizeConfig.defaultSize * 1.8), textAlign: TextAlign.center,),
                            content: const Text("내 팀을 삭제하면 내가 받은 호감과 보낸 호감, 현재 팀으로 대화했던 채팅방이 모두 사라져요! 🥺"),
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
                                  Navigator.pop(context, true);
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
                const Text("       "),
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