import 'package:dart_flutter/src/presentation/mypage/friends_mock.dart';
import 'package:dart_flutter/src/presentation/mypage/my_settings.dart';
import 'package:dart_flutter/src/presentation/mypage/viewmodel/mypages_cubit.dart';
import 'package:dart_flutter/src/presentation/mypage/viewmodel/state/mypages_state.dart';
import 'package:flutter/material.dart';
import 'package:dart_flutter/src/data/model/friend.dart';
import 'package:dart_flutter/res/size_config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        SizedBox(height: SizeConfig.defaultSize * 0.5,),
        Container(
          height: SizeConfig.defaultSize * 13,
          child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.defaultSize,
                  horizontal: SizeConfig.defaultSize * 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      BlocBuilder<MyPagesCubit,MyPagesState>(
                          builder: (context, state) {
                            String department = state.userResponse.department!;
                            return Text(
                              department,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: SizeConfig.defaultSize * 1.15,
                              ),
                            );
                          }
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BlocBuilder<MyPagesCubit,MyPagesState>(
                          builder: (context, state) {
                            String name = state.userResponse.name!;
                            String admissionNumber = "${state.userResponse.admissionNumber??"##"}학번";

                            return Row(
                              children: [
                                Text(name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: SizeConfig.defaultSize * 2,
                                  ),),
                                const SizedBox(width: 5),
                                Text(admissionNumber,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: SizeConfig.defaultSize * 1.6,
                                  ),),
                              ],
                            );
                          }
                      ),
                      IconButton(
                        icon: const Icon(Icons.settings),
                        onPressed: () {
                          BlocProvider.of<MyPagesCubit>(context).pressedSettingsIcon(); // 설정 화면으로 넘어가기
                        },
                        iconSize: SizeConfig.defaultSize * 2.4,
                      ),
                    ],
                  ),
                  Container(
                    decoration: ShapeDecoration(
                      color: Color(0xffeeeeeee),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text("   나의 Points",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: SizeConfig.defaultSize * 1.6,
                              ),),

                            BlocBuilder<MyPagesCubit,MyPagesState>(
                                builder: (context, state) {
                                  int point = state.userResponse.point ?? 0;

                                  return Text("  $point",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: SizeConfig.defaultSize * 1.6,
                                    ),
                                  );
                                }
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            // 사용 내역 페이지로 연결
                          },
                          child: Text("사용 내역 ", style: TextStyle(
                            fontSize: SizeConfig.defaultSize * 1.6,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                          )),
                        ),
                      ],
                    ),
                  ),
                ],
              )
          ),
        ),

        // =================================================================

        Container( // 구분선
          padding: EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0,),
          height: SizeConfig.defaultSize * 2,
          color: Colors.grey.withOpacity(0.1),
        ),

        SizedBox(height: SizeConfig.defaultSize * 0.5,),
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
                      Text("내 친구",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: SizeConfig.defaultSize * 1.6,
                        ),),
                      ElevatedButton(
                        onPressed: () {
                          // 초대하기 페이지로 연결
                          // BlocProvider.of<MyPagesCubit>(context).pressedInviteButton();
                        },
                        child: Text("초대하기", style: TextStyle(
                          fontSize: SizeConfig.defaultSize * 1.6,
                          fontWeight: FontWeight.w500,
                        )),
                      ),
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

        // =================================================================

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
                          fontSize: SizeConfig.defaultSize * 1.6,
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
                ]),
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
          FriendComponent(
              isAdd: false,
              userId: friends[i].userId,
              name: friends[i].name,
              admissionNumber:friends[i].admissionNumber,
              department: friends[i].university.department),
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
        for (int i = 0; i < this.count; i++)
          FriendComponent(
              isAdd: true,
              userId: friends[i].userId,
              name: friends[i].name,
              admissionNumber:friends[i].admissionNumber,
              department: friends[i].university.department),
      ],
    );
  }
}

class FriendComponent extends StatelessWidget {
  final bool isAdd;
  final int userId;
  final String name;
  final int admissionNumber;
  final String department;

  const FriendComponent({
    super.key,
    required this.isAdd,
    required this.userId,
    required this.name,
    required this.admissionNumber,
    required this.department,
  });

  void pressedDeleteButton(BuildContext context, int userId) {
    BlocProvider.of<MyPagesCubit>(context).pressedFriendDeleteButton(userId);
  }

  void pressedAddButton(BuildContext context, int userId) {
    BlocProvider.of<MyPagesCubit>(context).pressedFriendAddButton(userId);
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
                Text("$name", style: TextStyle(
                  fontSize: SizeConfig.defaultSize * 1.9,
                  fontWeight: FontWeight.w600,
                )),
                SizedBox(
                  child: Text("  $admissionNumber학번∙$department", style: TextStyle(
                    fontSize: SizeConfig.defaultSize * 1.3,
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis,
                  )),
                  width: SizeConfig.defaultSize * 16,
                ),
              ],
            ),
            SizedBox(height: SizeConfig.defaultSize,),

            TextButton(
              onPressed: () {
                // TODO : 신고 기능
              },
              child: Text("신고", style: TextStyle(
                fontSize: SizeConfig.defaultSize * 1.3,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline,
                color: Colors.grey,
              )),
            ),

            ElevatedButton(
              onPressed: () {
                if (isAdd) {
                  pressedAddButton(context, userId);
                } else {
                  pressedDeleteButton(context, userId);
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
