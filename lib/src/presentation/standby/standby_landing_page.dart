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

class _StandbyLandingPageState extends State<StandbyLandingPage> {
  // List friends = [true, false, false, false];

  @override
  Widget build(BuildContext context) {
    List<Friend> friends = FriendsMock().getFriends();
    int count = friends.length;
    // TODO MVP HOTFIX : count가 4 이상이면 DartPageView로 보내기

    return Scaffold(
      backgroundColor: Colors.indigoAccent,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: SizeConfig.screenHeight * 0.1,
            ),
            Text(
              "     반가워요!",
              style: TextStyle(
                fontSize: SizeConfig.defaultSize * 2.2,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.005,
            ),
            Text(
              "      친구 4명부터 이미지게임을 시작할 수 있어요!",
              style: TextStyle(
                fontSize: SizeConfig.defaultSize * 1.8,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: SizeConfig.defaultSize * 3,
            ),
            Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight * 0.8,
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
                      Text(
                        "\n\n내가 제일 친하다고 생각하는 친구는?",
                        style: TextStyle(
                          fontSize: SizeConfig.defaultSize * 2,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ),
                      ),

                      SizedBox(height: SizeConfig.defaultSize * 4),
                      Image.asset(
                        'assets/images/dart_logo.png',
                        width: 150,
                        height: 150,
                      ),
                      SizedBox(height: SizeConfig.defaultSize * 4),

                      Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.defaultSize * 1.1,
                            right: SizeConfig.defaultSize * 0.3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            friends[0] != null
                                ? Container(
                                    // 친구 있을 때
                                    width: SizeConfig.screenWidth * 0.41,
                                    height: SizeConfig.defaultSize * 8,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.indigoAccent,
                                        border: Border.all(
                                          color: Colors.indigoAccent,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/images/check_circle.png',
                                              width: SizeConfig.defaultSize * 2,
                                              height:
                                                  SizeConfig.defaultSize * 2,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              width:
                                                  SizeConfig.defaultSize * 0.5,
                                            ),
                                            Text("완료!",
                                                style: TextStyle(
                                                  fontSize:
                                                      SizeConfig.defaultSize *
                                                          1.6,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                )),
                                          ],
                                        ),
                                        SizedBox(
                                          height: SizeConfig.defaultSize * 0.2,
                                        ),
                                        Text(
                                          "21학번 장세연",
                                          style: TextStyle(
                                            fontSize:
                                                SizeConfig.defaultSize * 1.8,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ))
                                : Container(
                                    // 친구 없을 때
                                    width: SizeConfig.screenWidth * 0.41,
                                    height: SizeConfig.defaultSize * 8,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "비어있어요!",
                                      style: TextStyle(
                                        fontSize: SizeConfig.defaultSize * 1.8,
                                      ),
                                    ),
                                  ),
                            friends[1] == true
                                ? Container(
                                    width: SizeConfig.screenWidth * 0.41,
                                    height: SizeConfig.defaultSize * 8,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.indigoAccent,
                                        border: Border.all(
                                          color: Colors.indigoAccent,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/images/check_circle.png',
                                              width: SizeConfig.defaultSize * 2,
                                              height:
                                                  SizeConfig.defaultSize * 2,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              width:
                                                  SizeConfig.defaultSize * 0.5,
                                            ),
                                            Text("완료!",
                                                style: TextStyle(
                                                  fontSize:
                                                      SizeConfig.defaultSize *
                                                          1.6,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                )),
                                          ],
                                        ),
                                        SizedBox(
                                          height: SizeConfig.defaultSize * 0.2,
                                        ),
                                        Text(
                                          "21학번 장세연",
                                          style: TextStyle(
                                            fontSize:
                                                SizeConfig.defaultSize * 1.8,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ))
                                : Container(
                                    // 친구 없을 때
                                    width: SizeConfig.screenWidth * 0.41,
                                    height: SizeConfig.defaultSize * 8,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "비어있어요!",
                                      style: TextStyle(
                                        fontSize: SizeConfig.defaultSize * 1.8,
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      SizedBox(height: SizeConfig.defaultSize * 1),
                      Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.defaultSize * 1.1,
                            right: SizeConfig.defaultSize * 0.3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            friends[2] == true
                                ? Container(
                                    // 친구 있을 때
                                    width: SizeConfig.screenWidth * 0.41,
                                    height: SizeConfig.defaultSize * 8,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.indigoAccent,
                                        border: Border.all(
                                          color: Colors.indigoAccent,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/images/check_circle.png',
                                              width: SizeConfig.defaultSize * 2,
                                              height:
                                                  SizeConfig.defaultSize * 2,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              width:
                                                  SizeConfig.defaultSize * 0.5,
                                            ),
                                            Text("완료!",
                                                style: TextStyle(
                                                  fontSize:
                                                      SizeConfig.defaultSize *
                                                          1.6,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                )),
                                          ],
                                        ),
                                        SizedBox(
                                          height: SizeConfig.defaultSize * 0.2,
                                        ),
                                        Text(
                                          "21학번 장세연",
                                          style: TextStyle(
                                            fontSize:
                                                SizeConfig.defaultSize * 1.8,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ))
                                : Container(
                                    // 친구 없을 때
                                    width: SizeConfig.screenWidth * 0.41,
                                    height: SizeConfig.defaultSize * 8,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "비어있어요!",
                                      style: TextStyle(
                                        fontSize: SizeConfig.defaultSize * 1.8,
                                      ),
                                    ),
                                  ),
                            friends[3] == true
                                ? Container(
                                    width: SizeConfig.screenWidth * 0.41,
                                    height: SizeConfig.defaultSize * 8,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.indigoAccent,
                                        border: Border.all(
                                          color: Colors.indigoAccent,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/images/check_circle.png',
                                              width: SizeConfig.defaultSize * 2,
                                              height:
                                                  SizeConfig.defaultSize * 2,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              width:
                                                  SizeConfig.defaultSize * 0.5,
                                            ),
                                            Text("완료!",
                                                style: TextStyle(
                                                  fontSize:
                                                      SizeConfig.defaultSize *
                                                          1.6,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                )),
                                          ],
                                        ),
                                        SizedBox(
                                          height: SizeConfig.defaultSize * 0.2,
                                        ),
                                        Text(
                                          "21학번 장세연",
                                          style: TextStyle(
                                            fontSize:
                                                SizeConfig.defaultSize * 1.8,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ))
                                : Container(
                                    // 친구 없을 때
                                    width: SizeConfig.screenWidth * 0.41,
                                    height: SizeConfig.defaultSize * 8,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "비어있어요!",
                                      style: TextStyle(
                                        fontSize: SizeConfig.defaultSize * 1.8,
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: SizeConfig.defaultSize * 5,
                      ),
                      Text(
                        "위의 예시 질문처럼 이미지게임을 할 거예요!",
                        style: TextStyle(
                          fontSize: SizeConfig.defaultSize * 1.4,
                        ),
                      ),
                      Text(
                        "선택지로 고르고 싶은 친구들을 초대하고 추가하세요!",
                        style: TextStyle(
                          fontSize: SizeConfig.defaultSize * 1.4,
                        ),
                      ),
                      SizedBox(height: SizeConfig.defaultSize * 0.9),

                      openAddFriends(),

                      Container(
                        height: SizeConfig.defaultSize * 5,
                        color: Colors.white,
                      ),
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
}

