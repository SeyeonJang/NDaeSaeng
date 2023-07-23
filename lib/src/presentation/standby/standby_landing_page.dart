import 'package:dart_flutter/src/common/util/toast_util.dart';
import 'package:dart_flutter/src/presentation/page_view.dart';
import 'package:dart_flutter/src/presentation/standby/viewmodel/standby_cubit.dart';
import 'package:dart_flutter/src/presentation/standby/viewmodel/state/standby_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../res/size_config.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/services.dart';

import '../../data/model/friend.dart';
import '../mypage/friends_mock.dart';

class StandbyLandingPage extends StatefulWidget {
  const StandbyLandingPage({
    super.key,
  });

  @override
  State<StandbyLandingPage> createState() => _StandbyLandingPageState();
}

class _StandbyLandingPageState extends State<StandbyLandingPage> with SingleTickerProviderStateMixin{
  final StandbyCubit _standbyCubit = StandbyCubit();
  bool _isUp = true;
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _animation = Tween<Offset>(
      begin: Offset(0,0.15),
      end: Offset(0,0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _isUp = !_isUp;
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _isUp = !_isUp;
        _controller.forward();
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff7C83FD),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: SizeConfig.screenHeight * 0.05,
              ),
              Container(
                width: SizeConfig.screenWidth,
                padding: EdgeInsets.only(left: SizeConfig.screenWidth * 0.07),
                child: Text(
                  "반가워요!",
                  style: TextStyle(
                    fontSize: SizeConfig.defaultSize * 2.5,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.011,
              ),
              Container(
                width: SizeConfig.screenWidth,
                padding: EdgeInsets.only(left: SizeConfig.screenWidth * 0.07),
                child: Text(
                  "친구 4명부터 이미지게임을 시작할 수 있어요!",
                  style: TextStyle(
                    fontSize: SizeConfig.defaultSize * 1.9,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.defaultSize * 3,
              ),
              Container(
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight * 0.82,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25),
                      topLeft: Radius.circular(25)),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: SizeConfig.defaultSize * 2.5,
                      right: SizeConfig.defaultSize * 2.5),
                  child: Center(
                    child: Column(
                      children: [
                        // ßSizedBox(height: SizeConfig.screenHeight),
                        SizedBox(height: SizeConfig.defaultSize * 0.4,),
                        Text(
                          "\n내가 제일 친하다고 생각하는 친구는?",
                          style: TextStyle(
                            fontSize: SizeConfig.defaultSize * 2.2,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),

                        SizedBox(height: SizeConfig.defaultSize ),
                        // Image.asset(
                        //   'assets/images/dart_logo.png',
                        //   width: SizeConfig.defaultSize * 15.5,
                        //   height: SizeConfig.defaultSize * 15.5,
                        // ),
                        Container(
                          alignment: Alignment.center,
                          child: SlideTransition(
                            position: _animation,
                            child: Image.asset(
                              'assets/images/letter.png',
                              width: SizeConfig.defaultSize * 25,
                            ),
                          ),
                        ),
                        // SizedBox(height: SizeConfig.defaultSize * 1.5),
                        BlocBuilder<StandbyCubit, StandbyState>(
                            builder: (context, state) {
                              if (state.isLoading) {
                                return CircularProgressIndicator();
                              }
                              else {
                                List<Friend> friends = state.addedFriends;
                                int count = friends.length;
                                if (count >= 4) {
                                  WidgetsBinding.instance.addPostFrameCallback((_) {
                                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const DartPageView()), (route) => false);
                                  });
                                }
                                return Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: SizeConfig.defaultSize * 1.1,
                                          right: SizeConfig.defaultSize * 0.3),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          count >= 1
                                              ? FriendExistsView(
                                                  userName: friends[0].name,
                                                  admissionYear: friends[0].admissionYear.toString().substring(2, 4),)
                                              : FriendNotExistsView(),
                                          count >= 2
                                              ? FriendExistsView(
                                                  userName: friends[1].name,
                                                  admissionYear: friends[1].admissionYear.toString().substring(2, 4),)
                                              : FriendNotExistsView(),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: SizeConfig.defaultSize * 1),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: SizeConfig.defaultSize * 1.1,
                                          right: SizeConfig.defaultSize * 0.3),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          count >= 3
                                              ? FriendExistsView(
                                                  userName: friends[2].name,
                                                  admissionYear: friends[2].admissionYear.toString().substring(2, 4),)
                                              : FriendNotExistsView(),
                                          count >= 4
                                              ? FriendExistsView(
                                                  userName: friends[3].name,
                                                  admissionYear: friends[3].admissionYear.toString().substring(2, 4),)
                                              : FriendNotExistsView(),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }
                        }),

                        SizedBox(
                          height: SizeConfig.defaultSize * 3,
                        ),
                        Text(
                          "위의 예시 질문처럼 이미지게임을 할 거예요!",
                          style: TextStyle(
                            fontSize: SizeConfig.defaultSize * 1.5,
                          ),
                        ),
                        SizedBox(height: SizeConfig.defaultSize * 0.3,),
                        Text(
                          "선택지로 고르고 싶은 친구들을 추가하세요!",
                          style: TextStyle(
                            fontSize: SizeConfig.defaultSize * 1.5,
                          ),
                        ),
                        SizedBox(height: SizeConfig.defaultSize * 1),

                        BlocBuilder<StandbyCubit, StandbyState>(
                          builder: (context, state) {
                            return openAddFriends(
                                myCode: state.userResponse.user?.recommendationCode ?? '내 코드가 없어요!',
                                disabledFunctions: state.isLoading,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: SizeConfig.defaultSize * 2,
                color: Colors.white,
              ),
            ],
          ),
        ));
  }
}

