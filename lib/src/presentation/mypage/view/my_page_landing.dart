import 'package:dart_flutter/res/config/size_config.dart';
import 'package:dart_flutter/src/common/util/analytics_util.dart';
import 'package:dart_flutter/src/common/util/toast_util.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';
import 'package:dart_flutter/src/presentation/mypage/view/student_vertification.dart';
import 'package:dart_flutter/src/presentation/mypage/viewmodel/mypages_cubit.dart';
import 'package:dart_flutter/src/presentation/mypage/viewmodel/state/mypages_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';

import 'my_settings.dart';

class MyPageLanding extends StatefulWidget {
  const MyPageLanding({Key? key}) : super(key: key);

  @override
  State<MyPageLanding> createState() => _MyPageLandingState();
}

class _MyPageLandingState extends State<MyPageLanding> {

  @override
  Widget build(BuildContext context) {
    AnalyticsUtil.logEvent("내정보_마이_접속");
    return RefreshIndicator(
      onRefresh: () async {
        context.read<MyPagesCubit>().refreshMyInfo();
        AnalyticsUtil.logEvent('내정보_마이_당겨서새로고침');
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.defaultSize),
          child: BlocBuilder<MyPagesCubit, MyPagesState>(
            builder: (context, state) {
              final user = state.userResponse;
              return MyPageLandingView(userResponse: user);
            }
          ),
        ),
      ),
    );
  }
}

class MyPageLandingView extends StatefulWidget {
  final User userResponse;

  const MyPageLandingView({
    super.key,
    required this.userResponse,
  });

  @override
  State<MyPageLandingView> createState() => _MyPageLandingViewState();
}

