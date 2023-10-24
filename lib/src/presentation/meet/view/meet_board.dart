import 'package:dart_flutter/res/config/size_config.dart';
import 'package:dart_flutter/src/common/util/analytics_util.dart';
import 'package:dart_flutter/src/common/util/toast_util.dart';
import 'package:dart_flutter/src/domain/entity/blind_date_team.dart';
import 'package:dart_flutter/src/domain/entity/location.dart';
import 'package:dart_flutter/src/presentation/meet/view/meet_create_team.dart';
import 'package:dart_flutter/src/presentation/component/meet_one_team_cardview.dart';
import 'package:dart_flutter/src/presentation/meet/viewmodel/meet_cubit.dart';
import 'package:dart_flutter/src/presentation/meet/viewmodel/state/meet_state.dart';
import 'package:dart_flutter/src/presentation/standby/standby_landing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';
import '../../../domain/entity/meet_team.dart';

const List<String> list = <String>['최신순', '호감순', '조회순'];

class MeetBoard extends StatefulWidget {
  BuildContext ancestorContext;

  MeetBoard({super.key, required this.ancestorContext});

  @override
  State<MeetBoard> createState() => _MeetBoardState();
}

class _MeetBoardState extends State<MeetBoard> {
  late MeetCubit meetCubit;
  // late PagingController<int, BlindDateTeam> pagingControllerRecent;
  late List<PagingController<int, BlindDateTeam>> pagingControllers;
  int selected = 0;
  int targetLocation = 0;
  bool targetCertificated = false;
  bool targetProfileImage = false;

  void onPageRequested(int pageKey) {
    if (mounted) {
      meetCubit.fetchPage(pageKey, targetLocation, targetCertificated, targetProfileImage);
    }
  }
  void onPageRequestedLike(int pageKey) {
    if (mounted) {
      meetCubit.fetchPageMostLiked(pageKey, targetLocation, targetCertificated, targetProfileImage);
    }
  }
  void onPageRequestedSeen(int pageKey) {
    if (mounted) {
      meetCubit.fetchPageMostSeen(pageKey, targetLocation, targetCertificated, targetProfileImage);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    meetCubit = widget.ancestorContext.read<MeetCubit>();
  }

  @override
  void initState() {
    super.initState();
    meetCubit = widget.ancestorContext.read<MeetCubit>();
    pagingControllers = [
      meetCubit.pagingControllerRecent,
      meetCubit.pagingControllerLike,
      meetCubit.pagingControllerSeen
    ];
    // pagingControllerRecent = meetCubit.pagingControllerRecent;

    if (mounted) {
      pagingControllers[0].addPageRequestListener(onPageRequested);
      pagingControllers[1].addPageRequestListener(onPageRequestedLike);
      pagingControllers[2].addPageRequestListener(onPageRequestedSeen);
      // pagingControllerRecent.addPageRequestListener(onPageRequested);
      SchedulerBinding.instance.addPostFrameCallback((_) => meetCubit.initMeet());
    }
  }

  @override
  void dispose() {
    pagingControllers[0].removePageRequestListener(onPageRequested);
    pagingControllers[1].removePageRequestListener(onPageRequestedLike);
    pagingControllers[2].removePageRequestListener(onPageRequestedSeen);
    // pagingControllerRecent.removePageRequestListener(onPageRequested);
    super.dispose();
  }

  void onSortChanged(int index) {
    if (selected != index) {
      setState(() {
        selected = index;
      });
      if (selected == 1) {
        pagingControllers[1].refresh();
        meetCubit.fetchPageMostLiked(0, targetLocation, targetCertificated, targetProfileImage);
      }
      if (selected == 2) {
        pagingControllers[2].refresh();
        meetCubit.fetchPageMostSeen(0, targetLocation, targetCertificated, targetProfileImage);
      }
    }
    print('selected : $selected');
  }

  void onFilterChanged(int location, int certificated, int profile) {
    bool certificatedBool = certificated == 0 ? false : true;
    bool profileBool = profile == 0 ? false : true;

    if (targetLocation != location) {
      setState(() {
        targetLocation = location;
      });
    }
    if (targetCertificated != certificatedBool) {
      setState(() {
        targetCertificated = certificatedBool;
      });
    }
    if (targetProfileImage != profileBool) {
      setState(() {
        targetProfileImage = profileBool;
      });
    }

    if (selected == 0) {
      pagingControllers[0].refresh();
    } else if (selected == 1) {
      pagingControllers[1].refresh();
    } else if (selected == 2) {
      pagingControllers[2].refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    // List<User> filteredFriends = state.friends.where((friend) =>
    // friend.university?.name == state.userResponse.university?.name &&
    //     friend.personalInfo?.gender == state.userResponse.personalInfo?.gender
    // ).toList();
    // print("친구 수 : ${state.friends.length}, 과팅 같이 나갈 수 있는 친구 수 : ${filteredFriends.length}, 팀 개수 : ${state.myTeams.length}");
    MeetState state = meetCubit.state;
    return (state.isLoading)
        ? Scaffold(
          appBar: AppBar(),
          body: Container(
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(color: Color(0xffFE6059)),
                SizedBox(height: SizeConfig.defaultSize * 5,),
                Text("이성 팀을 불러오고 있어요 . . . 🥰", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.8),)
              ],
            ),
          ),
        )

