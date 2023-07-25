import 'package:contextmenu/contextmenu.dart';
import 'package:dart_flutter/res/size_config.dart';
import 'package:dart_flutter/src/common/util/toast_util.dart';
import 'package:dart_flutter/src/data/model/friend.dart';
import 'package:dart_flutter/src/presentation/mypage/my_settings.dart';
import 'package:dart_flutter/src/presentation/mypage/viewmodel/mypages_cubit.dart';
import 'package:dart_flutter/src/presentation/mypage/viewmodel/state/mypages_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:share_plus/share_plus.dart';

class MyPageLanding extends StatefulWidget {
  const MyPageLanding({Key? key}) : super(key: key);

  @override
  State<MyPageLanding> createState() => _MyPageLandingState();
}

class _MyPageLandingState extends State<MyPageLanding> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: SizeConfig.defaultSize * 2,
            horizontal: SizeConfig.defaultSize),
        child: const MyPageLandingView(),
      ),
    );
  }
}

class MyPageLandingView extends StatelessWidget {

  const MyPageLandingView({
    super.key,
  });

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
              color: Color(0xff7C83FD),
              borderRadius: BorderRadius.circular(13),
              // boxShadow: [ // Boxshadow 필요하면 쓰기
              //   BoxShadow(
              //     color: Colors.grey.withOpacity(0.2),
              //     spreadRadius: 5,
              //     blurRadius: 7,
              //     offset: Offset(0, 3), // changes position of shadow
              //   ),
              // ],
            ),
            height: SizeConfig.defaultSize * 10,
            child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.defaultSize,
                    horizontal: SizeConfig.defaultSize * 1.5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row( // 1층
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BlocBuilder<MyPagesCubit,MyPagesState>(
                            builder: (context, state) {
                              String name = state.userResponse.user?.name ?? "###";
                              String admissionNumber = "${state.userResponse.user?.admissionYear.toString().substring(2,4)??"##"}학번";

                              return Row(
                                children: [
                                  SizedBox(width: SizeConfig.defaultSize * 0.5,),
                                  Text(name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: SizeConfig.defaultSize * 2,
                                      color: Colors.white,
                                    ),),
                                  SizedBox(width: SizeConfig.defaultSize * 0.5),
                                  Text(admissionNumber,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: SizeConfig.defaultSize * 1.6,
                                      color: Colors.white,
                                    ),),
                                ]
                              );
                            }
                        ),
                        IconButton(
                          icon: const Icon(Icons.settings, color: Colors.white,),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => MySettings(
                              userResponse: BlocProvider.of<MyPagesCubit>(context).state.userResponse,
                            )));
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
                              return Row(
                                children: [
                                  SizedBox(width: SizeConfig.defaultSize * 0.5,),
                                  Text(
                                    university,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: SizeConfig.defaultSize * 1.3,
                                        color: Colors.white
                                    ),
                                  ),
                                  SizedBox(width: SizeConfig.defaultSize * 0.5,),
                                  Text(
                                    department,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: SizeConfig.defaultSize * 1.3,
                                        color: Colors.white
                                    ),
                                  ),
                                ],
                              );
                            }
                        ),
                      ],
                    ),
                    SizedBox(height: SizeConfig.defaultSize,),


                    // TODO MVP 이후 '나의 포인트 0원' 복구
                    // Container(
                    //   height: SizeConfig.defaultSize * 4.5,
                    //   decoration: ShapeDecoration(
                    //     color: Color(0xffeeeeeee),
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(7.0),
                    //     ),
                    //   ),
                    //
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Row(
                    //         children: [
                    //           Text("   나의 Points",
                    //             style: TextStyle(
                    //               fontWeight: FontWeight.w500,
                    //               fontSize: SizeConfig.defaultSize * 1.6,
                    //             ),),
                    //
                    //           BlocBuilder<MyPagesCubit,MyPagesState>(
                    //               builder: (context, state) {
                    //                 int point = state.userResponse.point ?? 0;
                    //
                    //                 return Text("  $point",
                    //                   style: TextStyle(
                    //                     fontWeight: FontWeight.w700,
                    //                     fontSize: SizeConfig.defaultSize * 1.6,
                    //                   ),
                    //                 );
                    //               }
                    //           ),
                    //         ],
                    //       ),
                    //       TextButton(
                    //         onPressed: () {
                    //           // 사용 내역 페이지로 연결
                    //         },
                    //         child: Text("사용 내역 ", style: TextStyle(
                    //           fontSize: SizeConfig.defaultSize * 1.6,
                    //           fontWeight: FontWeight.w500,
                    //           decoration: TextDecoration.underline,
                    //         )),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                )
            ),
          ),
        ),

        // =================================================================

        SizedBox(height: SizeConfig.defaultSize),

        Container(
          // height: SizeConfig.defaultSize * 130,
          child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.defaultSize,
                  horizontal: SizeConfig.defaultSize * 1.5),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("내 친구",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: SizeConfig.defaultSize * 1.7,
                          color: Color(0xff7C83FD)
                        ),),
                      BlocBuilder<MyPagesCubit, MyPagesState>(
                          builder: (context, state) {
                            return openAddFriends(myCode: state.userResponse.user?.recommendationCode ?? '내 코드가 없어요!');
                          }),
                    ],
                  ),
                  SizedBox(height: SizeConfig.defaultSize * 1.5,),
                  BlocBuilder<MyPagesCubit,MyPagesState>(
                      builder: (context, state) {
                        final friends = state.friends ?? [];
                        return MyFriends(friends: friends, count: friends.length);
                      }
                  ),
                ],
              )
          ),
        ),

        Container( // 구분선
          padding: EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0,),
          height: SizeConfig.defaultSize * 2,
          color: Colors.grey.withOpacity(0.1),
        ),

        SizedBox(height: SizeConfig.defaultSize * 2,),
        Container(
          // height: SizeConfig.defaultSize * 130,
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: SizeConfig.defaultSize,
                horizontal: SizeConfig.defaultSize * 1.5),
            child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("알 수도 있는 친구",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: SizeConfig.defaultSize * 1.7,
                          color: Color(0xff7C83FD)
                        ),),
                    ],
                  ),
                  SizedBox(height: SizeConfig.defaultSize * 2 ,),
                  BlocBuilder<MyPagesCubit,MyPagesState>(
                      builder: (context, state) {
                        final friends = state.newFriends ?? [];
                        return NewFriends(friends: friends, count: friends.length);
                      }
                  ),
                ],
            ),
          ),
        ),

      ],
    );
  }
}

