import 'package:dart_flutter/res/config/size_config.dart';
import 'package:dart_flutter/src/common/util/analytics_util.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';
import 'package:dart_flutter/src/presentation/meet/view/meet_create_team.dart';
import 'package:dart_flutter/src/presentation/meet/view/meet_update_team.dart';
import 'package:dart_flutter/src/presentation/meet/viewmodel/meet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../viewmodel/state/meet_state.dart';

class MeetStandby extends StatelessWidget {
  const MeetStandby({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<MeetCubit>().initState();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<MeetCubit, MeetState>(
                builder: (context, state) {
                  return _TopSection(teams: state.teamCount, notifications: 123);
                }
              ),
                SizedBox(height: SizeConfig.defaultSize * 2,),
              Container(height: SizeConfig.defaultSize * 2, width: SizeConfig.screenWidth, color: Colors.grey.shade50,),
                SizedBox(height: SizeConfig.defaultSize * 2,),
              _MiddleSection(),
            ],
          ),
        ),
      ),
      bottomNavigationBar:
        BlocBuilder<MeetCubit, MeetState>(
          builder: (context,state) {
            List<User> filteredFriends = state.friends.where((friend) =>
            friend.university?.name == state.userResponse.university?.name &&
                friend.personalInfo?.gender == state.userResponse.personalInfo?.gender
            ).toList();

            return state.friends.isEmpty
                ? InviteFriendButton()
                : (filteredFriends.isEmpty ? MakeTeamButton() : _BottomSection(ancestorContext: context))
            ;
          }
        )

      // _BottomSection(ancestorContext: context),
      // If 친구가 없으면
      // ? 내 친구 초대하기
      // : if 같은 학교, 같은 성별 친구가 없으면 ? 팀 만들기 : _BottomSection
    );
  }
}

class MakeTeamButton extends StatelessWidget {
  const MakeTeamButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.defaultSize * 8.5,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 2, vertical: SizeConfig.defaultSize),
        child: GestureDetector(
          onTap: () async {
            await Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeftJoined, child: MeetCreateTeam(
              onFinish: () {
                // context.read<MeetCubit>().refreshMeetPage();
              },
              state: context.read<MeetCubit>().state,
            ), childCurrent: this)).then((value) async {
              if (value == null) return;
              await context.read<MeetCubit>().createNewTeam(value);
            });
            context.read<MeetCubit>().refreshMeetPage();
          },
          child: Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.defaultSize * 6,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                ),
                color: Color(0xffFE6059),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Text("과팅에 참여할 팀 만들기", style: TextStyle(
                  color: Colors.white,
                  fontSize: SizeConfig.defaultSize * 2,
                  fontWeight: FontWeight.w600
              ),)
          ),
        ),
      ),
    );
  }
}

class InviteFriendButton extends StatelessWidget { // 내 친구 초대하기
  const InviteFriendButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.defaultSize * 8.5,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 2, vertical: SizeConfig.defaultSize),
        child: GestureDetector(
          onTap: () {},
          child: Container(
            width: SizeConfig.screenWidth,
            height: SizeConfig.defaultSize * 6,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
              ),
              color: Color(0xffFE6059),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Text("과팅에 참여할 친구 초대하기", style: TextStyle(
              color: Colors.white,
              fontSize: SizeConfig.defaultSize * 2,
              fontWeight: FontWeight.w600
            ),)
          ),
        ),
      ),
    );
  }
}

class _BottomSection extends StatelessWidget {
  // MeetState state;
  BuildContext ancestorContext;

  _BottomSection({
    super.key,
    // required this.state,
    required this.ancestorContext
  });

