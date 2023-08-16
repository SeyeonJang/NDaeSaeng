import 'package:dart_flutter/res/config/size_config.dart';
import 'package:dart_flutter/src/presentation/meet/viewmodel/meet_cubit.dart';
import 'package:dart_flutter/src/presentation/meet/viewmodel/state/meet_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';

class MeetCreateTeam extends StatelessWidget {
  const MeetCreateTeam({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider<MeetCubit>(
          create: (context) => MeetCubit(),
          child: SafeArea(
            child: BlocBuilder<MeetCubit, MeetState>(
                builder: (context, state) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.all(SizeConfig.defaultSize * 1.3),
                      child: Column(
                        children: [
                            SizedBox(height: SizeConfig.defaultSize),
                          Row(mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(Icons.arrow_back_ios_new_rounded,
                                        size: SizeConfig.defaultSize * 2)),
                                Text("과팅 팀 만들기",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: SizeConfig.defaultSize * 2,
                                    )),
                              ]),
                            SizedBox(height: SizeConfig.defaultSize * 2.5),
                          Flexible(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 1.3),
                                child: Column(
                                  children: [
                                    _CreateTeamTopSection(userResponse: state.userResponse),
                                    // 나
                                    _MemberCardView(userResponse: state.userResponse,),
                                    // 친구1
                                    state.isMemberOneAdded
                                        ? _MemberCardView(userResponse: state.userResponse,)
                                        : Container(),
                                    // 친구2
                                    state.isMemberTwoAdded
                                        ? _MemberCardView(userResponse: state.userResponse,)
                                        : Container(),
                                    // 버튼
                                    state.isMemberTwoAdded
                                        ? Container()
                                        : InkWell( // TODO : 친구 두 명이면 안보이기
                                            onTap: () {
                                              showModalBottomSheet(
                                                context: context,
                                                builder: (BuildContext _) {
                                                  return Container(
                                                    width: SizeConfig.screenWidth,
                                                    height: SizeConfig.screenHeight,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
                                                  );
                                                }
                                              );
                                              context.read<MeetCubit>().pressedMemberAddButton();
                                            },
                                            child: Container(
                                              width: SizeConfig.screenWidth,
                                              height: SizeConfig.defaultSize * 6,
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade100,
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              alignment: Alignment.center,
                                              child: Text("+   팀원 추가하기", style: TextStyle(
                                                  fontSize: SizeConfig.defaultSize * 1.6
                                              ),)
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
            ),
          )
      ),
        bottomNavigationBar: BlocProvider<MeetCubit>(
          create: (context) => MeetCubit(),
          child: _CreateTeamBottomSection()
        )
      );
  }
}

class _CreateTeamTopSection extends StatefulWidget {
  User userResponse;

  _CreateTeamTopSection({
    super.key,
    required this.userResponse
  });

  @override
  State<_CreateTeamTopSection> createState() => _CreateTeamTopSectionState();
}

class _CreateTeamTopSectionState extends State<_CreateTeamTopSection> {
  // textfield
  late TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Row(children: [
              Text("학교",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: SizeConfig.defaultSize * 1.6,
                      color: Colors.grey
                  )),
              SizedBox(width: SizeConfig.defaultSize,),
              Text("${widget.userResponse.university}",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: SizeConfig.defaultSize * 1.6,
                      color: Colors.grey
                  ))
            ]),
              SizedBox(height: SizeConfig.defaultSize * 0.5),
            Row(children: [
              Text("팀명",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: SizeConfig.defaultSize * 1.6,
                      color: Colors.black
                  )),
              SizedBox(width: SizeConfig.defaultSize,),
              Flexible(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "이성에게 보여질 팀명을 입력해주세요!",
                    ),
                  )
              )
            ]),
          ],
        )
      ],
    );
  }
}

class _MemberCardView extends StatelessWidget {
  late User userResponse;

