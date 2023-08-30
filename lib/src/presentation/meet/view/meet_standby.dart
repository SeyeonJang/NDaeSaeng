import 'package:dart_flutter/res/config/size_config.dart';
import 'package:dart_flutter/src/common/util/analytics_util.dart';
import 'package:dart_flutter/src/common/util/toast_util.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';
import 'package:dart_flutter/src/presentation/meet/view/meet_create_team.dart';
import 'package:dart_flutter/src/presentation/meet/view/meet_update_team.dart';
import 'package:dart_flutter/src/presentation/meet/viewmodel/meet_cubit.dart';
import 'package:dart_flutter/src/presentation/standby/standby_landing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

            return state.friends.isEmpty || filteredFriends.isEmpty
                ? InviteFriendButton(ancestorState: state,)
                : (state.teamCount == 0 ? MakeTeamButton() : _BottomSection(ancestorContext: context))
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

class InviteFriendButton extends StatefulWidget { // 내 친구 초대하기
  MeetState ancestorState;

  InviteFriendButton({
    super.key,
    required this.ancestorState,
  });

  @override
  State<InviteFriendButton> createState() => _InviteFriendButtonState();
}

class _InviteFriendButtonState extends State<InviteFriendButton> {
  @override
  Widget build(BuildContext context) {
    var friendCode = "";
    return Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.defaultSize * 8.5,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 2, vertical: SizeConfig.defaultSize),
        child: GestureDetector(
          onTap: () {
            showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                backgroundColor: Colors.white,
                isScrollControlled: true,
                builder: (BuildContext _) {
                  AnalyticsUtil.logEvent("대기_친추_접속");
                  return StatefulBuilder(
                    builder: (BuildContext statefulContext, StateSetter thisState) {
                      return Container(
                        width: SizeConfig.screenWidth,
                        height: SizeConfig.screenHeight * 0.8,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(SizeConfig.defaultSize),
                                    child: IconButton(
                                        onPressed: () {
                                          AnalyticsUtil.logEvent("대기_친추_닫기");
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(Icons.close_rounded, color: Colors.black, size: SizeConfig.defaultSize * 3,)),
                                  ),
                                ],
                              ),
                              SizedBox(height: SizeConfig.defaultSize * 2),
                              Text(
                                "친구를 추가해요!",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: SizeConfig.defaultSize * 2.5,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: SizeConfig.defaultSize * 1.5),
                              Text(
                                "친구 코드를 입력하면 내 친구로 추가할 수 있어요!",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: SizeConfig.defaultSize * 1.5,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: SizeConfig.defaultSize * 2),
                              SizedBox(
                                width: SizeConfig.defaultSize * 3,
                                height: SizeConfig.defaultSize * 3,
                                child: widget.ancestorState.isLoading ? const CircularProgressIndicator(color: Color(0xffFE6059)) : null,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: SizeConfig.defaultSize * 2, right: SizeConfig.defaultSize),
                                child: Container(
                                  // 친구 추가 버튼
                                  width: SizeConfig.screenWidth * 0.9,
                                  // height: SizeConfig.defaultSize * 9,
                                  // color: Colors.white,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.white
                                        // color: Color(0xff7C83FD),
                                      ),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("내 코드",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: SizeConfig.defaultSize * 2,
                                            fontWeight: FontWeight.w600,
                                          )),
                                      SizedBox(height: SizeConfig.defaultSize * 0.5,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            widget.ancestorState.userResponse.personalInfo?.recommendationCode ?? '내 코드가 없어요!',
                                            style: TextStyle(
                                              fontSize: SizeConfig.defaultSize * 1.9,
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              AnalyticsUtil.logEvent("대기_친추_내코드복사");
                                              String myCodeCopy = widget.ancestorState.userResponse.personalInfo?.recommendationCode ?? '내 코드 복사에 실패했어요🥲';
                                              Clipboard.setData(ClipboardData(
                                                  text:
                                                  myCodeCopy)); // 클립보드에 복사되었어요 <- 메시지 자동으로 Android에서 뜸 TODO : iOS는 확인하고 복사멘트 띄우기
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.white,
                                              onPrimary: Color(0xffFE6059),
                                              textStyle: TextStyle(
                                                color: Color(0xffFE6059),
                                              ),
                                              // backgroundColor: Color(0xff7C83FD),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(15), // 모서리 둥글기 설정
                                              ),
                                              surfaceTintColor: Colors.white,
                                            ),
                                            child: Text(
                                              "복사",
                                              style: TextStyle(
                                                fontSize: SizeConfig.defaultSize * 1.7,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: SizeConfig.defaultSize * 3.2),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("친구가 아직 엔대생에 가입하지 않았다면?",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: SizeConfig.defaultSize * 1.5,
                                        fontWeight: FontWeight.w500,
                                      )),
                                ],
                              ),
                              SizedBox(height: SizeConfig.defaultSize ,),
                              GestureDetector(
                                onTap: () {
                                  AnalyticsUtil.logEvent("대기_친추_링크공유");
                                  shareContent(context, widget.ancestorState.userResponse.personalInfo?.recommendationCode ?? '내 코드');
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(left: SizeConfig.defaultSize, right: SizeConfig.defaultSize),
                                  child: Container(
                                    // 친구 추가 버튼
                                    width: SizeConfig.screenWidth * 0.9,
                                    height: SizeConfig.defaultSize * 5.5,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Color(0xffFE6059),
                                        // color: Colors.white,
                                        border: Border.all(
                                          color: Color(0xffFE6059),
                                        ),
                                        borderRadius: BorderRadius.circular(15)),
                                    child: Text(
                                      "친구에게 링크 공유하기",
                                      style: TextStyle(
                                        fontSize: SizeConfig.defaultSize * 1.8,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white,
                                        // color: Color(0xff7C83FD),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: SizeConfig.defaultSize * 4),

                              Container(
                                  width: SizeConfig.screenWidth,
                                  height: SizeConfig.defaultSize * 2.5,
                                  color: Colors.grey.shade100
                              ),
                              SizedBox(height: SizeConfig.defaultSize * 3,),


                              Padding( // 친구추가
                                padding: EdgeInsets.only(left: SizeConfig.defaultSize, right: SizeConfig.defaultSize),
                                child: Container(
                                  width: SizeConfig.screenWidth * 0.9,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.white
                                      ),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: SizeConfig.defaultSize * 0.5),
                                        child: Text("친구 추가",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: SizeConfig.defaultSize * 2,
                                              fontWeight: FontWeight.w600,
                                            )),
                                      ),
                                      SizedBox(height: SizeConfig.defaultSize * 0.5),
                                      Padding(
                                        padding: EdgeInsets.only(left: SizeConfig.defaultSize * 0.5),
                                        child: Text("친구 4명을 추가하면 게임을 시작할 수 있어요!",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: SizeConfig.defaultSize * 1.5,
                                              fontWeight: FontWeight.w400,
                                            )),
                                      ),
                                      SizedBox(height: SizeConfig.defaultSize * 1.5),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: SizeConfig.screenWidth * 0.65,
                                            child: TextField(
                                              scrollPadding: EdgeInsets.only(bottom: SizeConfig.screenHeight * 0.4),
                                              onChanged: (text) {
                                                friendCode = text;
                                              },
                                              style: TextStyle(
                                                  fontSize: SizeConfig.defaultSize * 1.7
                                              ),
                                              autocorrect: true,
                                              decoration: InputDecoration(
                                                hintText: '친구 코드를 여기에 입력해주세요!',
                                                hintStyle: TextStyle(color: Colors.grey, fontSize: SizeConfig.defaultSize * 1.5),
                                                filled: true,
                                                fillColor: Colors.white,
                                                contentPadding: EdgeInsets.symmetric(
                                                    vertical: SizeConfig.defaultSize * 1.5, horizontal: SizeConfig.defaultSize * 1.5),
                                                enabledBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                                  borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                  borderSide: BorderSide(color: Color(0xffFE6059)),
                                                ),
                                              ),
                                            ),
                                          ),
                                          ElevatedButton( // 친구 추가 버튼
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: widget.ancestorState.isLoading ? Colors.grey.shade400 : Color(0xffFE6059),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(15), // 모서리 둥글기 설정
                                              ),
                                              padding: EdgeInsets.only(left: SizeConfig.defaultSize * 2.12, right: SizeConfig.defaultSize * 2.12),
                                            ),
                                            onPressed: () async {
                                              String friendCodeConfirm = "";
                                              // 친구추가 중인 경우 버튼 동작 X
                                              if (widget.ancestorState.isLoading) {
                                                return;
                                              }
                                              if (friendCode == widget.ancestorState.userResponse.personalInfo!.recommendationCode) {
                                                ToastUtil.itsMyCodeToast("나는 친구로 추가할 수 없어요!");
                                                friendCodeConfirm = "나";
                                              } else {
                                                print("friendCode $friendCode");
                                                try {
                                                  thisState(() {
                                                    setState(() {
                                                      widget.ancestorState.isLoading = true;
                                                    });
                                                  });

                                                  // 실제 친구 추가 동작
                                                  await BlocProvider.of<MeetCubit>(context).pressedFriendCodeAddButton(friendCode);
                                                  print(context.toString());

                                                  ToastUtil.showAddFriendToast("친구가 추가되었어요!");
                                                  friendCodeConfirm = "정상";
                                                  Navigator.pop(context);
                                                } catch (e) {
                                                  print(e);
                                                  ToastUtil.showToast('친구코드를 다시 한번 확인해주세요!');
                                                  friendCodeConfirm = "없거나 이미 친구임";
                                                }

                                                thisState(() {
                                                  setState(() {
                                                    widget.ancestorState.isLoading = false;
                                                  });
                                                });
                                                AnalyticsUtil.logEvent("대기_친추_친구코드_추가", properties: {
                                                  '친구코드 번호': friendCode, '친구코드 정상여부': friendCodeConfirm
                                                });
                                              }
                                            },
                                            child: Text("추가",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: SizeConfig.defaultSize * 1.7)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: SizeConfig.defaultSize * 3),

                              Padding(
                                // padding: const EdgeInsets.all(8.0),
                                padding: EdgeInsets.only(left: SizeConfig.defaultSize * 2.6, right: SizeConfig.defaultSize * 2),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("알 수도 있는 친구",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: SizeConfig.defaultSize * 1.9,
                                              color: Color(0xffFE6059)
                                          ),),
                                      ],
                                    ),
                                    SizedBox(height: SizeConfig.defaultSize * 1.5,),
                                    BlocProvider<MeetCubit>.value(
                                      value: BlocProvider.of<MeetCubit>(context),
                                      child: BlocBuilder<MeetCubit, MeetState>(
                                        builder: (friendContext, state) {
                                          final friends = state.newFriends;
                                          print("hihihihi");
                                          return NewFriends2(friends: friends.toList(), count: friends.length);
                                        },
                                      ),
                                    ),
                                    BlocProvider<MeetCubit>.value( // BlocProvider로 감싸기
                                      value: BlocProvider.of<MeetCubit>(context),
                                      child: BlocBuilder<MeetCubit, MeetState>(
                                        builder: (friendContext, state) {
                                          final friends = state.newFriends;
                                          return friends.length <= 2
                                              ? SizedBox(height: SizeConfig.screenHeight * 0.4,)
                                              : SizedBox(height: SizeConfig.defaultSize * 2,);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                });
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

class NewFriends2 extends StatelessWidget {
  final List<User> friends;
  final int count;

  const NewFriends2({
    super.key,
    required this.friends,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < count; i++)
          NotFriendComponent(true, friends[i]),
      ],
    );
  }
}
class NotFriendComponent extends StatelessWidget {
  late bool isAdd;
  late User friend;

