import 'dart:async';
import 'package:dart_flutter/src/domain/entity/user.dart';
import 'package:dart_flutter/res/config/size_config.dart';
import 'package:dart_flutter/src/common/util/analytics_util.dart';
import 'package:dart_flutter/src/common/util/toast_util.dart';
import 'package:dart_flutter/src/presentation/standby/standby_landing_page.dart';
import 'package:dart_flutter/src/presentation/vote/vimemodel/state/vote_state.dart';
import 'package:dart_flutter/src/presentation/vote/vimemodel/vote_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VoteTimer extends StatefulWidget {
  VoteState state;

  VoteTimer({super.key, required this.state});

  @override
  State<VoteTimer> createState() => _VoteTimerState();
}

class _VoteTimerState extends State<VoteTimer> {
  late int totalSeconds;
  late Timer timer;

  void onTick(Timer timer) {
    setState(() {
      totalSeconds = BlocProvider
          .of<VoteCubit>(context)
          .state
          .leftNextVoteTime();
    });

    if (totalSeconds <= 0) {
      setState(() {
        timer.cancel();
        BlocProvider.of<VoteCubit>(context).stepWait();
      });
    }
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds).toString(); // 시간형식으로 나타내줌 0:00:00.000000

    List<String> parts = duration.split(":"); // 콜론을 기준으로 문자열을 분할합니다.
    String hh = parts[1]; // 시간 부분을 hh에 저장합니다.
    String ss = parts[2].split(".")[0]; // 초 부분을 ss에 저장합니다. (소수점 이하 자릿수를 제거하기 위해 "."을 기준으로 분할)