class FriendNotExistsView extends StatelessWidget {
  const FriendNotExistsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // 친구 없음 | 비어있어요!
    return GestureDetector(
      onTap: () {
        // TODO : 눌렀을 떄 ModalBottomSheet 뜨도록 하기 (현식오빠 수정 버전으로)
      },
      child: Container(
        // 친구 없을 때
        width: SizeConfig.screenWidth * 0.4,
        height: SizeConfig.defaultSize * 8,
        decoration: BoxDecoration(
            color: Colors.grey[300], borderRadius: BorderRadius.circular(15)),
        // decoration: BoxDecoration(
        //     border: Border.all(
        //       color: Colors.grey.shade400,
        //       width: 1.3,
        //     ),
        //     borderRadius: BorderRadius.circular(15)),
        alignment: Alignment.center,
        child: Text(
          "눌러서 친구추가",
          style: TextStyle(
            fontSize: SizeConfig.defaultSize * 1.8,
          ),
        ),
      ),
    );
  }
}

class FriendExistsView extends StatelessWidget {
  // 친구 존재 | 학번, 이름
  final String? userName;
  final String? admissionYear;

  const FriendExistsView(
      {super.key, required this.userName, required this.admissionYear});

  @override
  Widget build(BuildContext context) {
    return Container(
        // 친구 있을 때
        width: SizeConfig.screenWidth * 0.4,
        height: SizeConfig.defaultSize * 8,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Color(0xff7C83FD),
            border: Border.all(
              color: Color(0xff7C83FD),
            ),
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/check_circle.png',
                  width: SizeConfig.defaultSize * 2,
                  height: SizeConfig.defaultSize * 2,
                  color: Colors.white,
                ),
                SizedBox(
                  width: SizeConfig.defaultSize * 0.5,
                ),
                Text("완료!",
                    style: TextStyle(
                      fontSize: SizeConfig.defaultSize * 1.6,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    )),
              ],
            ),
            SizedBox(
              height: SizeConfig.defaultSize * 0.2,
            ),
            Text(
              "$admissionYear학번 $userName",
              style: TextStyle(
                fontSize: SizeConfig.defaultSize * 1.8,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ));
  }
}