class _MyPageLandingViewState extends State<MyPageLandingView> {
  String get profileImageUrl => widget.userResponse.personalInfo?.profileImageUrl ?? 'DEFAULT';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: SizeConfig.defaultSize,
              horizontal: SizeConfig.defaultSize * 0.5),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(13),
              border: Border.all(width: 1.3, color: const Color(0xff2F4858))
    // border: Border.all(width: 1.3, color: const Color(0xffFE6059))
              // boxShadow: [ // Boxshadow 필요하면 쓰기
              //   BoxShadow(
              //     color: Colors.grey.withOpacity(0.2),
              //     spreadRadius: 5,
              //     blurRadius: 7,
              //     offset: Offset(0, 3), // changes position of shadow
              //   ),
              // ],
            ),
            height: SizeConfig.defaultSize * 15,
            child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.defaultSize,
                    horizontal: SizeConfig.defaultSize * 1.5),
                child: Column(
                  children: [
                    Row( // 프사 ~ 설정 부분 (위층)
                      children: [
                        SizedBox(width: SizeConfig.defaultSize * 0.3),

                        GestureDetector(
                          onTap: () {
                            AnalyticsUtil.logEvent("내정보_마이_내사진터치");
                          },
                          child: ClipOval(
                            child: BlocBuilder<MyPagesCubit, MyPagesState>(
                              builder: (context, state) {
                                if (profileImageUrl == "DEFAULT" || !profileImageUrl.startsWith("https://")) {
                                  return Image.asset('assets/images/profile-mockup3.png', width: SizeConfig.defaultSize * 5.7, fit: BoxFit.cover,);
                                } else {
                                  return state.profileImageFile.path==''
                                      ? Image.network(profileImageUrl,
                                      width: SizeConfig.defaultSize * 5.7,
                                      height: SizeConfig.defaultSize * 5.7,
                                      fit: BoxFit.cover)
                                      : Image.file(state.profileImageFile,
                                      width: SizeConfig.defaultSize * 5.7,
                                      height: SizeConfig.defaultSize * 5.7,
                                      fit: BoxFit.cover);
                                }
                              }
                            )
                          ),
                        ),
                        // profileImageUrl == "DEFAULT"
                        //     ? ClipOval(
                        //       child: Image.asset('assets/images/profile-mockup3.png', width: SizeConfig.defaultSize * 5.7, fit: BoxFit.cover,),
                        //       )
                        //     : ClipOval(
                        //     child: Image.network(profileImageUrl,
                        //       width: SizeConfig.defaultSize * 5.7,
                        //       height: SizeConfig.defaultSize * 5.7,
                        //         fit: BoxFit.cover)
                        // )),
                        SizedBox(width: SizeConfig.defaultSize * 0.6),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row( // 1층
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  BlocBuilder<MyPagesCubit,MyPagesState>(
                                      builder: (context, state) {
                                        String name = state.userResponse.personalInfo?.name ?? "###";
                                        String admissionNumber = "${state.userResponse.personalInfo?.admissionYear.toString().substring(2,4)??"##"}학번";
                                        return Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(width: SizeConfig.defaultSize * 0.5,),
                                            Text(name,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: SizeConfig.defaultSize * 2,
                                                color: Colors.black,
                                              ),),
                                            SizedBox(width: SizeConfig.defaultSize * 0.5),
                                            Text(admissionNumber,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: SizeConfig.defaultSize * 1.5,
                                                color: Colors.black,
                                              ),),
                                            if (widget.userResponse.personalInfo?.verification.isVerificationSuccess ?? false)
                                              Row(
                                                children: [
                                                  SizedBox(width: SizeConfig.defaultSize * 0.5),
                                                  Image.asset("assets/images/check.png", width: SizeConfig.defaultSize * 1.4),
                                                ],
                                              )
                                          ]
                                        );
                                      }
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.settings, color: Colors.black,),
                                    onPressed: () async {
                                      AnalyticsUtil.logEvent("내정보_마이_설정버튼");
                                      BlocProvider.of<MyPagesCubit>(context).refreshMyInfo();
                                      final profileImage = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => BlocProvider.value(
                                            value: BlocProvider.of<MyPagesCubit>(context),
                                            child: MySettings(
                                              userResponse: BlocProvider.of<MyPagesCubit>(context).state.userResponse,
                                            ),
                                          ),
                                        ),
                                      );
                                      BlocProvider.of<MyPagesCubit>(context).setProfileImage(profileImage);

                                      PaintingBinding.instance.imageCache.clear();
                                      BlocProvider.of<MyPagesCubit>(context).refreshMyInfo();
                                      setState(() {
                                      });
                                    },
                                    iconSize: SizeConfig.defaultSize * 2.4,
                                  ),
                                ],
                              ),
                              Row( // 2층
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  BlocBuilder<MyPagesCubit,MyPagesState>(
                                      builder: (context, state) {
                                        String university = state.userResponse.university?.name??'#####학교';
                                        String department = state.userResponse.university?.department??'######학과';
                                        return SizedBox(
                                          width: SizeConfig.screenWidth * 0.67,
                                          child: Row(
                                            children: [
                                              SizedBox(width: SizeConfig.defaultSize * 0.5,),
                                              Text(
                                                university,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: SizeConfig.defaultSize * 1.3,
                                                    color: Colors.black
                                                ),
                                              ),
                                              SizedBox(width: SizeConfig.defaultSize * 0.5,),
                                              Text(
                                                department,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: SizeConfig.defaultSize * 1.3,
                                                    color: Colors.black,
                                                  overflow: TextOverflow.ellipsis
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                  ),
                                ],
                              ),
                              SizedBox(height: SizeConfig.defaultSize,),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: SizeConfig.defaultSize * 0.7,),
                    Container( // 포인트 ~ (아래층)
                      padding: EdgeInsets.only(left: SizeConfig.defaultSize * 1.4, right: SizeConfig.defaultSize * 1.4, top: SizeConfig.defaultSize * 1.1, bottom: SizeConfig.defaultSize * 1.1),
                      decoration: BoxDecoration(
                        // color: Color(0xffFE6059).withOpacity(0.1),
                        color: Colors.grey.shade100,
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("나의 Points", style: TextStyle(
                            fontSize: SizeConfig.defaultSize * 1.4
                          ),),
                          GestureDetector(
                            onTap: () {
                              AnalyticsUtil.logEvent("내정보_마이_포인트터치");
                            },
                            child: Text(widget.userResponse.personalInfo?.point.toString() ?? "불러오는중", style: TextStyle(
                                fontSize: SizeConfig.defaultSize * 1.4
                            )),
                          )
                          // TODO 나중에 : Point 사용 내역
                        ],
                      )
                    ),
                  ],
                )
            ),
          ),
        ),

        // =================================================================

        if (!(widget.userResponse.personalInfo?.verification.isVerificationSuccess ?? false))
          InkWell(
            onTap: () async {
              AnalyticsUtil.logEvent("내정보_마이_학생증인증배너터치");
              await Navigator.push(context, MaterialPageRoute(builder: (_) => StudentVertification(
                userResponse: BlocProvider.of<MyPagesCubit>(context).state.userResponse,
              )));

              PaintingBinding.instance.imageCache.clear();
              BlocProvider.of<MyPagesCubit>(context).refreshMyInfo();
              setState(() {
              });
            },
            child: Padding( // TODO : 학생증
              padding: EdgeInsets.symmetric(
                // vertical: SizeConfig.defaultSize,
                  horizontal: SizeConfig.defaultSize * 0.5),
              child: Container(
                width: SizeConfig.screenWidth,
                height: SizeConfig.defaultSize * 6.8,
                decoration: BoxDecoration(
                    color: const Color(0xff2F4858),
                    borderRadius: BorderRadius.circular(10),
                    // border: Border.all(width: 1.3, color: const Color(0xffFE6059))
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: SizeConfig.defaultSize * 2.0, right: SizeConfig.defaultSize * 1.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.check_circle, size: SizeConfig.defaultSize * 3, color: Colors.blue),
                      SizedBox(width: SizeConfig.defaultSize * 2,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("학생증 제출하고 팀에 인증 배지를 추가해요!", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.4, color: Colors.white),),
                          Text("학생증 인증하기  >", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.6, fontWeight: FontWeight.w600, color: Colors.white),),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

        SizedBox(height: SizeConfig.defaultSize),

        Padding(
            padding: EdgeInsets.symmetric(
                vertical: SizeConfig.defaultSize,
                horizontal: SizeConfig.defaultSize * 1.1),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: SizeConfig.defaultSize * 0.2, right: SizeConfig.defaultSize * 0.2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("내 친구",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: SizeConfig.defaultSize * 1.7,
                          color: const Color(0xffFE6059)
                        ),),
                      BlocBuilder<MyPagesCubit, MyPagesState>(
                          builder: (context, state) {
                            return openAddFriends(myCode: state.userResponse.personalInfo?.recommendationCode ?? '내 코드가 없어요!');
                          }),
                    ],
                  ),
                ),
                SizedBox(height: SizeConfig.defaultSize * 1.5,),
                BlocBuilder<MyPagesCubit,MyPagesState>(
                    builder: (context, state) {
                      final friends = state.friends;
                      final user = state.userResponse;
                      return MyFriends(friends: friends, count: friends.length, userResponse: user);
                    }
                ),
              ],
            )
        ),

        Container( // 구분선
          padding: const EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0,),
          height: SizeConfig.defaultSize * 2,
          color: Colors.grey.withOpacity(0.1),
        ),

        SizedBox(height: SizeConfig.defaultSize * 2,),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: SizeConfig.defaultSize,
              horizontal: SizeConfig.defaultSize * 1.1),
          child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: SizeConfig.defaultSize * 0.2, right: SizeConfig.defaultSize * 0.2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("알 수도 있는 친구",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: SizeConfig.defaultSize * 1.7,
                          color: const Color(0xffFE6059)
                        ),),
                    ],
                  ),
                ),
                SizedBox(height: SizeConfig.defaultSize * 2 ,),
                BlocBuilder<MyPagesCubit,MyPagesState>(
                    builder: (context, state) {
                      final friends = state.newFriends;
                      final user = state.userResponse;
                      return NewFriends(friends: friends, count: friends.length, userResponse: user,);
                    }
                ),
              ],
          ),
        ),

      ],
    );
  }
}