  _MemberCardView({
    super.key,
    required this.userResponse,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SizeConfig.defaultSize * 0.8),
      child: Container( // 카드뷰 시작 *****************
        width: SizeConfig.screenWidth,
        height: SizeConfig.defaultSize * 21.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Color(0xffFF5C58),
            width: 1.5
          )
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: SizeConfig.defaultSize * 1.2, horizontal: SizeConfig.defaultSize * 1.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row( // 위층 (받은 투표 위까지)
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      // AnalyticsUtil.logEvent("내정보_마이_내사진터치");
                    },
                    child: ClipOval(
                        child: Image.asset('assets/images/profile1.jpeg', width: SizeConfig.defaultSize * 6.4, fit: BoxFit.cover,) // TODO : null값이면 이거
                        // child: BlocBuilder<MyPagesCubit, MyPagesState>(
                        //     builder: (context, state) {
                        //       if (profileImageUrl == "DEFAULT")
                        //         return Image.asset('assets/images/profile-mockup3.png', width: SizeConfig.defaultSize * 5.7, fit: BoxFit.cover,);
                        //       else {
                        //         return state.profileImageFile.path==''
                        //             ? Image.network(profileImageUrl,
                        //             width: SizeConfig.defaultSize * 5.7,
                        //             height: SizeConfig.defaultSize * 5.7,
                        //             fit: BoxFit.cover)
                        //             : Image.file(state.profileImageFile,
                        //             width: SizeConfig.defaultSize * 5.7,
                        //             height: SizeConfig.defaultSize * 5.7,
                        //             fit: BoxFit.cover);
                        //       }
                        //     }
                        // )
                    ),
                  ),
                  SizedBox(width: SizeConfig.defaultSize * 0.8),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row( // 1층
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                                children: [
                                    SizedBox(width: SizeConfig.defaultSize * 0.5,),
                                  Text(
                                    userResponse.personalInfo?.nickname ?? "닉네임", // TODO : 닉네임 null값 '닉네임'으로 변경
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: SizeConfig.defaultSize * 1.6,
                                      color: Colors.black,
                                    ),),
                                  // if (userResponse.personalInfo!.verification.isVerificationSuccess) // TODO : 서버 연결 후 인증배지 다시
                                    SizedBox(width: SizeConfig.defaultSize * 0.3),
                                  Image.asset("assets/images/check.png", width: SizeConfig.defaultSize * 1.3),
                                    SizedBox(width: SizeConfig.defaultSize * 0.5),
                                  Text(
                                    "∙ ${userResponse.personalInfo?.birthYear.toString().substring(2,4)??"??"}년생",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: SizeConfig.defaultSize * 1.6,
                                      color: Colors.black,
                                    ),),
                                ]
                            ),
                          ],
                        ),
                        Row( // 2층
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                  SizedBox(width: SizeConfig.defaultSize * 0.5,),
                                Text(
                                  userResponse.university?.department ?? "컴퓨터정보공학부", // TODO : 학과 길면 ... 처리
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: SizeConfig.defaultSize * 1.6,
                                      color: Colors.black
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // TODO : 받은 투표가 있다면 VoteView, 없으면 다른 View
              Container(
                height: SizeConfig.defaultSize * 11.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _NoVoteView(),
                    _NoVoteView(),
                    _NoVoteView(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _VoteView extends StatelessWidget { // 받은 투표 있을 때
  const _VoteView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.defaultSize * 3.5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color(0xffFF5C58)
      ),
    );
  }
}

class _NoVoteView extends StatelessWidget { // 받은 투표 없을 때
  const _NoVoteView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.defaultSize * 3.5,
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Text("내정보 탭에서 받은 투표를 프로필로 넣어보세요!", style: TextStyle(
        color: Color(0xffFF5C58),
        fontSize: SizeConfig.defaultSize * 1.3
      ),)
    );
  }
}

class _CreateTeamBottomSection extends StatelessWidget {
  const _CreateTeamBottomSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: SizeConfig.defaultSize * 19,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(0),
            border: Border.all(
              color: Color(0xffeeeeee),
            )
        ),
        child: Padding(
          padding: EdgeInsets.all(SizeConfig.defaultSize * 1.8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 0.2),
                child: Row( // 만나고싶은지역 Row ********
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("만나고 싶은 지역", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.6),),
                    Text("선택해주세요", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.6),)
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 0.2),
                child: Row( // 학교 사람들에게 보이지 않기 Row ********
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("우리 학교 사람들에게 보이지 않기", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.6),),
                    Text("스위치", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.6),)
                  ],
                ),
              ),
              Container( // TODO : 위에꺼 다 선택해야 활성화되도록 만들기 (팀명 && 팀원 추가)
                height: SizeConfig.defaultSize * 6,
                width: SizeConfig.screenHeight,
                decoration: BoxDecoration(
                    color: Color(0xffFF5C58) ,
                    borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text("팀 만들기", style: TextStyle(
                  color: Colors.white,
                  fontSize: SizeConfig.defaultSize * 2,
                  fontWeight: FontWeight.w600
                )),
              )
            ],
          ),
        )
    );
  }
}