    return "$hh:$ss"; // 가운데 hh:ss 형식으로 반환합니다.
  }

  @override
  void initState() {
    super.initState();
    totalSeconds = BlocProvider.of<VoteCubit>(context).state.leftNextVoteTime();
    timer = Timer.periodic(const Duration(seconds: 1), onTick);
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Flexible(
                flex: 4,
                child: SizedBox(),
              ),
              Flexible(
                flex: 3,
                child: Column(
                  children: [
                    Container(
                      child: Text(
                        "다시 시작하기까지",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: SizeConfig.defaultSize * 3.7,
                        ),
                      ),
                    ),
                    Container(
                      child: GestureDetector(
                        onTap: () {
                          AnalyticsUtil.logEvent("투표_타이머_시간", properties: {"남은 시간": totalSeconds});
                        },
                        child: Text(
                          format(totalSeconds),
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: SizeConfig.defaultSize * 9,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.03),
                    Text(
                      "새로운 질문들이 준비되면 알림을 드릴게요!",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: SizeConfig.defaultSize * 1.8,
                      ),
                    ),
                  ],
                ),
              ),
              // Flexible( // TODO : MVP 출시 이후 복구하기
              //   flex: 1,
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: [
              //       Text("바로 시작하려면?", style: TextStyle(fontSize: SizeConfig.defaultSize * 3.2)),
              //       SizedBox(height:SizeConfig.defaultSize * 1),
              //       ElevatedButton(
              //         onPressed: () {
              //           // BlocProvider.of<VoteCubit>(context).stepWait();
              //           BlocProvider.of<VoteCubit>(context).inviteFriend();
              //         },
              //         child: Text(
              //           "친구 초대하기",
              //           style: TextStyle(
              //             fontSize: SizeConfig.defaultSize * 4,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              Flexible(
                flex: 2,
                child: Column(
                  children: [
                    Text("다음 질문에는 이 친구와 함께!", style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: SizeConfig.defaultSize * 1.8,
                    ),),
                      SizedBox(height: SizeConfig.defaultSize,),
                    GestureDetector( // 친추 버튼
                      onTap: () {
                        String friendCode = '';
                        AnalyticsUtil.logEvent("투표_타이머_친추_버튼터치");
                        showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                            ),
                            backgroundColor: Colors.white,
                            isScrollControlled: true,
                            builder: (BuildContext _) {
                              AnalyticsUtil.logEvent("투표_타이머_친추_접속");
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
                                                      AnalyticsUtil.logEvent("투표_타이머_친추_닫기");
                                                      Navigator.pop(context);
                                                    },
                                                    icon: Icon(Icons.close_rounded, color: Colors.black, size: SizeConfig.defaultSize * 3,)),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: SizeConfig.defaultSize * 2),
                                          Text(
                                            "친구와 함께 즐겨요!",
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
                                            child: widget.state.isLoading ? const CircularProgressIndicator(color: Color(0xff7C83FD)) : null,
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
                                                        widget.state.userResponse.personalInfo?.recommendationCode ?? '내 코드가 없어요!',
                                                        style: TextStyle(
                                                          fontSize: SizeConfig.defaultSize * 1.9,
                                                        ),
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          AnalyticsUtil.logEvent("투표_타이머_친추_내코드복사");
                                                          String myCodeCopy = widget.state.userResponse.personalInfo?.recommendationCode ?? '내 코드 복사에 실패했어요🥲';
                                                          Clipboard.setData(ClipboardData(
                                                              text:
                                                              myCodeCopy)); // 클립보드에 복사되었어요 <- 메시지 자동으로 Android에서 뜸 TODO : iOS는 확인하고 복사멘트 띄우기
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                          primary: Colors.white,
                                                          onPrimary: Color(0xff7C83FD),
                                                          textStyle: TextStyle(
                                                            color: Color(0xff7C83FD),
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
                                              AnalyticsUtil.logEvent("투표_타이머_친추_링크공유");
                                              shareContent(context, widget.state.userResponse.personalInfo?.recommendationCode ?? '내 코드');
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.only(left: SizeConfig.defaultSize, right: SizeConfig.defaultSize),
                                              child: Container(
                                                // 친구 추가 버튼
                                                width: SizeConfig.screenWidth * 0.9,
                                                height: SizeConfig.defaultSize * 5.5,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    color: Color(0xff7C83FD),
                                                    // color: Colors.white,
                                                    border: Border.all(
                                                      color: Color(0xff7C83FD),
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey.withOpacity(0.3),
                                                        spreadRadius: 5,
                                                        blurRadius: 4,
                                                        offset: Offset(0,3), // changes position of shadow
                                                      ),
                                                    ],
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
                                                              borderSide: BorderSide(color: Color(0xff7C83FD)),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      ElevatedButton( // 친구 추가 버튼
                                                        style: ElevatedButton.styleFrom(
                                                          backgroundColor: widget.state.isLoading ? Colors.grey.shade400 : Color(0xff7C83FD),
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(15), // 모서리 둥글기 설정
                                                          ),
                                                          padding: EdgeInsets.only(left: SizeConfig.defaultSize * 2.12, right: SizeConfig.defaultSize * 2.12),
                                                        ),
                                                        onPressed: () async {
                                                          String friendCodeConfirm = "";
                                                          // 친구추가 중인 경우 버튼 동작 X
                                                          if (widget.state.isLoading) {
                                                            return;
                                                          }
                                                          if (friendCode == widget.state.userResponse.personalInfo!.recommendationCode) {
                                                            ToastUtil.itsMyCodeToast("나는 친구로 추가할 수 없어요!");
                                                            friendCodeConfirm = "나";
                                                          } else {
                                                            print("friendCode $friendCode");
                                                            try {
                                                              thisState(() {
                                                                setState(() {
                                                                  widget.state.isLoading = true;
                                                                });
                                                              });

                                                              // 실제 친구 추가 동작
                                                              await BlocProvider.of<VoteCubit>(context).pressedFriendCodeAddButton(friendCode);
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
                                                                widget.state.isLoading = false;
                                                              });
                                                            });
                                                            AnalyticsUtil.logEvent("투표_타이머_친추_친구코드_추가", properties: {
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
                                                          color: Color(0xff7C83FD)
                                                      ),),
                                                  ],
                                                ),
                                                SizedBox(height: SizeConfig.defaultSize * 1.5,),
                                                BlocProvider<VoteCubit>.value(
                                                  value: BlocProvider.of<VoteCubit>(context),
                                                  child: BlocBuilder<VoteCubit, VoteState>(
                                                    builder: (friendContext, state) {
                                                      final friends = state.newFriends;
                                                      print("hihihihi");
                                                      return NewFriends2(friends: friends.toList(), count: friends.length);
                                                    },
                                                  ),
                                                ),
                                                BlocProvider<VoteCubit>.value( // BlocProvider로 감싸기
                                                  value: BlocProvider.of<VoteCubit>(context),
                                                  child: BlocBuilder<VoteCubit, VoteState>(
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
                        width: SizeConfig.screenWidth * 0.85,
                        height: SizeConfig.defaultSize * 6,
                        decoration: BoxDecoration(
                          color: Color(0xff7C83FD),
                          borderRadius: BorderRadius.circular(13),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              spreadRadius: 3,
                              blurRadius: 7,
                              offset: Offset(0,1), // changes position of shadow
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: Text("내 친구 추가하고 함께 즐기기", style: TextStyle(
                          fontSize: SizeConfig.defaultSize * 2,
                          color: Colors.white,
                          fontWeight: FontWeight.w600
                        ),),
                      ),
                    ),
                  ]
                )
              ),
              // const Flexible(
              //   flex: 1,
              //   child: SizedBox(),
              // ),
            ],
          ),
        ),
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
    await BlocProvider.of<VoteCubit>(context).pressedFriendAddButton(friend);
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
                AnalyticsUtil.logEvent("투표_타이머_친추_알수도있는친구_목록터치", properties: {
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
                  AnalyticsUtil.logEvent("투표_타이머_친추_알수도있는친구더보기_신고");
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
                                    "투표_타이머_친추_알수도있는친구더보기_신고_취소");
                                Navigator.pop(context, '취소');
                              },
                              child: const Text('취소', style: TextStyle(
                                  color: Color(0xff7C83FD)),),
                            ),
                            TextButton(
                              onPressed: () =>
                              {
                                AnalyticsUtil.logEvent(
                                    "투표_타이머_친추_알수도있는친구더보기_신고_신고확정"),
                                Navigator.pop(context, '신고'),
                                ToastUtil.showToast("사용자가 신고되었어요!"),
                                // TODO : 신고 기능 (서버 연결)
                              },
                              child: const Text('신고', style: TextStyle(
                                  color: Color(0xff7C83FD)),),
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
                AnalyticsUtil.logEvent("투표_타이머_친추_알수도있는친구_친구추가");
                if (isAdd) {
                  pressedAddButton(context, friend.personalInfo!.id);
                  // Navigator.pop(context);
                }
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff7C83FD),
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