class MyFriends extends StatelessWidget {
  final Set<User> friends;
  final int count;
  final User userResponse;

  const MyFriends({
    super.key,
    required this.friends,
    required this.count,
    required this.userResponse
  });

  @override
  Widget build(BuildContext context) {
    var friendsList = friends.toList();

    return BlocBuilder<MyPagesCubit,MyPagesState>(
      builder: (context, state) {
        return Column(
          children: [
            for (int i = 0; i < count; i++)
              FriendComponent(false, friendsList[i], count, userResponse),
          ],
        );
      }
    );
  }
}

class NewFriends extends StatelessWidget {
  final Set<User> friends;
  final int count;
  final User userResponse;

  const NewFriends({
    super.key,
    required this.friends,
    required this.count,
    required this.userResponse,
  });

  @override
  Widget build(BuildContext context) {
    var friendsList = friends.toList();

    return Column(
      children: [
        for (int i = 0; i < count; i++)
          NotFriendComponent(true, friendsList[i], userResponse),
      ],
    );
  }
}

class FriendComponent extends StatefulWidget {
  final bool isAdd;
  final User friend;
  final int count;
  final User userResponse;

  const FriendComponent(this.isAdd, this.friend, this.count, this.userResponse, {super.key});

  @override
  State<FriendComponent> createState() => _FriendComponentState();
}