  @override
  Widget build(BuildContext context) {
    // MeetState state = context.read<MeetCubit>().state;
    // MeetCubit cubit = BlocProvider.of<MeetCubit>(ancestorContext);

    return Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.defaultSize * 8.5,
      color: Colors.grey.shade50,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 2, vertical: SizeConfig.defaultSize),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector( // 내 팀 보기 버튼 *******
              onTap: () {
                AnalyticsUtil.logEvent("과팅_대기_내팀보기버튼_터치");
                if (context.read<MeetCubit>().state.isLoading) {
                  return;
                }
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext _) {
                    AnalyticsUtil.logEvent("과팅_대기_내팀보기_접속");
                    print(context.read<MeetCubit>().state.myTeams.toString());
                    print(context.read<MeetCubit>().state.myTeams.isEmpty);
                    // List<String> membersName = state.teamMembers.map((member) => member.personalInfo!.name).toList();
                    // String membersName = state.myTeams[i].members.map((member) => member.personalInfo!.name).join(', ');
                    return Container(
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.screenHeight,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 2.5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                width: SizeConfig.screenWidth,
                                height: SizeConfig.screenHeight * 0.05,
                                alignment: Alignment.center,
                                child: Container(
                                  width: SizeConfig.screenWidth * 0.17,
                                  height: SizeConfig.defaultSize * 0.3,
                                  color: Colors.grey,
                                )
                            ),
                              SizedBox(height: SizeConfig.defaultSize * 1.5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("내 과팅 팀", style: TextStyle(
                                  fontSize: SizeConfig.defaultSize * 2,
                                  fontWeight: FontWeight.w600
                                ),)
                              ],
                            ),
                              SizedBox(height: SizeConfig.defaultSize * 2,),
                            Expanded(
                              child: SingleChildScrollView(
                                  child: Column(
                                      children: [
                                        context.read<MeetCubit>().state.myTeams.isEmpty
                                            ? Text("아직 생성한 팀이 없어요!", style: TextStyle(
                                                fontSize: SizeConfig.defaultSize * 1.8,
                                                fontWeight: FontWeight.w400
                                              ))
                                            : Column(
                                                children: [
                                                  for (int i=0; i<context.read<MeetCubit>().state.myTeams.length; i++)
                                                    GestureDetector(
                                                      onTap: () {
                                                        AnalyticsUtil.logEvent("과팅_대기_내팀보기_내팀_터치", properties: {
                                                          "teamName": context.read<MeetCubit>().state.myTeams[i].name,
                                                          "members": context.read<MeetCubit>().state.myTeams[i].members.length,
                                                        });
                                                      },
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text(context.read<MeetCubit>().state.myTeams[i].name=='' ? '아직 팀명이 없어요!' : context.read<MeetCubit>().state.myTeams[i].name),
                                                          Row(
                                                            children: [
                                                              Text(context.read<MeetCubit>().state.myTeams[i].members.map((member) => member.personalInfo!.name).join(', ')),
                                                              PopupMenuButton<String>(
                                                                icon: Icon(Icons.more_horiz_rounded, color: Colors.grey.shade300,),
                                                                color: Colors.white,
                                                                surfaceTintColor: Colors.white,
                                                                onSelected: (value) {
                                                                  AnalyticsUtil.logEvent("과팅_대기_내팀보기_내팀_더보기_터치", properties: {
                                                                    "teamName": context.read<MeetCubit>().state.myTeams[i].name,
                                                                    "members": context.read<MeetCubit>().state.myTeams[i].members.length,
                                                                  });
                                                                  if (value == 'edit') {
                                                                    AnalyticsUtil.logEvent("과팅_대기_내팀보기_내팀_더보기_수정_터치", properties: {
                                                                      "teamName": context.read<MeetCubit>().state.myTeams[i].name,
                                                                      "members": context.read<MeetCubit>().state.myTeams[i].members.length,
                                                                    });
                                                                    // Navigator.push(state.myTeams[i]);
                                                                    Navigator.push(context, PageTransition(
                                                                        type: PageTransitionType.rightToLeftJoined,
                                                                        child: MeetUpdateTeam(
                                                                          onFinish: () {
                                                                            context.read<MeetCubit>().refreshMeetPage();
                                                                          },
                                                                          meetState: context.read<MeetCubit>().state,
                                                                        ),
                                                                        childCurrent: this));
                                                                  }

                                                                  //   Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeftJoined, child: MeetUpdateTeam(
                                                                  //     onFinish: () {
                                                                  //       cubit.refreshMeetPage();
                                                                  //     },
                                                                  //     myTeam: state.myTeams[i],
                                                                  //     user: state.userResponse,
                                                                  //   ), childCurrent: this));
                                                                  // }
                                                                  else if (value == 'delete') {
                                                                    AnalyticsUtil.logEvent("과팅_대기_내팀보기_내팀_더보기_삭제_터치", properties: {
                                                                      "teamName": context.read<MeetCubit>().state.myTeams[i].name,
                                                                      "members": context.read<MeetCubit>().state.myTeams[i].members.length,
                                                                    });
                                                                    showDialog<String>(
                                                                      context: context,
                                                                      builder: (BuildContext dialogContext) => AlertDialog(
                                                                        content: Text('\'${context.read<MeetCubit>().state.myTeams[i].name=='' ? '(팀명 없음)' : context.read<MeetCubit>().state.myTeams[i].name}\' 팀을 삭제하시겠어요?', style: TextStyle(fontSize: SizeConfig.defaultSize * 1.8),),
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
                                                                              await context.read<MeetCubit>().removeTeam(context.read<MeetCubit>().state.myTeams[i].id.toString());
                                                                              Navigator.pop(dialogContext);
                                                                              Navigator.pop(context);
                                                                              context.read<MeetCubit>().refreshMeetPage();
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
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                              ]),
                                      ],
                                  )
                              ),
                            ),
                            Text("팀 개수는 제한이 없어요!", style: TextStyle(
                              fontSize: SizeConfig.defaultSize * 1.5,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey.shade400
                            ),),
                            Text("다양한 친구들과 팀을 만들어보세요!", style: TextStyle(
                                fontSize: SizeConfig.defaultSize * 1.5,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade400
                            ),),
                              SizedBox(height: SizeConfig.defaultSize,),
                            GestureDetector(
                              onTap: () async {
                                AnalyticsUtil.logEvent("과팅_대기_팀만들기버튼_터치");
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
                                context.read<MeetCubit>().refreshMeetPage();
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: SizeConfig.defaultSize * 6,
                                width: SizeConfig.screenHeight,
                                decoration: BoxDecoration(
                                  color: Color(0xffFF5C58),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                alignment: Alignment.center,
                                child: Text("팀 만들기", style: TextStyle(
                                    color: Colors.white,
                                    fontSize: SizeConfig.defaultSize * 2,
                                    fontWeight: FontWeight.w600
                                )),
                              ),
                            ),
                              SizedBox(height: SizeConfig.defaultSize * 2,)
                          ],
                        ),
                      )
                    );
                    onFinish: () {
                      context.read<MeetCubit>().refreshMeetPage();
                    };
                });
              },
              child: Container(
                width: SizeConfig.screenWidth * 0.43,
                height: SizeConfig.defaultSize * 6,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Text("내 팀 보기", style: TextStyle(color: Color(0xffFE6059), fontSize: SizeConfig.defaultSize * 2, fontWeight: FontWeight.w600)),
              ),
            ),
            GestureDetector( // 팀 만들기 버튼 ********
              onTap: () async {
                await Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeftJoined, child: MeetCreateTeam(
                    onFinish: () {
                      // context.read<MeetCubit>().refreshMeetPage();
                    },
                  state: context.read<MeetCubit>().state,
                ), childCurrent: this)).then((value) async {
                  if (value == null) return;
                  await context.read<MeetCubit>().createNewTeam(value);
                });
                context.read<MeetCubit>().refreshMeetPage();
              },
              child: Container(
                width: SizeConfig.screenWidth * 0.43,
                height: SizeConfig.defaultSize * 6,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                  ),
                  color: Color(0xffFE6059),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Text("팀 만들기", style: TextStyle(color: Colors.white, fontSize: SizeConfig.defaultSize * 2, fontWeight: FontWeight.w600)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _TopSection extends StatefulWidget {
  late int teams;
  late int notifications;
  _TopSection({
    super.key,
    required this.teams,
    required this.notifications,
  });
  @override
  State<_TopSection> createState() => _TopSectionState();
}

class _TopSectionState extends State<_TopSection> with SingleTickerProviderStateMixin {
  bool light = true; // 스위치에 쓰임 TODO : 서버 연결
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );
    _animation = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    // 애니메이션을 반복 실행하도록 설정
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
            SizedBox(height: SizeConfig.defaultSize * 3,),
          Text("9월 과팅 오픈 예정", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: SizeConfig.defaultSize * 2.7)),
            SizedBox(height: SizeConfig.defaultSize * 0.5),
          Text("오픈 전, 미리 팀을 만들어보며 준비할 수 있어요!", style: TextStyle(color: Colors.grey.shade400, fontSize: SizeConfig.defaultSize * 1.4)),
            SizedBox(height: SizeConfig.defaultSize * 2),

          GestureDetector(
            onTap: () {
              AnalyticsUtil.logEvent("과팅_대기_하트_터치");
            },
            child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _animation.value,
                    child: Center(
                      child: Image.asset('assets/images/heart.png', width: SizeConfig.screenWidth * 0.65, height: SizeConfig.screenWidth * 0.65),
                    )
                  );
                }),
          ),

          Text("${widget.teams}", style: TextStyle(fontSize: SizeConfig.defaultSize * 2.3, fontWeight: FontWeight.w600, color: Color(0xffFF5C58)),),
            SizedBox(height: SizeConfig.defaultSize * 0.5),
          Text("지금까지 신청한 팀", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.6, fontWeight: FontWeight.w600),),
            SizedBox(height: SizeConfig.defaultSize * 2),

          if (false)  // 과팅 오픈 알림받기 기능 숨김
          Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 2.6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("과팅 오픈 알림받기 (${widget.notifications}명 대기중)", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.6),),
                Switch(
                  value: light,
                  activeColor: Color(0xffFE6059),
                  activeTrackColor: Color(0xffFE6059).withOpacity(0.2),
                  inactiveTrackColor: Colors.grey.shade200,
                  onChanged: (bool value) {
                    setState(() { light = value; });
                  },
                ),
              ],
            ),
          )
        ],
      )
    );
  }
}