// modal bottom View
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

  void shareContent(BuildContext context) {
    Share.share(
        '앱에서 친구들이 당신에게 관심을 표현하고 있어요! 들어와서 확인해보세요! https://dart.page.link/TG78');
    print("셰어");
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () { // ModalBottomSheet 열기
        showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            backgroundColor: Colors.white,
            isScrollControlled: true,
            builder: (BuildContext _) {
              return StatefulBuilder(
                builder: (BuildContext statefulContext, StateSetter thisState) {
                  return Container(
                    height: SizeConfig.screenHeight,
                    width: SizeConfig.screenWidth,
                    child: Column(
                      children: [
                        SizedBox(height: SizeConfig.screenHeight * 0.15),
                        Text("친구를 추가해요!",
                            style: TextStyle(
                              color: Color(0xff7C83FD),
                              fontSize: SizeConfig.defaultSize * 2.2,
                              fontWeight: FontWeight.w600,
                            ),
                        ),
                        SizedBox(height: SizeConfig.defaultSize * 2),
                        SizedBox(
                            width: SizeConfig.defaultSize * 3,
                            height: SizeConfig.defaultSize * 3,
                            child: widget.disabledFunctions ? const CircularProgressIndicator() : null,
                        ),
                        SizedBox(height: SizeConfig.defaultSize * 2),
                        Text("친구 코드 입력",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: SizeConfig.defaultSize * 2,
                              fontWeight: FontWeight.w600,
                            ),
                        ),
                        SizedBox(
                          height: SizeConfig.defaultSize * 2,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: SizeConfig.screenWidth * 0.7,
                              child: TextField(
                                onChanged: (text) {
                                  friendCode = text;
                                },
                                autocorrect: true,
                                decoration: InputDecoration(
                                  hintText: '친구 코드를 여기에 입력해주세요!',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: SizeConfig.defaultSize * 1.5,
                                      horizontal: SizeConfig.defaultSize * 1.5),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                                    borderSide:
                                    BorderSide(color: Colors.grey, width: 2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                    borderSide:
                                    BorderSide(color: Colors.indigoAccent),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: SizeConfig.defaultSize * 0.7,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: widget.disabledFunctions ? Colors.grey : Colors.blueAccent,
                              ),
                              onPressed: () async {
                                // 친구추가 중인 경우 버튼 동작 X
                                if (widget.disabledFunctions) {
                                  return;
                                }

                                if (friendCode == widget.myCode) {
                                  itsMyCodeToast();
                                }
                                else {
                                  print("friendCode $friendCode");
                                  // try {
                                  try {
                                    // ModalBottomSheet 상태 update를 위해 필요함
                                    thisState(() {
                                      setState(() {
                                        widget.disabledFunctions = true;
                                      });
                                    });

                                    // 실제 친구 추가 동작
                                    await BlocProvider.of<StandbyCubit>(context).pressedFriendCodeAddButton(friendCode);
                                    await Future.delayed(Duration(seconds: 3));
                                    showAddFriendToast();
                                    Navigator.pop(context);
                                  } catch (e) {
                                    print(e);
                                    ToastUtil.showToast('친구코드를 다시 한번 확인해주세요!');
                                  }

                                  thisState(() {
                                    setState(() {
                                      widget.disabledFunctions = false;
                                    });
                                  });
                                }
                              },
                              child: Text("추가", style: TextStyle(color: Colors.white)),
                            ),
                            // widget.disabledFunctions ? CircularProgressIndicator() : SizedBox(),
                          ],
                        ),

                        SizedBox(
                          height: SizeConfig.defaultSize * 3,
                        ),

                        Container(
                          color: Colors.indigoAccent.withOpacity(0.3),
                          width: SizeConfig.screenWidth,
                          height: SizeConfig.defaultSize * 12,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("내 코드",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: SizeConfig.defaultSize * 2,
                                    fontWeight: FontWeight.w600,
                                  )),
                              SizedBox(
                                height: SizeConfig.defaultSize * 2,
                              ),
                              Container( //exp. 내 코드 복사 Views
                                width: SizeConfig.screenWidth * 0.8,
                                height: SizeConfig.defaultSize * 3.3,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(widget.myCode,
                                      style: TextStyle(
                                        fontSize: SizeConfig.defaultSize * 2,
                                      ),
                                    ),
                                    SizedBox(
                                      width: SizeConfig.defaultSize,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        String myCodeCopy = widget.myCode;
                                        Clipboard.setData(ClipboardData(
                                            text: myCodeCopy)); // 클립보드에 복사되었어요 <- 메시지 자동으로 Android에서 뜸 TODO : iOS는 확인하고 복사멘트 띄우기
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.white,
                                        onPrimary: Colors.indigoAccent,
                                        textStyle: TextStyle(
                                          color: Colors.indigoAccent,
                                        ),
                                      ),
                                      child: Text(
                                        "복사하기",
                                        style: TextStyle(
                                          fontSize: SizeConfig.defaultSize * 1.8,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: SizeConfig.defaultSize * 5),

                        GestureDetector(
                          onTap: () {
                            shareContent(context);
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
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.indigoAccent,
                                  ),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Text(
                                "아직 가입하지 않은 친구 초대하기",
                                style: TextStyle(
                                  fontSize: SizeConfig.defaultSize * 1.8,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.indigoAccent,
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: SizeConfig.defaultSize * 10),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "닫기",
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: SizeConfig.defaultSize * 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            });
      },
      child: Padding(
        padding: EdgeInsets.only(
            left: SizeConfig.defaultSize, right: SizeConfig.defaultSize),
        child: Container(
          // 친구 추가 버튼
          width: SizeConfig.screenWidth * 0.9,
          height: SizeConfig.defaultSize * 5.5,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.indigoAccent,
              ),
              borderRadius: BorderRadius.circular(15)),
          child: Text(
            "선택지에 친구 넣기",
            style: TextStyle(
              fontSize: SizeConfig.defaultSize * 1.8,
              fontWeight: FontWeight.w800,
              color: Colors.indigoAccent,
            ),
          ),
        ),
      ),
    );
  }
}