class _FriendComponentState extends State<FriendComponent> {

  void pressedDeleteButton(BuildContext context, int userId) {
    BlocProvider.of<MyPagesCubit>(context).pressedFriendDeleteButton(widget.friend);
  }

  void pressedAddButton(BuildContext context, int userId) async {
    await BlocProvider.of<MyPagesCubit>(context).pressedFriendAddButton(widget.friend);
  }

  void showCannotAddFriendToast() {
    Fluttertoast.showToast(
      msg: "친구가 4명일 때는 삭제할 수 없어요!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: const Color(0xffFE6059),
      textColor: Colors.white,
      fontSize: SizeConfig.defaultSize * 1.6,
    );
  }

  String get profileImageUrl => widget.friend.personalInfo?.profileImageUrl ?? 'DEFAULT';

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
                AnalyticsUtil.logEvent("내정보_마이_친구터치", properties: {
                  "친구 성별": widget.friend.personalInfo?.gender=="FEMALE" ? "여자" : "남자",
                  "친구 학번": widget.friend.personalInfo?.admissionYear.toString().substring(2,4),
                  "친구 학교": widget.friend.university!.name,
                  "친구 학교코드": widget.friend.university!.id,
                  "친구 학과": widget.friend.university!.department
                });
              },
              child: SizedBox(
                width: SizeConfig.screenWidth * 0.7,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        AnalyticsUtil.logEvent("내정보_마이_친구프로필사진터치", properties: {
                        "친구 성별": widget.friend.personalInfo?.gender=="FEMALE" ? "여자" : "남자",
                        "친구 학번": widget.friend.personalInfo?.admissionYear.toString().substring(2,4),
                        "친구 학교": widget.friend.university!.name,
                        "친구 학교코드": widget.friend.university!.id,
                        "친구 학과": widget.friend.university!.department
                        });
                      },
                      child: ClipOval(
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                            // decoration: BoxDecoration(
                            //   gradient: LinearGradient(
                            //       colors: [Color(0xff7C83FD), Color(0xff7C83FD)]),
                            //   borderRadius: BorderRadius.circular(32),
                            // ),
                            child: profileImageUrl == "DEFAULT"
                                ? ClipOval(
                              child: Image.asset('assets/images/profile-mockup3.png', width: SizeConfig.defaultSize * 4.5, fit: BoxFit.cover,),
                            )
                                : ClipOval(
                                child: Image.network(profileImageUrl,
                                  width: SizeConfig.defaultSize * 4.5,
                                  height: SizeConfig.defaultSize * 4.5,
                                  fit: BoxFit.cover,)
                            ),
                        ),
                      ),
                    ),
                    SizedBox(width: SizeConfig.defaultSize * 0.1,),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("  ${widget.friend.personalInfo?.name} ", style: TextStyle(
                                fontSize: SizeConfig.defaultSize * 1.6,
                                fontWeight: FontWeight.w800,
                                overflow: TextOverflow.ellipsis,
                              )),
                              Text("${widget.friend.personalInfo?.admissionYear.toString().substring(2,4)}학번", style: TextStyle(
                                fontSize: SizeConfig.defaultSize * 1.3,
                                fontWeight: FontWeight.w500,
                                overflow: TextOverflow.ellipsis,
                              )),
                              if (widget.friend.personalInfo!.verification.isVerificationSuccess)
                                Row(
                                  children: [
                                    SizedBox(width: SizeConfig.defaultSize * 0.35),
                                    Image.asset("assets/images/check.png", width: SizeConfig.defaultSize * 1.2),
                                  ],
                                ),
                            ],
                          ),
                          SizedBox(height: SizeConfig.defaultSize * 0.4,),
                          Text("  ${widget.friend.university!.name} ${widget.friend.university?.department}", style: TextStyle(
                            fontSize: SizeConfig.defaultSize * 1.3,
                            fontWeight: FontWeight.w500,
                            overflow: TextOverflow.ellipsis,
                          )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: SizeConfig.defaultSize,),

            PopupMenuButton<String>(
              icon: Icon(Icons.more_horiz_rounded, color: Colors.grey.shade300,),
              color: Colors.white,
              surfaceTintColor: Colors.white,
              onSelected: (value) {
                // 팝업 메뉴에서 선택된 값 처리
                if (value == 'report') {
                  AnalyticsUtil.logEvent("내정보_마이_내친구더보기_신고");
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('사용자를 신고하시겠어요?'),
                      content: const Text('사용자를 신고하면 엔대생에서 빠르게 신고 처리를 해드려요!'),
                      backgroundColor: Colors.white,
                      surfaceTintColor: Colors.white,
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, '취소');
                            AnalyticsUtil.logEvent("내정보_마이_내친구신고_취소");
                          },
                          child: const Text('취소', style: TextStyle(color: Color(0xffFE6059)),),
                        ),
                        TextButton(
                          onPressed: () => {
                            AnalyticsUtil.logEvent("내정보_마이_내친구신고_신고확정"),
                            Navigator.pop(context, '신고'),
                            ToastUtil.showToast("사용자가 신고되었어요!"),
                            // TODO : 신고 기능 (서버 연결)
                          },
                          child: const Text('신고', style: TextStyle(color: Color(0xffFE6059)),),
                        ),
                      ],
                    ),
                  );
                }
                else if (value == 'delete') {
                  AnalyticsUtil.logEvent("내정보_마이_내친구더보기_친구삭제");
                  if (widget.count >= 5) {
                    if (widget.isAdd) {
                      pressedAddButton(context, widget.friend.personalInfo!.id);
                    } else {
                      // pressedDeleteButton(context, friend.userId!); // 원래 코드
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext dialogContext) => AlertDialog(
                          title: Text('\'${widget.friend.personalInfo?.name}\' 친구를 삭제하시겠어요?', style: TextStyle(fontSize: SizeConfig.defaultSize * 2),),
                          // content: const Text('사용자를 신고하면 Dart에서 빠르게 신고 처리를 해드려요!'),
                          backgroundColor: Colors.white,
                          surfaceTintColor: Colors.white,
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                AnalyticsUtil.logEvent("내정보_마이_내친구삭제_취소");
                                Navigator.pop(dialogContext, '취소');
                              },
                              child: const Text('취소', style: TextStyle(color: Color(0xffFE6059)),),
                            ),
                            TextButton(
                              onPressed: () {
                                AnalyticsUtil.logEvent("내정보_마이_내친구삭제_삭제확정");
                                pressedDeleteButton(context, widget.friend.personalInfo!.id);
                                // BlocProvider.of<MyPagesCubit>(context).pressedFriendDeleteButton(friend);
                                Navigator.pop(dialogContext); // 팝업 창을 닫는 로직 추가
                              },
                              child: const Text('삭제', style: TextStyle(color: Color(0xffFE6059)),),
                            ),
                          ],
                        ),
                      );
                    }
                  } else {
                      showCannotAddFriendToast();
                  }
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem<String>(
                    value: 'delete',
                    child: Text("친구 삭제", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.5)),
                  ),
                  PopupMenuItem<String>(
                    value: 'report',
                    child: Text("신고하기", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.5)),
                  ),
                ];
              },
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