class _MiddleSection extends StatelessWidget {
  const _MiddleSection({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(SizeConfig.defaultSize),
      child: Column(
        children: [
          Container(alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: SizeConfig.defaultSize * 1.3),
                child: Text("이전 시즌 후기", style: TextStyle(fontWeight: FontWeight.w600, fontSize: SizeConfig.defaultSize * 1.5),),
              )
          ),
            SizedBox(height: SizeConfig.defaultSize * 2),
          Container( // 후기1
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: SizeConfig.defaultSize * 1.3),
              child: Container(alignment: Alignment.center,
                width: SizeConfig.screenWidth * 0.8,
                  decoration: BoxDecoration(
                    color: Color(0xffFE6059).withOpacity(0.06),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15), bottomLeft: Radius.zero, bottomRight: Radius.circular(15)),
                  ),
                child: Padding(
                  padding: EdgeInsets.all(SizeConfig.defaultSize * 1.2),
                  child: Text("매칭 전에 간단하게 상대 팀 정보를 볼 수 있다는 게\n독특하고 신기했어요!", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.4),),
                )
              ),
            ),
          ),
            SizedBox(height: SizeConfig.defaultSize),
          Container( // 후기2
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(left: SizeConfig.defaultSize * 1.3),
              child: Container(alignment: Alignment.center,
                  width: SizeConfig.screenWidth * 0.8,
                  decoration: BoxDecoration(
                    color: Color(0xffFE6059).withOpacity(0.06),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15), bottomLeft: Radius.circular(15), bottomRight: Radius.zero),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(SizeConfig.defaultSize * 1.4),
                    child: Text("제가 프로필을 적은 양 만큼 관심도가 높아지는 것\n같아서 재밌었어요! 매칭도 성공했어요 :)", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.4)),
                  )
              ),
            ),
          ),
            SizedBox(height: SizeConfig.defaultSize),
          Container( // 후기3
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: SizeConfig.defaultSize * 1.3),
              child: Container(alignment: Alignment.center,
                  width: SizeConfig.screenWidth * 0.8,
                  decoration: BoxDecoration(
                    color: Color(0xffFE6059).withOpacity(0.06),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15), bottomLeft: Radius.zero, bottomRight: Radius.circular(15)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(SizeConfig.defaultSize * 1.2),
                    child: Text("팀 개수의 제한이나 매칭 횟수 제한이 없어서 좋아요!\n친구들이랑 과팅하면서 더 친해졌어요ㅎㅎ!", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.4),),
                  )
              ),
            ),
          ),
            SizedBox(height: SizeConfig.defaultSize * 4),

          Container(alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: SizeConfig.defaultSize * 1.3),
                child: Text("매칭 잘 되는 Tip", style: TextStyle(fontWeight: FontWeight.w600, fontSize: SizeConfig.defaultSize * 1.5),),
              )
          ),
            SizedBox(height: SizeConfig.defaultSize * 1.5),
          Container( // 매칭 잘 되는 팁
            alignment: Alignment.center,
            child: Container(alignment: Alignment.centerLeft,
                width: SizeConfig.screenWidth * 0.9,
                height: SizeConfig.defaultSize * 13,
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.all(Radius.circular(13)),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 1.5, vertical: SizeConfig.defaultSize * 1.5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(" ∙   ‘내정보' 탭에서 받은 투표 중 3개를 프로필에 넣어요!\n     이성에게 나를 더 어필할 수 있어요!", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.4),),
                      Text(" ∙   ‘내정보' 탭에서 프로필 사진을 추가해요!", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.4),),
                      Text(" ∙   과팅에 같이 참여하고 싶은 친구들을 초대해요!", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.4),),
                    ],
                  )
                )
            ),
          ),
        ],
      ),
    );
  }
}