class MyFriends extends StatelessWidget {
  final List<Friend> friends;
  final int count;

  const MyFriends({
    super.key,
    required this.friends,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < this.count; i++)
          FriendComponent(false, friends[i], count),
      ],
    );
  }
}

class NewFriends extends StatelessWidget {
  final List<Friend> friends;
  final int count;

  const NewFriends({
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

class FriendComponent extends StatelessWidget {
  late bool isAdd;
  late Friend friend;
  late int count;

  FriendComponent(bool isAdd, Friend friend, int count, {super.key}) {
    this.isAdd = isAdd;
    this.friend = friend;
    this.count = count;
  }

  void pressedDeleteButton(BuildContext context, int userId) {
    BlocProvider.of<MyPagesCubit>(context).pressedFriendDeleteButton(friend);
  }

  void pressedAddButton(BuildContext context, int userId) {
    BlocProvider.of<MyPagesCubit>(context).pressedFriendAddButton(friend);
  }

  void showCannotAddFriendToast() {
    Fluttertoast.showToast(
      msg: "친구가 4명일 때는 삭제할 수 없어요!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Color(0xff7C83FD),
      textColor: Colors.white,
      fontSize: SizeConfig.defaultSize * 1.6,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: SizeConfig.defaultSize * 0.1,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: SizeConfig.screenWidth * 0.7,
              child: Row(
                children: [
                  Text(friend.name ?? "XXX", style: TextStyle(
                fontSize: SizeConfig.defaultSize * 1.9,
                    fontWeight: FontWeight.w600,
                  )),
                  Container(
                    width: SizeConfig.screenWidth * 0.48,
                    child: Text("  ${friend.admissionYear.toString().substring(2,4)}학번∙${friend.university?.department}", style: TextStyle(
                      fontSize: SizeConfig.defaultSize * 1.3,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis,
                    )),
                  ),
                ],
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
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('사용자를 신고하시겠어요?'),
                      content: const Text('사용자를 신고하면 Dart에서 빠르게 신고 처리를 해드려요!'),
                      backgroundColor: Colors.white,
                      surfaceTintColor: Colors.white,
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, '취소'),
                          child: const Text('취소', style: TextStyle(color: Color(0xff7C83FD)),),
                        ),
                        TextButton(
                          onPressed: () => {
                            Navigator.pop(context, '신고'),
                            ToastUtil.showToast("사용자가 신고되었어요!"),
                            // TODO : 신고 기능 (서버 연결)
                          },
                          child: const Text('신고', style: TextStyle(color: Color(0xff7C83FD)),),
                        ),
                      ],
                    ),
                  );
                }
                else if (value == 'delete') {
                  if (count >= 5) {
                    if (isAdd) {
                      pressedAddButton(context, friend.userId!);
                    } else {
                      pressedDeleteButton(context, friend.userId!);
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

            // ElevatedButton(
            //   onPressed: () {
            //     if (isAdd) {
            //       pressedAddButton(context, friend.userId!);
            //     } else {
            //       pressedDeleteButton(context, friend.userId!);
            //     }
            //   },
            //   child: Text(isAdd?"추가":"삭제", style: TextStyle(
            //     fontSize: SizeConfig.defaultSize * 1.4,
            //     fontWeight: FontWeight.w500,
            //   )),
            // ),
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

class NotFriendComponent extends StatelessWidget {
  late bool isAdd;
  late Friend friend;

  NotFriendComponent(bool isAdd, Friend friend, {super.key}) {
    this.isAdd = isAdd;
    this.friend = friend;
  }

  void pressedDeleteButton(BuildContext context, int userId) {
    BlocProvider.of<MyPagesCubit>(context).pressedFriendDeleteButton(friend);
  }

  void pressedAddButton(BuildContext context, int userId) {
    BlocProvider.of<MyPagesCubit>(context).pressedFriendAddButton(friend);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: SizeConfig.defaultSize * 0.1,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: SizeConfig.screenWidth * 0.52,
              child: Row(
                children: [
                  Text(friend.name ?? "XXX", style: TextStyle(
                    fontSize: SizeConfig.defaultSize * 1.9,
                    fontWeight: FontWeight.w600,
                  )),
                  Container(
                    width: SizeConfig.screenWidth * 0.36,
                    child: Text("  ${friend.admissionYear.toString().substring(2,4)}학번∙${friend.university?.department}", style: TextStyle(
                      fontSize: SizeConfig.defaultSize * 1.3,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis,
                    )),
                  ),
                ],
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
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      backgroundColor: Colors.white,
                      surfaceTintColor: Colors.white,
                      title: const Text('사용자를 신고하시겠어요?'),
                      content: const Text('사용자를 신고하면 Dart에서 빠르게 신고 처리를 해드려요!'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, '취소'),
                          child: const Text('취소', style: TextStyle(color: Color(0xff7C83FD)),),
                        ),
                        TextButton(
                          onPressed: () => {
                            Navigator.pop(context, '신고'),
                            ToastUtil.showToast("사용자가 신고되었어요!"),
                            // TODO : 신고 기능 (서버 연결)
                          },
                          child: const Text('신고', style: TextStyle(color: Color(0xff7C83FD)),),
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
                if (isAdd) {
                  pressedAddButton(context, friend.userId!);
                } else {
                  pressedDeleteButton(context, friend.userId!);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff7C83FD),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // 모서리 둥글기 설정
                ),
              ),
              child: Text(isAdd?"추가":"삭제", style: TextStyle(
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

class openAddFriends extends StatefulWidget {
  late String myCode;

  openAddFriends({
    super.key,
    required this.myCode,
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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            backgroundColor: Colors.white,
            isScrollControlled: true,
            builder: (BuildContext _) {
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
                          onPressed: () async {
                            if (friendCode == widget.myCode) {itsMyCodeToast();}
                            else {
                              print("friendCode $friendCode");
                              // try {
                              try {
                                await BlocProvider.of<MyPagesCubit>(context).pressedFriendCodeAddButton(friendCode);
                                showAddFriendToast();
                                Navigator.pop(context);
                              } catch (e) {
                                ToastUtil.showToast('친구코드를 다시 한번 확인해주세요!');
                              }
                            }
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
                                      Clipboard.setData(ClipboardData(text: myCodeCopy)); // 클립보드에 복사되었어요 <- 메시지 자동으로 Android에서 뜸 TODO : iOS는 확인하고 복사멘트 띄우기
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
            left: SizeConfig.defaultSize,
            // right: SizeConfig.defaultSize
        ),
        child: Container(
          // 친구 추가 버튼
          height: SizeConfig.defaultSize * 3.5,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Color(0xff7C83FD),
              ),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: EdgeInsets.only(left: SizeConfig.defaultSize, right: SizeConfig.defaultSize),
            child: Text(
              "코드로 추가",
              style: TextStyle(
                fontSize: SizeConfig.defaultSize * 1.8,
                fontWeight: FontWeight.w600,
                color: Color(0xff7C83FD),
              ),
            ),
          ),
        ),
      ),
    );
  }
}