// modal bottom View
class openAddFriends extends StatefulWidget {
  const openAddFriends({
    super.key,
  });

  @override
  State<openAddFriends> createState() => _openAddFriendsState();
}

class _openAddFriendsState extends State<openAddFriends> {
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

  void shareContent(BuildContext context) {
    Share.share(
        '앱에서 친구들이 당신에게 관심을 표현하고 있어요! 들어와서 확인해보세요! https://dart.page.link/TG78');
    print("셰어");
  }

  @override
  Widget build(BuildContext context) {
    var friendCode = "";

    return InkWell(
      // ModalBottomSheet 열기
      onTap: () {
        showModalBottomSheet(
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            backgroundColor: Colors.white,
            isScrollControlled: true,
            builder: (context) {
              return Container(
                height: SizeConfig.screenHeight,
                width: SizeConfig.screenWidth,
                child: Column(
                  children: [
                    SizedBox(height: SizeConfig.screenHeight * 0.15),
                    Text("친구를 추가해요!",
                        style: TextStyle(
                          color: Colors.indigoAccent,
                          fontSize: SizeConfig.defaultSize * 2.2,
                          fontWeight: FontWeight.w600,
                        )),
                    SizedBox(height: SizeConfig.defaultSize * 7),
                    // BlocBuilder<StandbyCubit,StandbyState>(
                    //     builder: (context, state) {
                    //       final friends = state.friends ?? [];
                    //       return MeetMyFriends(friends: friends, count: friends.length);
                    //     }
                    // ),
                    Text("친구 코드 입력",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: SizeConfig.defaultSize * 2,
                          fontWeight: FontWeight.w600,
                        )),
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
                          onPressed: () {
                            BlocProvider.of<StandbyCubit>(context)
                                .pressedFriendCodeAddButton(
                                    friendCode); // TODO MVP HOTFIX : mockup으로 테스트했는데, 코드로 친구 추가 로직 테스트하기
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.indigoAccent,
                              onPrimary: Colors.white,
                              textStyle: TextStyle(
                                color: Colors.white,
                              )),
                          child: Text("추가"),
                        )
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
                          Container(
                            width: SizeConfig.screenWidth * 0.8,
                            height: SizeConfig.defaultSize * 3.3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // BlocBuilder<StandbyCubit, StandbyState>(
                                //   builder: (context, state) {
                                //     String userCode = state.userResponse.userId.toString()??"##";
                                //     return Text(userCode, style: TextStyle(
                                //       fontSize: SizeConfig.defaultSize * 2,
                                //     ),);
                                //   }
                                // ),
                                Text(
                                  '초대코드 텍스트',
                                  style: TextStyle(
                                    fontSize: SizeConfig.defaultSize * 2,
                                  ),
                                ),

                                SizedBox(
                                  width: SizeConfig.defaultSize,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      String myCodeCopy =
                                          '초대코드 텍스트'; // TODO MVP HOTFIX : 본인 코드 텍스트넣기
                                      Clipboard.setData(ClipboardData(
                                          text:
                                              myCodeCopy)); // TODO MVP HOTFIX : 본인 코드 텍스트넣기
                                      showCopyToast();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.white,
                                      onPrimary: Colors.indigoAccent,
                                      textStyle: TextStyle(
                                        color: Colors.indigoAccent,
                                      ),
                                      // minimumSize: Size(SizeConfig.defaultSize * 15, SizeConfig.defaultSize * 15),
                                    ),
                                    child: Text(
                                      "복사하기",
                                      style: TextStyle(
                                        fontSize: SizeConfig.defaultSize * 1.8,
                                      ),
                                    )),
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
                        ))
                  ],
                ),
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
