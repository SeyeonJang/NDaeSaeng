import 'package:dart_flutter/src/common/util/analytics_util.dart';
import 'package:dart_flutter/src/domain/entity/blind_date_team_detail.dart';
import 'package:dart_flutter/src/domain/mapper/student_mapper.dart';
import 'package:dart_flutter/src/presentation/chat/viewmodel/chat_cubit.dart';
import 'package:dart_flutter/src/presentation/component/meet_one_member_cardview_novote.dart';
import 'package:dart_flutter/src/presentation/component/meet_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../res/config/size_config.dart';
import '../../../common/util/toast_util.dart';
import '../viewmodel/state/chat_state.dart';

class ChatResponseGetDetail extends StatelessWidget {
  int teamId;
  int proposalId;

  ChatResponseGetDetail({super.key, required this.teamId, required this.proposalId});

  @override
  Widget build(BuildContext contextTop) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        return FutureBuilder<BlindDateTeamDetail>(
          future: context.read<ChatCubit>().getBlindDateTeam(teamId),
          builder: (context, futureState) {
            if (futureState.connectionState == ConnectionState.waiting) {
              return Scaffold(
                body: Container(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight,
                  color: Colors.white,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MeetProgressIndicatorWithMessage(text: "팀 정보를 불러오고 있어요 . . ."),
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
                                MeetOneMemberCardviewNoVote(userResponse: StudentMapper.toBlindDateUserDetail(blindDateTeamDetail.teamUsers[index]), university: blindDateTeamDetail.universityName,),
                                SizedBox(height: SizeConfig.defaultSize * 1.5),
                              ],
                            );
                          }),
                        ],
                      ),
                    )
                ),

                bottomNavigationBar: Container(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.defaultSize * 12,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(SizeConfig.defaultSize * 1.5),
                    child: Column(
                      children: [
                        SizedBox(height: SizeConfig.defaultSize,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector( // 거절
                              onTap: () {
                                AnalyticsUtil.logEvent('채팅_받은호감_상세조회_거절버튼');
                                showDialog(
                                    context: context,
                                    builder: (BuildContext modalContext) {
                                      return AlertDialog(
                                        backgroundColor: Colors.white,
                                        surfaceTintColor: Colors.white,
                                        content: Container(
                                            width: SizeConfig.screenWidth * 0.9,
                                            height: SizeConfig.screenHeight * 0.15,
                                            alignment: Alignment.center,
                                            child: Padding(
                                              padding: EdgeInsets.only(top: SizeConfig.defaultSize * 0.8),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  Column(
                                                    children: [
                                                      RichText(
                                                          text: TextSpan(
                                                              style: TextStyle(fontSize: SizeConfig.defaultSize * 1.8, fontWeight: FontWeight.w500),
                                                              children: <TextSpan>[
                                                                TextSpan(text: "'${blindDateTeamDetail.name}'", style: const TextStyle(color: Color(0xffFF5C58), fontWeight: FontWeight.w600)),
                                                                const TextSpan(text: "의 호감을", style: TextStyle(color: Colors.black)),
                                                              ]
                                                          )
                                                      ),
                                                      Text("거절하시겠어요?", style: TextStyle(
                                                        fontSize: SizeConfig.defaultSize * 1.8,
                                                        fontWeight: FontWeight.w500,
                                                        color: Colors.black,
                                                      ),),
                                                    ],
                                                  ),
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: [
                                                      Text("상대 팀의 호감을 거절하면", style: TextStyle(
                                                        fontSize: SizeConfig.defaultSize * 1.5,
                                                        fontWeight: FontWeight.w500,
                                                        color: Colors.grey,
                                                      ),),
                                                        SizedBox(height: SizeConfig.defaultSize * 0.3,),
                                                      Text("받은 호감 리스트에서 사라지고", style: TextStyle(
                                                        fontSize: SizeConfig.defaultSize * 1.5,
                                                        fontWeight: FontWeight.w500,
                                                        color: Colors.grey,
                                                      ),),
                                                        SizedBox(height: SizeConfig.defaultSize * 0.3,),
                                                      Text("채팅할 수 있는 기회가 사라져요!", style: TextStyle(
                                                        fontSize: SizeConfig.defaultSize * 1.5,
                                                        fontWeight: FontWeight.w500,
                                                        color: Colors.grey,
                                                      ),),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )),
                                        actions: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    AnalyticsUtil.logEvent('채팅_받은호감_상세조회_거절버튼_취소');
                                                    Navigator.pop(modalContext, false);
                                                  },
                                                  child: Container(
                                                    height: SizeConfig.defaultSize * 4.5,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      color: Colors.grey.shade200,
                                                    ),
                                                    child: const Center(child: Text("취소")),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: SizeConfig.defaultSize,),
                                              GestureDetector(
                                                onTap: () {
                                                  AnalyticsUtil.logEvent('채팅_받은호감_상세조회_거절버튼_거절');
                                                  Navigator.pop(modalContext, true);
                                                  context.read<ChatCubit>().rejectChatProposal(proposalId);
                                                  showDialog<String>(
                                                      context: modalContext,
                                                      builder: (BuildContext dialogContext) {
                                                        Future.delayed(const Duration(seconds: 2), () {
                                                          Navigator.pop(dialogContext);
                                                          Navigator.pop(contextTop);
                                                        });
                                                        return AlertDialog(
                                                          surfaceTintColor: Colors.white,
                                                          title: Container(alignment: Alignment.center, child: Text('호감을 거절했어요!', style: TextStyle(fontSize: SizeConfig.defaultSize * 1.5, fontWeight: FontWeight.w600, color: const Color(0xffFF5C58)),)),
                                                          content: Container(alignment: Alignment.center, height: SizeConfig.defaultSize * 4, child: const Text('받은 요청 목록에서도 보이지 않아요!',)),
                                                        );
                                                      }
                                                  );
                                                },
                                                child: Container(
                                                  height: SizeConfig.defaultSize * 4.5,
                                                  width: SizeConfig.defaultSize * 10,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: const Color(0xffFF5C58),
                                                  ),
                                                  child: const Center(child: Text("거절하기", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),)),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      );
                                    });
                              },
                              child: Container(
                                width: SizeConfig.screenWidth * 0.25,
                                height: SizeConfig.defaultSize * 5.5,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                    child: Text("거절", style: TextStyle(
                                        fontSize: SizeConfig.defaultSize * 2,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black
                                    ),)
                                ),
                              ),
                            ),

                            GestureDetector(
                              onTap: () {
                                AnalyticsUtil.logEvent('채팅_받은호감_상세조회_수락버튼');
                                showDialog(
                                  context: context,
                                  builder: (BuildContext modalContext) {
                                    return AlertDialog(
                                      backgroundColor: Colors.white,
                                      surfaceTintColor: Colors.white,
                                      content: Container(
                                          width: SizeConfig.screenWidth * 0.9,
                                          height: SizeConfig.screenHeight * 0.15,
                                          alignment: Alignment.center,
                                          child: Padding(
                                            padding: EdgeInsets.only(top: SizeConfig.defaultSize * 0.8),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Column(
                                                  children: [
                                                    RichText(
                                                        text: TextSpan(
                                                            style: TextStyle(fontSize: SizeConfig.defaultSize * 1.8, fontWeight: FontWeight.w500),
                                                            children: <TextSpan>[
                                                              TextSpan(text: "'${blindDateTeamDetail.name}'", style: const TextStyle(color: Color(0xffFF5C58), fontWeight: FontWeight.w600)),
                                                              const TextSpan(text: "의 호감을", style: TextStyle(color: Colors.black)),
                                                            ]
                                                        )
                                                    ),
                                                    Text("수락하시겠어요?", style: TextStyle(
                                                      fontSize: SizeConfig.defaultSize * 1.8,
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.black,
                                                    ),),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Text("내가 상대 팀의 호감을 수락하면", style: TextStyle(
                                                      fontSize: SizeConfig.defaultSize * 1.5,
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.grey,
                                                    ),),
                                                      SizedBox(height: SizeConfig.defaultSize * 0.5,),
                                                    Text("채팅방이 열리고 대화를 시작할 수 있어요!", style: TextStyle(
                                                      fontSize: SizeConfig.defaultSize * 1.5,
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.grey,
                                                    ),),
                                                  ],
                                                )
                                              ],
                                            ),
                                          )),
                                      actions: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () {
                                                  AnalyticsUtil.logEvent('채팅_받은호감_상세조회_수락버튼_취소');
                                                  Navigator.pop(modalContext, false);
                                                },
                                                child: Container(
                                                  height: SizeConfig.defaultSize * 4.5,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: Colors.grey.shade200,
                                                  ),
                                                  child: const Center(child: Text("취소")),
                                                ),
                                              ),
                                            ),
                                              SizedBox(width: SizeConfig.defaultSize,),
                                            GestureDetector(
                                              onTap: () {
                                                AnalyticsUtil.logEvent('채팅_받은호감_상세조회_수락버튼_수락');
                                                Navigator.pop(modalContext, true);
                                                showDialog<String>(
                                                    context: modalContext,
                                                    builder: (BuildContext dialogContext) {
                                                      context.read<ChatCubit>().acceptChatProposal(proposalId);
                                                      Future.delayed(const Duration(seconds: 2), () {
                                                        Navigator.pop(dialogContext);
                                                        Navigator.pop(contextTop);
                                                      });
                                                      return AlertDialog(
                                                        surfaceTintColor: Colors.white,
                                                        title: Container(alignment: Alignment.center, child: Text('호감이 성공적으로 수락됐어요!', style: TextStyle(fontSize: SizeConfig.defaultSize * 1.5, fontWeight: FontWeight.w600, color: const Color(0xffFF5C58)),)),
                                                        content: Container(alignment: Alignment.center, height: SizeConfig.defaultSize * 4, child: const Text('채팅방 목록을 확인하고 대화를 시작햬보세요!',)),
                                                      );
                                                    }
                                                );
                                              },
                                              child: Container(
                                                height: SizeConfig.defaultSize * 4.5,
                                                width: SizeConfig.defaultSize * 20,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: const Color(0xffFF5C58),
                                                ),
                                                child: const Center(child: Text("호감 수락하기", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),)),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    );
                                  });
                              },
                              child: Container(
                                width: SizeConfig.screenWidth * 0.63,
                                height: SizeConfig.defaultSize * 5.5,
                                decoration: BoxDecoration(
                                  color: const Color(0xffFE6059),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text("호감 수락하기", style: TextStyle(
                                    fontSize: SizeConfig.defaultSize * 2,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white
                                  ),)
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: SizeConfig.defaultSize * 2)
                      ],
                    ),
                  ),
                ),
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
                  Text("${(team.averageAge > 1000 ? 2023-team.averageAge+1 : team.averageAge).toStringAsFixed(1)}세", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.7),),
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
                // Text(team.universityName, style: TextStyle(
                //   fontSize: SizeConfig.defaultSize * 1.7,),
                // ),
                // Text("       "),
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