class NotFriendComponent extends StatefulWidget {
  final bool isAdd;
  final User friend;
  final User userResponse;

  const NotFriendComponent(this.isAdd, this.friend, this.userResponse, {super.key});

  @override
  State<NotFriendComponent> createState() => _NotFriendComponentState();
}

class _NotFriendComponentState extends State<NotFriendComponent> {
  void pressedDeleteButton(BuildContext context, int userId) {
    BlocProvider.of<MyPagesCubit>(context).pressedFriendDeleteButton(widget.friend);
  }

  void pressedAddButton(BuildContext context, int userId) {
    BlocProvider.of<MyPagesCubit>(context).pressedFriendAddButton(widget.friend);
  }

  String get profileImageUrl => widget.friend.personalInfo?.profileImageUrl ?? 'DEFAULT';

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
                AnalyticsUtil.logEvent("내정보_마이_친구터치", properties: {
                  "친구 성별": widget.friend.personalInfo?.gender=="FEMALE" ? "여자" : "남자",
                  "친구 학번": widget.friend.personalInfo?.admissionYear.toString().substring(2,4),
                  "친구 학교": widget.friend.university!.name,
                  "친구 학교코드": widget.friend.university!.id,
                  "친구 학과": widget.friend.university!.department
                });
              },
              child: SizedBox(
                width: SizeConfig.screenWidth * 0.54,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        AnalyticsUtil.logEvent("내정보_마이_친구프로필사진터치", properties: {
                          "친구 성별": widget.friend.personalInfo?.gender=="FEMALE" ? "여자" : "남자",
                          "친구 학번": widget.friend.personalInfo?.admissionYear.toString().substring(2,4),
                          "친구 학교": widget.friend.university!.name,
                          "친구 학교코드": widget.friend.university!.id,
                          "친구 학과": widget.friend.university!.department
                        });
                      },
                      child: ClipOval(
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                            // decoration: BoxDecoration(
                            //   gradient: LinearGradient(
                            //       colors: [Color(0xff7C83FD), Color(0xff7C83FD)]),
                            //   borderRadius: BorderRadius.circular(32),
                            // ),
                            child: profileImageUrl == "DEFAULT"
                                ? ClipOval(
                              child: Image.asset('assets/images/profile-mockup3.png', width: SizeConfig.defaultSize * 4.5, fit: BoxFit.fill,),
                            )
                                : ClipOval(
                                child: Image.network(profileImageUrl,
                                  width: SizeConfig.defaultSize * 4.5,
                                  height: SizeConfig.defaultSize * 4.5,
                                  fit: BoxFit.cover,)
                            ),
                        ),
                      ),
                    ),
                    SizedBox(width: SizeConfig.defaultSize * 0.1,),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("  ${widget.friend.personalInfo?.name} ", style: TextStyle(
                                fontSize: SizeConfig.defaultSize * 1.6,
                                fontWeight: FontWeight.w800,
                                overflow: TextOverflow.ellipsis,
                              )),
                              Text("${widget.friend.personalInfo?.admissionYear.toString().substring(2,4)}학번", style: TextStyle(
                                fontSize: SizeConfig.defaultSize * 1.3,
                                fontWeight: FontWeight.w500,
                                overflow: TextOverflow.ellipsis,
                              )),
                              if (widget.friend.personalInfo!.verification.isVerificationSuccess)
                                Row(
                                  children: [
                                    SizedBox(width: SizeConfig.defaultSize * 0.35),
                                    Image.asset("assets/images/check.png", width: SizeConfig.defaultSize * 1.2),
                                  ],
                                ),
                            ],
                          ),
                          SizedBox(height: SizeConfig.defaultSize * 0.4,),
                          Text("  ${widget.friend.university!.name} ${widget.friend.university?.department}", style: TextStyle(
                          fontSize: SizeConfig.defaultSize * 1.3,
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis,
                            )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: SizeConfig.defaultSize,),

            PopupMenuButton<String>(
              icon: Icon(Icons.more_horiz_rounded, color: Colors.grey.shade300,),
              color: Colors.white,
              surfaceTintColor: Colors.white,
              onSelected: (value) {
                // 팝업 메뉴에서 선택된 값 처리
                if (value == 'report') {
                  AnalyticsUtil.logEvent("내정보_마이_알수도있는친구더보기_신고");
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      backgroundColor: Colors.white,
                      surfaceTintColor: Colors.white,
                      title: const Text('사용자를 신고하시겠어요?'),
                      content: const Text('사용자를 신고하면 엔대생에서 빠르게 신고 처리를 해드려요!'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            AnalyticsUtil.logEvent("내정보_마이_알수도있는친구더보기_신고_취소");
                            Navigator.pop(context, '취소');
                          },
                          child: const Text('취소', style: TextStyle(color: Color(0xffFE6059)),),
                        ),
                        TextButton(
                          onPressed: () => {
                            AnalyticsUtil.logEvent("내정보_마이_알수도있는친구더보기_신고_신고확정"),
                            Navigator.pop(context, '신고'),
                            ToastUtil.showToast("사용자가 신고되었어요!"),
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

            ElevatedButton(
              onPressed: () {
                AnalyticsUtil.logEvent("내정보_마이_알수도있는친구_친구추가");
                if (widget.isAdd) {
                  pressedAddButton(context, widget.friend.personalInfo!.id);
                } else {
                  pressedDeleteButton(context, widget.friend.personalInfo!.id);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffFE6059),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // 모서리 둥글기 설정
                ),
              ),
              child: Text(widget.isAdd?"추가":"삭제", style: TextStyle(
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

class openAddFriends extends StatefulWidget {
  late String myCode;
  late bool disabledFunctions;

  openAddFriends({
    super.key,
    required this.myCode,
    this.disabledFunctions = false,
  });

  @override
  State<openAddFriends> createState() => _openAddFriendsState();
}

class _openAddFriendsState extends State<openAddFriends> {
  var friendCode = "";

  void showCopyToast() {
    Fluttertoast.showToast(
      msg: "내 코드가 복사되었어요!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey[200],
      textColor: Colors.black,
      fontSize: SizeConfig.defaultSize * 1.6,
    );
  }
  void showAddFriendToast() {
    Fluttertoast.showToast(
      msg: "친구가 추가되었어요!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.indigoAccent,
      textColor: Colors.white,
      fontSize: SizeConfig.defaultSize * 1.6,
    );
  }
  void itsMyCodeToast() {
    Fluttertoast.showToast(
      msg: "나는 친구로 추가할 수 없어요!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.indigoAccent,
      textColor: Colors.white,
      fontSize: SizeConfig.defaultSize * 1.6,
    );
  }

  void shareContent(BuildContext context, String myCode) {
    // Share.share('[엔대생] 엔대생에서 내가 널 칭찬 대상으로 투표하고 싶어! 앱에 들어와줘!\n내 코드는 $myCode 야. 나를 친구 추가하고 같이하자!\nhttps://dart.page.link/TG78\n\n내 코드 : $myCode');
    Share.share('[엔대생] 대학생을 위한 네트워킹 플랫폼 엔대생! 앱에 들어와서 우리같이 과팅하자!\n https://dart.page.link/TG78\n\n내 코드 : $myCode');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () { // ModalBottomSheet 열기
        AnalyticsUtil.logEvent("내정보_마이_코드로추가버튼");
        showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            backgroundColor: Colors.white,
            isScrollControlled: true,
            builder: (BuildContext _) {
              AnalyticsUtil.logEvent("내정보_친추_접속");
              return StatefulBuilder(
                builder: (BuildContext statefulContext, StateSetter thisState) {
                  return Container(
                    height: SizeConfig.screenHeight * 0.8,
                    width: SizeConfig.screenWidth,
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
                                      AnalyticsUtil.logEvent("내정보_친추_닫기");
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
                            child: widget.disabledFunctions ? const CircularProgressIndicator(color: Color(0xffFE6059)) : null,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: SizeConfig.defaultSize * 2, right: SizeConfig.defaultSize),
                            child: Container(
                              width: SizeConfig.screenWidth * 0.9,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.white
                                    // color: Color(0xff7C83FD),
                                  ),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.center,
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
                                      Text(widget.myCode,
                                        style: TextStyle(
                                          fontSize: SizeConfig.defaultSize * 1.9,
                                        ),
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            AnalyticsUtil.logEvent("내정보_친추_내코드복사");
                                            String myCodeCopy = widget.myCode;
                                            Clipboard.setData(ClipboardData(text: myCodeCopy)); // 클립보드에 복사되었어요 <- 메시지 자동으로 Android에서 뜸 TODO : iOS는 확인하고 복사멘트 띄우기
                                          },
                                          style: ElevatedButton.styleFrom(
                                            textStyle: const TextStyle(
                                              color: Color(0xffFE6059),
                                            ),
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
                                          )),
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
                          SizedBox(height: SizeConfig.defaultSize),

                          GestureDetector(
                            onTap: () {
                              AnalyticsUtil.logEvent("내정보_친추_링크공유");
                              shareContent(context, widget.myCode);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: SizeConfig.defaultSize,
                                  right: SizeConfig.defaultSize),
                              child: Container(
                                // 친구 추가 버튼
                                width: SizeConfig.screenWidth * 0.9,
                                height: SizeConfig.defaultSize * 5.5,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: const Color(0xffFE6059),
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
                                    // color: Color(0xff7C83FD),
                                  ),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.start,
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
                                    child: Text("친구를 추가하면 과팅을 같이 할 수 있어요!",
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
                                          backgroundColor: widget.disabledFunctions ? Colors.grey.shade400 : const Color(0xffFE6059),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15), // 모서리 둥글기 설정
                                          ),
                                          padding: EdgeInsets.only(left: SizeConfig.defaultSize * 2.12, right: SizeConfig.defaultSize * 2.12),
                                        ),
                                        onPressed: () async {
                                          if (widget.disabledFunctions) {
                                            return;
                                          }
                                          String friendCodeConfirm = "";
                                          if (friendCode == widget.myCode) {
                                            ToastUtil.itsMyCodeToast("나는 친구로 추가할 수 없어요!");
                                            friendCodeConfirm = "나";
                                          }
                                          else {
                                            try {
                                              thisState(() {
                                                setState(() {
                                                  widget.disabledFunctions = true;
                                                });
                                              });

                                              await BlocProvider.of<MyPagesCubit>(context).pressedFriendCodeAddButton(friendCode);
                                              ToastUtil.showAddFriendToast("친구가 추가되었어요!");
                                              Navigator.pop(context);
                                              friendCodeConfirm = "정상";
                                            } catch (e) {
                                              ToastUtil.showToast('친구코드를 다시 한번 확인해주세요!');
                                              friendCodeConfirm = "없거나 이미 친구임";
                                            }
                                          }

                                          thisState(() {
                                            setState(() {
                                              widget.disabledFunctions = false;
                                            });
                                          });

                                          AnalyticsUtil.logEvent('내정보_친추_친구코드_추가', properties: {
                                            '친구코드 번호': friendCode, '친구코드 정상여부': friendCodeConfirm
                                          });
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
                          SizedBox(height: SizeConfig.screenHeight * 0.4,)
                        ],
                      ),
                    ),
                  );
                }
              );
            });
      },
      child: Padding(
        padding: EdgeInsets.only(
            left: SizeConfig.defaultSize,
            // right: SizeConfig.defaultSize
        ),
        child: Container(
          // 친구 추가 버튼
          height: SizeConfig.defaultSize * 3.5,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: const Color(0xffFE6059),
              border: Border.all(
                color: const Color(0xffFE6059),
              ),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: EdgeInsets.only(left: SizeConfig.defaultSize, right: SizeConfig.defaultSize),
            child: Text(
              "코드로 추가",
              style: TextStyle(
                fontSize: SizeConfig.defaultSize * 1.8,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}