        // // 아직 팀을 생성하지 않은 경우에 볼 수 없다는 멘트가 나오던 페이지
        //   : state.myTeams.isEmpty
        // ? Scaffold(
        //     appBar: AppBar(),
        //     body: GestureDetector(
        //       onTap: () {
        //         AnalyticsUtil.logEvent('과팅_목록_팀없을때_화면터치');
        //       },
        //       child: Container(
        //         width: SizeConfig.screenWidth,
        //         height: SizeConfig.screenHeight,
        //         color: Colors.white,
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             Image.asset('assets/images/heart.png', width: SizeConfig.screenWidth * 0.7,),
        //             SizedBox(height: SizeConfig.defaultSize * 7,),
        //             Text("팀을 만들어야 이성을 볼 수 있어요! 👀", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.8),),
        //             SizedBox(height: SizeConfig.defaultSize * 1.5,),
        //             Text("왼쪽 홈에서 간단하게 팀을 만들어보아요!", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.5),),
        //             SizedBox(height: SizeConfig.defaultSize * 10,),
        //           ],
        //         ),
        //       ),
        //     ),
        //   )

        : Scaffold(
          backgroundColor: Colors.grey.shade200.withOpacity(0.7),

          // TODO : 팀 바꾸거나 CTA 버튼 필요할 때 복구하기
          // appBar: AppBar(
          //   toolbarHeight: SizeConfig.defaultSize * 8.5,
          //   backgroundColor: Colors.white,
          //   surfaceTintColor: Colors.white,
          //   title: state.friends.isEmpty || filteredFriends.isEmpty
          //     ? _TopSectionInviteFriend(meetState: state,)
          //     : (state.myTeams.length == 0 ? _TopSectionMakeTeam(meetState: state, ancestorContext: context,) : _TopSection(ancestorState: state, context: context,)),
          // ),

          body: _BodySection(meetState: state, context: context, pagingController: pagingControllers[selected], onSortChanged: onSortChanged, onFilterChanged: onFilterChanged),

          // TODO : FloatingActionButton 팀 생성 재개할 때 복구하기
          // floatingActionButton: filteredFriends.isNotEmpty
          //     ? FloatingActionButton(
          //         onPressed: () async {
          //           // AnalyticsUtil.logEvent("과팅_목록_팀만들기_플로팅버튼_터치");
          //           if (state.isLoading) {
          //             ToastUtil.showMeetToast("다시 터치해주세요!", 2);
          //             return;
          //           }
          //           final meetCubit = context.read<MeetCubit>(); // MeetCubit 인스턴스 가져오기
          //           await Navigator.push(context,
          //               MaterialPageRoute(
          //                 builder: (context) => BlocProvider<MeetCubit>(
          //                   create: (_) => MeetCubit(),
          //                   child: MeetCreateTeam(
          //                     onFinish: () { meetCubit.refreshMeetPage(); },
          //                     state: meetCubit.state
          //                   ),
          //                 ),
          //               ))
          //               .then((value) async {
          //                   if (value == null) return;
          //                   await meetCubit.createNewTeam(value);
          //               });
          //           meetCubit.initMeet();
          //           Navigator.pop(context);
          //         },
          //         shape: CircleBorder(),
          //         child: Icon(Icons.add_rounded),
          //         backgroundColor: const Color(0xffFE6059),
          //       )
          //       : null,
    );
  }
}