  NotFriendComponent(bool isAdd, User friend, {super.key}) {
    this.isAdd = isAdd;
    this.friend = friend;
  }

  void pressedAddButton(BuildContext context, int userId) async {
    await BlocProvider.of<MeetCubit>(context).pressedFriendAddButton(friend);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: SizeConfig.defaultSize * 0.1,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                AnalyticsUtil.logEvent("대기_친추_알수도있는친구_목록터치", properties: {
                  "친구 성별": friend.personalInfo!.gender == "FEMALE"
                      ? "여자"
                      : "남자",
                  "친구 학번": friend.personalInfo!.admissionYear.toString()
                      .substring(2, 4),
                  "친구 학교": friend.university!.name,
                  "친구 학교코드": friend.university!.id,
                  "친구 학과": friend.university!.department
                });
              },
              child: Container(
                width: SizeConfig.screenWidth * 0.52,
                child: Row(
                  children: [
                    Text(friend.personalInfo?.name ?? "XXX", style: TextStyle(
                      fontSize: SizeConfig.defaultSize * 1.9,
                      fontWeight: FontWeight.w600,
                    )),
                    Flexible(
                      child: Container(
                        child: Text("  ${friend.personalInfo!.admissionYear
                            .toString().substring(2, 4)}학번∙${friend.university
                            ?.department}", style: TextStyle(
                          fontSize: SizeConfig.defaultSize * 1.3,
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis,
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: SizeConfig.defaultSize,),

            PopupMenuButton<String>(
              icon: Icon(
                Icons.more_horiz_rounded, color: Colors.grey.shade300,),
              color: Colors.white,
              surfaceTintColor: Colors.white,
              onSelected: (value) {
                // 팝업 메뉴에서 선택된 값 처리
                if (value == 'report') {
                  AnalyticsUtil.logEvent("대기_친추_알수도있는친구더보기_신고");
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) =>
                        AlertDialog(
                          backgroundColor: Colors.white,
                          surfaceTintColor: Colors.white,
                          title: const Text('사용자를 신고하시겠어요?'),
                          content: const Text(
                              '사용자를 신고하면 엔대생에서 빠르게 신고 처리를 해드려요!'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                AnalyticsUtil.logEvent(
                                    "대기_친추_알수도있는친구더보기_신고_취소");
                                Navigator.pop(context, '취소');
                              },
                              child: const Text('취소', style: TextStyle(
                                  color: Color(0xffFE6059)),),
                            ),
                            TextButton(
                              onPressed: () =>
                              {
                                AnalyticsUtil.logEvent(
                                    "대기_친추_알수도있는친구더보기_신고_신고확정"),
                                Navigator.pop(context, '신고'),
                                ToastUtil.showToast("사용자가 신고되었어요!"),
                                // TODO : 신고 기능 (서버 연결)
                              },
                              child: const Text('신고', style: TextStyle(
                                  color: Color(0xffFE6059)),),
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
                    child: Text("신고하기", style: TextStyle(
                        fontSize: SizeConfig.defaultSize * 1.5)),
                  ),
                ];
              },
            ),

            ElevatedButton(
              onPressed: () {
                AnalyticsUtil.logEvent("대기_친추_알수도있는친구_친구추가");
                if (isAdd) {
                  pressedAddButton(context, friend.personalInfo!.id);
                  // Navigator.pop(context);
                }
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffFE6059),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // 모서리 둥글기 설정
                ),
              ),
              child: Text(isAdd ? "추가" : "삭제", style: TextStyle(
                fontSize: SizeConfig.defaultSize * 1.5,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              )),
            ),
          ],
        ),
        SizedBox(height: SizeConfig.defaultSize * 0.1,),
        Divider(
          color: Color(0xffddddddd),
        ),
      ],
    );
  }
}