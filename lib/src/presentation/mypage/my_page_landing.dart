import 'package:contextmenu/contextmenu.dart';
import 'package:dart_flutter/res/size_config.dart';
import 'package:dart_flutter/src/common/util/toast_util.dart';
import 'package:dart_flutter/src/data/model/friend.dart';
import 'package:dart_flutter/src/presentation/mypage/viewmodel/mypages_cubit.dart';
import 'package:dart_flutter/src/presentation/mypage/viewmodel/state/mypages_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class MyPageLanding extends StatefulWidget {
  const MyPageLanding({Key? key}) : super(key: key);

  @override
  State<MyPageLanding> createState() => _MyPageLandingState();
}

class _MyPageLandingState extends State<MyPageLanding> {
  // @override
  // void initState() {
  //   super.initState();
  //   BlocProvider.of<MyPagesCubit>(context).initPages();
  // }

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
  // User 정보

  // Friends 정보
  // final String name;
  // final int admissionNumber;
  // final String univ_name;
  // final String univ_department;
  // final bool isAdded;

  const MyPageLandingView({
    super.key,
    // required this.name,
    // required this.admissionNumber,
    // required this.univ_name,
    // required this.univ_department,
    // required this.isAdded,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
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
                  horizontal: SizeConfig.defaultSize * 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row( // 1층
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BlocBuilder<MyPagesCubit,MyPagesState>(
                          builder: (context, state) {
                            String name = state.userResponse.user?.name??"###";
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
                              ],
                            );
                          }
                      ),
                      IconButton(
                        icon: const Icon(Icons.settings, color: Colors.white,),
                        onPressed: () {
                          BlocProvider.of<MyPagesCubit>(context).pressedSettingsIcon(); // 설정 화면으로 넘어가기
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

        // =================================================================

        SizedBox(height: SizeConfig.defaultSize),
        // Container( // 구분선
        //   padding: EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0,),
        //   height: SizeConfig.defaultSize * 2,
        //   color: Colors.grey.withOpacity(0.1),
        // ),

        SizedBox(height: SizeConfig.defaultSize * 1,),
        Container(
          // height: SizeConfig.defaultSize * 130,
          child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.defaultSize,
                  horizontal: SizeConfig.defaultSize * 2),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start, // TODO : MVP 이후 복구하기 (start -> spacebetween)
                    children: [
                      Text("내 친구",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: SizeConfig.defaultSize * 1.7,
                          color: Color(0xff7C83FD)
                        ),),
                      // ElevatedButton( // TODO : MVP 이후 복구하기
                      //   onPressed: () {
                      //     // 초대하기 페이지로 연결
                      //     // BlocProvider.of<MyPagesCubit>(context).pressedInviteButton();
                      //   },
                      //   child: Text("초대하기", style: TextStyle(
                      //     fontSize: SizeConfig.defaultSize * 1.6,
                      //     fontWeight: FontWeight.w500,
                      //   )),
                      // ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.defaultSize ,),
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
                horizontal: SizeConfig.defaultSize * 2),
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
          FriendComponent(false, friends[i]),
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

  FriendComponent(bool isAdd, Friend friend, {super.key}) {
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
            Row(
              children: [
                Text(friend.name ?? "XXX", style: TextStyle(
                  fontSize: SizeConfig.defaultSize * 1.9,
                  fontWeight: FontWeight.w600,
                )),
                SizedBox(
                  width: SizeConfig.defaultSize * 16,
                  child: Text("  ${friend.admissionYear.toString().substring(2,4)}학번∙${friend.university?.department}", style: TextStyle(
                    fontSize: SizeConfig.defaultSize * 1.3,
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis,
                  )),
                ),
              ],
            ),
            SizedBox(height: SizeConfig.defaultSize,),

            IconButton(
                onPressed: () {
                  ToastUtil.showToast("사용자가 신고되었어요!");
                  // TODO : 신고 기능 (서버 연결)
                  // TODO : 신고 확정 Dialog | Popupmenu, contextmnu, QuickAlert, AlertDialog 모두 시도해봤는데 안 됨. 여기서 띄울 수 없는 것 같음.

                  // showAlert() {
                  //   QuickAlert.show(
                  //       type: QuickAlertType.confirm,
                  //       context: context,
                  //       title: "사용자를 신고하시겠어요?",
                  //       // text: "제출하면 프로필을 수정할 수 없어요!\n신중히 제출해주세요!",
                  //       confirmBtnText: '신청',
                  //       cancelBtnText: '취소',
                  //       onConfirmBtnTap: () {
                  //         ToastUtil.showToast("사용자가 신고되었어요!");
                  //         Navigator.of(context).pop(); // QuickAlert 닫기
                  //       });
                  // }

                  // ContextMenuArea(
                  //   builder: (context) => [
                  //     ListTile(
                  //       title: Text('Option 1'),
                  //       onTap: () {
                  //         Navigator.of(context).pop();
                  //         // ScaffoldMessenger.of(context).showSnackBar(
                  //         //   SnackBar(
                  //         //     content: Text('Whatever'),
                  //         //   ),
                  //         // );
                  //       },
                  //     ),
                  //     ListTile(
                  //       leading: Icon(Icons.model_training),
                  //       title: Text('Option 2'),
                  //       onTap: () {
                  //         Navigator.of(context).pop();
                  //         // ScaffoldMessenger.of(context).showSnackBar(
                  //         //   SnackBar(
                  //         //     content: Text('Foo!'),
                  //         //   ),
                  //         // );
                  //       },
                  //     )
                  //   ],
                  //   child: Card(
                  //     color: Theme.of(context).primaryColor,
                  //     child: Center(
                  //       child: Text(
                  //         'Press somewhere for context menu.',
                  //         style: TextStyle(
                  //           color: Theme.of(context).colorScheme.onPrimary,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // );

                  // showCupertinoModalPopup(context: context, builder: (BuildContext context) => CupertinoActionSheet(
                  //   title: Text("사용자를 신고하시겠어요?"),
                  //   actions: <CupertinoActionSheetAction>[
                  //     CupertinoActionSheetAction(
                  //         onPressed: () {
                  //           Navigator.pop(context);
                  //           // TODO: 신고 기능 (서버 연결)
                  //           ToastUtil.showToast("사용자가 신고되었습니다!");
                  //         },
                  //         child: Text("신고하기", style: TextStyle(color: Colors.redAccent))
                  //     ),
                  //     CupertinoActionSheetAction(
                  //         onPressed: () {
                  //           Navigator.pop(context);
                  //           // TODO: 신고 기능 (서버 연결)
                  //         },
                  //         child: Text("취소", style: TextStyle(color: Colors.indigoAccent),)
                  //     )
                  //   ],
                  // ));

                  // showDialog(
                  //   context: context,
                  //   builder: (BuildContext context) {
                  //     return CupertinoAlertDialog(
                  //       title: Text("사용자 신고"),
                  //       content: Text("이 사용자를 신고하시겠습니까?"),
                  //       actions: [
                  //         TextButton(
                  //           onPressed: () {
                  //             Navigator.of(context).pop(); // 다이얼로그 닫기
                  //             // TODO: 신고 기능 (서버 연결)
                  //             ToastUtil.showToast("사용자가 신고되었습니다!");
                  //           },
                  //           child: Text("신고하기"),
                  //         ),
                  //         TextButton(
                  //           onPressed: () {
                  //             Navigator.of(context).pop(); // 다이얼로그 닫기
                  //           },
                  //           child: Text("취소"),
                  //         ),
                  //       ],
                  //     );
                  //     print("printprint");
                  //   },
                  // );
                },
                icon: Icon(Icons.warning_rounded, color: Colors.grey.shade200)),

            ElevatedButton(
              onPressed: () {
                if (isAdd) {
                  pressedAddButton(context, friend.userId!);
                } else {
                  pressedDeleteButton(context, friend.userId!);
                }
              },
              child: Text(isAdd?"추가":"삭제", style: TextStyle(
                fontSize: SizeConfig.defaultSize * 1.4,
                fontWeight: FontWeight.w500,
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
            Row(
              children: [
                Text(friend.name ?? "XXX", style: TextStyle(
                  fontSize: SizeConfig.defaultSize * 1.9,
                  fontWeight: FontWeight.w600,
                )),
                SizedBox(
                  width: SizeConfig.defaultSize * 16,
                  child: Text("  ${friend.admissionYear.toString().substring(2,4)}학번∙${friend.university?.department}", style: TextStyle(
                    fontSize: SizeConfig.defaultSize * 1.3,
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis,
                  )),
                ),
              ],
            ),
            SizedBox(height: SizeConfig.defaultSize,),

            IconButton(
                onPressed: () {
                  ToastUtil.showToast("사용자가 신고되었어요!");
                  // TODO : 신고 기능 (서버 연결)
                  // TODO : 신고 확정 Dialog | Popupmenu, contextmnu, QuickAlert, AlertDialog 모두 시도해봤는데 안 됨. 여기서 띄울 수 없는 것 같음.

                  // showAlert() {
                  //   QuickAlert.show(
                  //       type: QuickAlertType.confirm,
                  //       context: context,
                  //       title: "사용자를 신고하시겠어요?",
                  //       // text: "제출하면 프로필을 수정할 수 없어요!\n신중히 제출해주세요!",
                  //       confirmBtnText: '신청',
                  //       cancelBtnText: '취소',
                  //       onConfirmBtnTap: () {
                  //         ToastUtil.showToast("사용자가 신고되었어요!");
                  //         Navigator.of(context).pop(); // QuickAlert 닫기
                  //       });
                  // }

                  // ContextMenuArea(
                  //   builder: (context) => [
                  //     ListTile(
                  //       title: Text('Option 1'),
                  //       onTap: () {
                  //         Navigator.of(context).pop();
                  //         // ScaffoldMessenger.of(context).showSnackBar(
                  //         //   SnackBar(
                  //         //     content: Text('Whatever'),
                  //         //   ),
                  //         // );
                  //       },
                  //     ),
                  //     ListTile(
                  //       leading: Icon(Icons.model_training),
                  //       title: Text('Option 2'),
                  //       onTap: () {
                  //         Navigator.of(context).pop();
                  //         // ScaffoldMessenger.of(context).showSnackBar(
                  //         //   SnackBar(
                  //         //     content: Text('Foo!'),
                  //         //   ),
                  //         // );
                  //       },
                  //     )
                  //   ],
                  //   child: Card(
                  //     color: Theme.of(context).primaryColor,
                  //     child: Center(
                  //       child: Text(
                  //         'Press somewhere for context menu.',
                  //         style: TextStyle(
                  //           color: Theme.of(context).colorScheme.onPrimary,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // );

                  // showCupertinoModalPopup(context: context, builder: (BuildContext context) => CupertinoActionSheet(
                  //   title: Text("사용자를 신고하시겠어요?"),
                  //   actions: <CupertinoActionSheetAction>[
                  //     CupertinoActionSheetAction(
                  //         onPressed: () {
                  //           Navigator.pop(context);
                  //           // TODO: 신고 기능 (서버 연결)
                  //           ToastUtil.showToast("사용자가 신고되었습니다!");
                  //         },
                  //         child: Text("신고하기", style: TextStyle(color: Colors.redAccent))
                  //     ),
                  //     CupertinoActionSheetAction(
                  //         onPressed: () {
                  //           Navigator.pop(context);
                  //           // TODO: 신고 기능 (서버 연결)
                  //         },
                  //         child: Text("취소", style: TextStyle(color: Colors.indigoAccent),)
                  //     )
                  //   ],
                  // ));

                  // showDialog(
                  //   context: context,
                  //   builder: (BuildContext context) {
                  //     return CupertinoAlertDialog(
                  //       title: Text("사용자 신고"),
                  //       content: Text("이 사용자를 신고하시겠습니까?"),
                  //       actions: [
                  //         TextButton(
                  //           onPressed: () {
                  //             Navigator.of(context).pop(); // 다이얼로그 닫기
                  //             // TODO: 신고 기능 (서버 연결)
                  //             ToastUtil.showToast("사용자가 신고되었습니다!");
                  //           },
                  //           child: Text("신고하기"),
                  //         ),
                  //         TextButton(
                  //           onPressed: () {
                  //             Navigator.of(context).pop(); // 다이얼로그 닫기
                  //           },
                  //           child: Text("취소"),
                  //         ),
                  //       ],
                  //     );
                  //     print("printprint");
                  //   },
                  // );
                },
                icon: Icon(Icons.warning_rounded, color: Colors.grey.shade200)),

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