class _TopSectionMakeTeam extends StatelessWidget { // 팀 X 과팅 나갈 친구 O
  final MeetState meetState;
  final BuildContext ancestorContext;

  _TopSectionMakeTeam({
    super.key,
    required this.meetState,
    required this.ancestorContext
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text("팀 생성 무제한 무료! 지금 바로 팀을 만들 수 있어요!", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.4),),
            SizedBox(height: SizeConfig.defaultSize * 0.5,),
          GestureDetector(
            onTap: () async {
              if (meetState.isLoading) {
                ToastUtil.showMeetToast("다시 터치해주세요!", 2);
                return;
              }
              final meetCubit = ancestorContext.read<MeetCubit>(); // MeetCubit 인스턴스 가져오기
              await Navigator.push(ancestorContext,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider<MeetCubit>(
                      create: (_) => MeetCubit(),
                      child: MeetCreateTeam(
                          onFinish: () { meetCubit.refreshMeetPage(); },
                          state: meetCubit.state
                      ),
                    ),
                  ))
                  .then((value) async {
                if (value == null) return;
                await meetCubit.createNewTeam(value);
              });
              meetCubit.initMeet();
              Navigator.pop(ancestorContext);
            },
            child: Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.defaultSize * 5,
              decoration: BoxDecoration(
                color: const Color(0xffFE6059),
                borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text("우리 학교 친구와 과팅 팀 만들기", style: TextStyle(
                  fontSize: SizeConfig.defaultSize * 1.9,
                  color: Colors.white,
                  fontWeight: FontWeight.w600
                ),),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _TopSectionInviteFriend extends StatefulWidget { // 친구 O/X, 과팅 나갈 친구 X
 final MeetState meetState;

  _TopSectionInviteFriend({
    super.key,
    required this.meetState
  });

  @override
  State<_TopSectionInviteFriend> createState() => _TopSectionInviteFriendState();
}

class _TopSectionInviteFriendState extends State<_TopSectionInviteFriend> {
  @override
  Widget build(BuildContext context) {
    var friendCode = "";
    return Center(
      child: Column(
        children: [
          Text("친구 1명만 초대해도 바로 팀을 만들 수 있어요!", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.4),),
          SizedBox(height: SizeConfig.defaultSize * 0.5,),
          GestureDetector(
            onTap: () {
              // AnalyticsUtil.logEvent('과팅_대기_친추버튼');
              showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  backgroundColor: Colors.white,
                  isScrollControlled: true,
                  builder: (BuildContext _) {
                    // AnalyticsUtil.logEvent("과팅_대기_친추_접속");
                    return StatefulBuilder(
                      builder: (BuildContext statefulContext, StateSetter thisState) {
                        return Container(
                          width: SizeConfig.screenWidth,
                          height: SizeConfig.screenHeight * 0.8,
                          decoration: const BoxDecoration(
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
                                            // AnalyticsUtil.logEvent("과팅_대기_친추_닫기");
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
                                  child: widget.meetState.isLoading ? const CircularProgressIndicator(color: Color(0xffFE6059)) : null,
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
                                              widget.meetState.userResponse.personalInfo?.recommendationCode ?? '내 코드가 없어요!',
                                              style: TextStyle(
                                                fontSize: SizeConfig.defaultSize * 1.9,
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                AnalyticsUtil.logEvent("과팅_대기_친추_내코드복사");
                                                String myCodeCopy = widget.meetState.userResponse.personalInfo?.recommendationCode ?? '내 코드 복사에 실패했어요🥲';
                                                Clipboard.setData(ClipboardData(
                                                    text:
                                                    myCodeCopy)); // 클립보드에 복사되었어요 <- 메시지 자동으로 Android에서 뜸 TODO : iOS는 확인하고 복사멘트 띄우기
                                              },
                                              style: ElevatedButton.styleFrom(
                                                textStyle: const TextStyle(
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
                                    AnalyticsUtil.logEvent("과팅_대기_친추_링크공유");
                                    shareContent(context, widget.meetState.userResponse.personalInfo?.recommendationCode ?? '내 코드');
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(left: SizeConfig.defaultSize, right: SizeConfig.defaultSize),
                                    child: Container(
                                      // 친구 추가 버튼
                                      width: SizeConfig.screenWidth * 0.9,
                                      height: SizeConfig.defaultSize * 5.5,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: const Color(0xffFE6059),
                                          // color: Colors.white,
                                          border: Border.all(
                                            color: const Color(0xffFE6059),
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
                                                    borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                                                    borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
                                                  ),
                                                  focusedBorder: const OutlineInputBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                    borderSide: BorderSide(color: Color(0xffFE6059)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            ElevatedButton( // 친구 추가 버튼
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: widget.meetState.isLoading ? Colors.grey.shade400 : const Color(0xffFE6059),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(15), // 모서리 둥글기 설정
                                                ),
                                                padding: EdgeInsets.only(left: SizeConfig.defaultSize * 2.12, right: SizeConfig.defaultSize * 2.12),
                                              ),
                                              onPressed: () async {
                                                String friendCodeConfirm = "";
                                                // 친구추가 중인 경우 버튼 동작 X
                                                if (widget.meetState.isLoading) {
                                                  return;
                                                }
                                                if (friendCode == widget.meetState.userResponse.personalInfo!.recommendationCode) {
                                                  ToastUtil.itsMyCodeToast("나는 친구로 추가할 수 없어요!");
                                                  friendCodeConfirm = "나";
                                                } else {
                                                  try {
                                                    thisState(() {
                                                      setState(() {
                                                        widget.meetState.isLoading = true;
                                                      });
                                                    });

                                                    // 실제 친구 추가 동작
                                                    await BlocProvider.of<MeetCubit>(context).pressedFriendCodeAddButton(friendCode);
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
                                                      widget.meetState.isLoading = false;
                                                    });
                                                  });
                                                  AnalyticsUtil.logEvent("과팅_대기_친추_친구코드_추가", properties: {
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
                                                color: const Color(0xffFE6059)
                                            ),),
                                        ],
                                      ),
                                      SizedBox(height: SizeConfig.defaultSize * 1.5,),
                                      BlocProvider<MeetCubit>.value(
                                        value: BlocProvider.of<MeetCubit>(context),
                                        child: BlocBuilder<MeetCubit, MeetState>(
                                          builder: (friendContext, state) {
                                            final friends = state.newFriends;
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
              height: SizeConfig.defaultSize * 5,
              decoration: BoxDecoration(
                  color: const Color(0xffFE6059),
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text("한 명 초대하고 10초만에 과팅 등록하기", style: TextStyle(
                    fontSize: SizeConfig.defaultSize * 1.9,
                    color: Colors.white,
                    fontWeight: FontWeight.w600
                ),),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _BodySection extends StatefulWidget {
  final MeetState meetState;
  final BuildContext context;
  PagingController<int, BlindDateTeam> pagingController;
  final Function(int) onSortChanged;
  final Function(int,int,int) onFilterChanged;

  _BodySection({
    super.key,
    required this.meetState,
    required this.context,
    required this.pagingController,
    required this.onSortChanged,
    required this.onFilterChanged
  });

  @override
  State<_BodySection> createState() => _BodySectionState();
}

class _BodySectionState extends State<_BodySection> {
  final ScrollController _scrollController = ScrollController();
  late MeetTeam nowTeam = widget.meetState.myTeam ?? (widget.meetState.myTeams.firstOrNull ?? MeetTeam(id: 0, name: '', university: null, locations: [], canMatchWithSameUniversity: true, members: []));
  String dropdownValue = list.first;
  int certificated = 0;
  int profileImage = 0;
  int location = 0;
  int selectedChipCertificated = 0; // 0: 선택 안 함, 1: 인증 완료한 팀
  int selectedChipProfileImage = 0;
  int selectedChipLocation = 0;

  void onClickSortButton(int selected) {
    setState(() {
      widget.onSortChanged(selected);
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      // 아래로 스크롤할 때 실행되는 콜백 함수
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        // 스크롤이 가장 아래에 도달하면 아래 방향 새로 고침 실행
        widget.pagingController.refresh();
      }
    });
    Location allLocation = Location(id: 0, name: '전지역');
    widget.meetState.serverLocations.insert(0, allLocation);
  }

  BlindDateTeam makeTeam() {
    BlindDateTeam blindDateTeam = BlindDateTeam(
        id: nowTeam.getId(),
        name: nowTeam.getName(),
        averageBirthYear: nowTeam.getAverageAge(),
        regions: nowTeam.getRegions(),
        universityName: nowTeam.getUniversityName(),
        isCertifiedTeam: nowTeam.getIsCertifiedTeam(),
        teamUsers: nowTeam.getTeamUsers()
    );
    return blindDateTeam;
  }

  @override
  Widget build(BuildContext context) {
    print("현재 pagingController : ${widget.pagingController}");
    return RefreshIndicator(
      onRefresh: () async {
        context.read<MeetCubit>().initMeet();
      },
      child: Column(
        children: [
          // TODO : 내 팀 보여주고 싶을 때 복구하기
          // if (widget.meetState.myTeams.length > 0) // MyTeam
          //   Padding(
          //     padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 1),
          //     child: MeetOneTeamCardview(
          //       team: makeTeam(),
          //       isMyTeam: true,
          //       myTeamCount: widget.meetState.myTeams.length,),
          //   ),
          Container(
            width: SizeConfig.screenWidth,
            height: SizeConfig.defaultSize * 5,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.only(right: SizeConfig.defaultSize * 2, bottom: SizeConfig.defaultSize, top: SizeConfig.defaultSize),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      AnalyticsUtil.logEvent("과팅_목록_필터링_터치");
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.white,
                        isScrollControlled: true,
                        builder: (BuildContext _) {
                          selectedChipLocation = location;
                          selectedChipCertificated = certificated;
                          selectedChipProfileImage = profileImage;
                          AnalyticsUtil.logEvent("과팅_목록_필터링_접속"); // TODO : build 계속 해서 자꾸 0으로 초기화되고 이거 찍히는데 왜그런지 확인하기
                          return StatefulBuilder(
                            builder: (BuildContext statefulContext, StateSetter thisState) {
                              ChoiceChip chipGroupLocation(String label, int index) {
                                return ChoiceChip(
                                  label: Text(label),
                                  selected: selectedChipLocation == index,
                                  onSelected: (selected) {
                                    thisState(() {
                                      selectedChipLocation = selected ? index : 0;
                                    });
                                    AnalyticsUtil.logEvent('과팅_목록_필터링_지역선택', properties: {
                                      '지역번호' : index
                                    });
                                  },
                                  selectedColor: const Color(0xffFE6059),
                                  backgroundColor: Colors.grey.shade200,
                                  labelStyle: TextStyle(
                                    color: selectedChipLocation == index ? Colors.white : Colors.black,
                                  ),
                                );
                              }
                              ChoiceChip chipGroupCertificated(String label, int index) {
                                return ChoiceChip(
                                  label: Text(label),
                                  selected: selectedChipCertificated == index,
                                  onSelected: (selected) {
                                    thisState(() {
                                      selectedChipCertificated = selected ? index : 0;
                                    });
                                    AnalyticsUtil.logEvent('과팅_목록_필터링_학생증선택', properties: {
                                      '선택' : selectedChipCertificated == 1 ? '인증 완료한 팀만' : '선택 안 함'
                                    });
                                  },
                                  selectedColor: const Color(0xffFE6059),
                                  backgroundColor: Colors.grey.shade200,
                                  labelStyle: TextStyle(
                                    color: selectedChipCertificated == index ? Colors.white : Colors.black,
                                  ),
                                );
                              }
                              ChoiceChip chipGroupProfileImage(String label, int index) {
                                return ChoiceChip(
                                  label: Text(label),
                                  selected: selectedChipProfileImage == index,
                                  onSelected: (selected) {
                                    thisState(() {
                                      selectedChipProfileImage = selected ? index : 0;
                                    });
                                    AnalyticsUtil.logEvent('과팅_목록_필터링_프로필사진선택', properties: {
                                      '선택' : selectedChipProfileImage == 1 ? '사진 있는 팀만' : '선택 안 함'
                                    });
                                  },
                                  selectedColor: const Color(0xffFE6059),
                                  backgroundColor: Colors.grey.shade200,
                                  labelStyle: TextStyle(
                                    color: selectedChipProfileImage == index ? Colors.white : Colors.black,
                                  ),
                                );
                              }

                              return Container(
                                width: SizeConfig.screenWidth,
                                height: SizeConfig.screenHeight * 0.85,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: SizeConfig.defaultSize * 2),
                                      child: Center(
                                        child: Container(
                                          width: SizeConfig.screenWidth * 0.2,
                                          height: SizeConfig.defaultSize * 0.3,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(SizeConfig.defaultSize * 2.5),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(top: SizeConfig.defaultSize),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 25),
                                                  child: Text("필터링", style: TextStyle(
                                                    fontSize: SizeConfig.defaultSize * 2,
                                                    fontWeight: FontWeight.w600),),
                                                ),
                                                selectedChipLocation!=0 || selectedChipProfileImage!=0 || selectedChipCertificated!=0
                                                    || ((profileImage!=0||certificated!=0||location!=0)&&selectedChipLocation==0&&selectedChipCertificated==0&&selectedChipProfileImage==0) // 전 선택과 같지 않고 && 모두 0으로 설정될 때
                                                  ? TextButton(
                                                    onPressed: () {
                                                      AnalyticsUtil.logEvent("과팅_목록_필터링_적용하기_터치"); // TODO : properties
                                                      profileImage = selectedChipProfileImage;
                                                      certificated = selectedChipCertificated;
                                                      location = selectedChipLocation;
                                                      widget.onFilterChanged(location, certificated, profileImage);
                                                      print("지역 : $location, 학생증 : $profileImage, 프사 : $certificated");
                                                      // widget.pagingController.refresh();
                                                      // TODO : pagingController를 불러올 때 매개변수를 바꿔줌
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("적용하기", style: TextStyle(
                                                        fontSize: SizeConfig.defaultSize * 1.9,
                                                        color: const Color(0xffFE6059)
                                                    ),))
                                                  : const SizedBox()
                                              ],
                                            ),
                                          ),
                                          Text("내가 보고 싶은 팀의 특징만 골라보세요!", style: TextStyle(
                                            fontSize: SizeConfig.defaultSize * 1.6
                                          ),),

                                          Padding(
                                            padding: EdgeInsets.only(top: SizeConfig.defaultSize * 4),
                                            child: Text("지역", style: TextStyle(
                                              fontSize: SizeConfig.defaultSize * 1.7,
                                              fontWeight: FontWeight.w600
                                            ),),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: SizeConfig.defaultSize * 0.5),
                                            child: Text("하나만 선택할 수 있어요!", style: TextStyle(
                                              fontSize: SizeConfig.defaultSize * 1.6,
                                              color: Colors.grey
                                            ),),
                                          ),
                                          Wrap(
                                            spacing: 8.0,
                                            children: () {
                                              // "전지역" 항목이 없으면 추가
                                              if (widget.meetState.serverLocations.isEmpty || widget.meetState.serverLocations[0].id != 0) {
                                                widget.meetState.serverLocations.insert(0, Location(id: 0, name: '전지역'));
                                              }

                                              return widget.meetState.serverLocations.asMap().entries.map<Widget>((entry) {
                                                int index = entry.key;
                                                Location location = entry.value;
                                                return chipGroupLocation(location.name, index);
                                              }).toList();
                                            }(),
                                          ),

                                          Padding(
                                            padding: EdgeInsets.only(top: SizeConfig.defaultSize * 4),
                                            child: Text("학생증 인증", style: TextStyle(
                                                fontSize: SizeConfig.defaultSize * 1.7,
                                                fontWeight: FontWeight.w600
                                            ),),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: SizeConfig.defaultSize * 0.5),
                                            child: Text("인증한 팀은 파란색 배지가 붙어있어요!", style: TextStyle(
                                                fontSize: SizeConfig.defaultSize * 1.6,
                                                color: Colors.grey
                                            ),),
                                          ),
                                          Wrap(
                                            spacing: 8.0,
                                            children: <Widget>[
                                              chipGroupCertificated('선택 안 함', 0),
                                              chipGroupCertificated('인증 완료한 팀만', 1),
                                            ],
                                          ),

                                          Padding(
                                            padding: EdgeInsets.only(top: SizeConfig.defaultSize * 4),
                                            child: Text("프로필 사진 여부", style: TextStyle(
                                                fontSize: SizeConfig.defaultSize * 1.7,
                                                fontWeight: FontWeight.w600
                                            ),),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: SizeConfig.defaultSize * 0.5),
                                            child: Text("팀원 중에 한 명이라도 사진이 있다면 보여요!", style: TextStyle(
                                                fontSize: SizeConfig.defaultSize * 1.6,
                                                color: Colors.grey
                                            ),),
                                          ),
                                          Wrap(
                                            spacing: 8.0,
                                            children: <Widget>[
                                              chipGroupProfileImage('선택 안 함', 0),
                                              chipGroupProfileImage('사진 있는 팀만', 1),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          );
                        }
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: SizeConfig.defaultSize * 0.5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("     ", style: TextStyle(color: Colors.black),),
                          Icon(Icons.filter_alt_rounded, size: SizeConfig.defaultSize * 1.5, color: profileImage!=0||certificated!=0||location!=0 ? const Color(0xffFE6059) : Colors.black),
                          Text(" 필터링        ", style: TextStyle(color: profileImage!=0||certificated!=0||location!=0 ? const Color(0xffFE6059) : Colors.black)),
                        ],
                      ),
                    ),
                  ),
                  DropdownButton(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.black, fontSize: SizeConfig.defaultSize * 1.5),
                    underline: Container(),
                    onChanged: (String? newValue) {
                      setState(() {
                        AnalyticsUtil.logEvent('과팅_목록_정렬_터치', properties: {
                          '선택한 정렬' : newValue
                        });
                        dropdownValue = newValue!;
                        if (dropdownValue == '호감순') {
                          onClickSortButton(1);
                        } else if (dropdownValue == '조회순') {
                          onClickSortButton(2);
                        } else if (dropdownValue == '최신순') {
                          onClickSortButton(0);
                        }
                      });
                    },
                    items: list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )
                ],
              )
            )
          ),
          Flexible(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: _scrollController,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 1, vertical: SizeConfig.defaultSize),
                child: Column(
                  children: [
                    RefreshIndicator(
                        onRefresh: () async {
                          widget.pagingController.refresh();
                        },
                        child: SizedBox(
                          height: SizeConfig.screenHeight * 0.8,
                          child: PagedListView<int, BlindDateTeam>(
                            pagingController: widget.pagingController,
                            builderDelegate: PagedChildBuilderDelegate<BlindDateTeam>(
                            itemBuilder: (_, blindDateTeam, __) {
                            return widget.pagingController.itemList!.isEmpty || widget.pagingController.itemList == null
                                ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/images/hearts.png', width: SizeConfig.screenWidth * 0.55 ,),
                                      SizedBox(height: SizeConfig.defaultSize * 5,),
                                      Text("해당하는 팀을 찾을 수 없어요🥺", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.8),),
                                      SizedBox(height: SizeConfig.defaultSize,),
                                      Text("기다리는 동안 다른 친구들을 앱에 초대해보세요!", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.8),),
                                      SizedBox(height: SizeConfig.defaultSize * 3,),
                                      Text("친구가 내 이상형을 데려올지도 👀", style: TextStyle(color: Colors.grey, fontSize: SizeConfig.defaultSize * 1.5),),
                                    ],
                                  ),
                                )
                                : Column(
                                  children: [
                                    SizedBox(height: SizeConfig.defaultSize * 0.9,),
                                    MeetOneTeamCardview(team: blindDateTeam, isMyTeam: false, myTeamCount: widget.meetState.myTeams.length, myTeamId: nowTeam.id,)
                                  ]);
                              },
                            ),
                          ),
                        ),
                      ),
                      // if (!(widget.meetState.friends.isEmpty || widget.meetState.filteredFriends.isEmpty || widget.meetState.myTeams.length==0))
                      //   SizedBox(height: SizeConfig.defaultSize * 30)
                  ],
                )
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TopSection extends StatefulWidget {
  final MeetState ancestorState;
  final BuildContext context;

  const _TopSection({
    super.key,
    required this.ancestorState,
    required this.context
  });

  @override
  State<_TopSection> createState() => _TopSectionState();
}

class _TopSectionState extends State<_TopSection> {
  late MeetTeam selectedTeam; // Add this line
  late List<MeetTeam> myTeams;

  @override
  void initState() {
    super.initState();
    selectedTeam = widget.ancestorState.myTeam ?? widget.ancestorState.myTeams[0]; // TODO : myTeams[0] 말고 state.getTeam() 가져와야하는데 못 가져옴
    myTeams = widget.ancestorState.myTeams;
  }

  @override
  Widget build(BuildContext context) {
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
                  DropdownButton<MeetTeam>(
                    value: selectedTeam,
                    padding: EdgeInsets.zero,
                    onChanged: (newValue) {
                      setState(() {
                        selectedTeam = newValue!;
                        widget.context.read<MeetCubit>().initMeet(initPickedTeam: selectedTeam);
                      });
                    },
                    items: myTeams.map((myTeam) {
                      return DropdownMenuItem<MeetTeam>(
                        value: myTeam,
                        child: Text(
                          myTeam.name,
                          style: TextStyle(
                            fontSize: SizeConfig.defaultSize * 1.6,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  Text("팀으로 보고 있어요!", style: TextStyle(
                    fontSize: SizeConfig.defaultSize * 1.5,
                    fontWeight: FontWeight.w400
                  ),),
                ],
              ),
              // Text("필터링", style: TextStyle(
              //   fontSize: SizeConfig.defaultSize * 1.6,
              //   fontWeight: FontWeight.w400
              // ),)
              Text("", style: TextStyle(
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

  NotFriendComponent(this.isAdd, this.friend, {super.key});

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
                // AnalyticsUtil.logEvent("과팅_대기_친추_알수도있는친구_목록터치", properties: {
                //   "친구 성별": friend.personalInfo!.gender == "FEMALE"
                //       ? "여자"
                //       : "남자",
                //   "친구 학번": friend.personalInfo!.admissionYear.toString()
                //       .substring(2, 4),
                //   "친구 학교": friend.university!.name,
                //   "친구 학교코드": friend.university!.id,
                //   "친구 학과": friend.university!.department
                // });
              },
              child: SizedBox(
                width: SizeConfig.screenWidth * 0.52,
                child: Row(
                  children: [
                    Text(friend.personalInfo?.name ?? "XXX", style: TextStyle(
                      fontSize: SizeConfig.defaultSize * 1.9,
                      fontWeight: FontWeight.w600,
                    )),
                    Flexible(
                      child: Text("  ${friend.personalInfo!.admissionYear
                          .toString().substring(2, 4)}학번∙${friend.university
                          ?.department}", style: TextStyle(
                        fontSize: SizeConfig.defaultSize * 1.3,
                        fontWeight: FontWeight.w500,
                        overflow: TextOverflow.ellipsis,
                      )),
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
                  // AnalyticsUtil.logEvent("과팅_대기_친추_알수도있는친구더보기_신고");
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
                                // AnalyticsUtil.logEvent("과팅_대기_친추_알수도있는친구더보기_신고_취소");
                                Navigator.pop(context, '취소');
                              },
                              child: const Text('취소', style: TextStyle(
                                  color: Color(0xffFE6059)),),
                            ),
                            TextButton(
                              onPressed: () =>
                              {
                                // AnalyticsUtil.logEvent("과팅_대기_친추_알수도있는친구더보기_신고_신고확정"),
                                Navigator.pop(context, '신고'),
                                ToastUtil.showMeetToast("사용자가 신고되었어요!", 1),
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
                // AnalyticsUtil.logEvent("과팅_대기_친추_알수도있는친구_친구추가");
                if (isAdd) {
                  pressedAddButton(context, friend.personalInfo!.id);
                  // Navigator.pop(context);
                }
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffFE6059),
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
        const Divider(
          color: Color(0xffdddddd),
        ),
      ],
    );
  }
}