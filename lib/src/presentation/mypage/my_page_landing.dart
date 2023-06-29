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
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MyPagesCubit>(context).initPages();
  }

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
                        Text(
                        "무슨무슨무슨학과",
                        style: TextStyle(
                       fontWeight: FontWeight.w500,
                         fontSize: SizeConfig.defaultSize * 1.15,
                         ),
                       ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text("장세연",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: SizeConfig.defaultSize * 2,
                            ),),
                          const SizedBox(width: 5),
                          Text("21학번",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: SizeConfig.defaultSize * 1.6,
                            ),),
                        ],
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
                            Text("  280",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: SizeConfig.defaultSize * 1.6,
                              ),),
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

                  // ================================ 친구 리스트
                  // for (int i = 0; i <5; i++) // TODO : 친구의 수만큼 반복시키기
                  //   MyFriend(),
                  MyFriends(friends: FriendsMock().friends, count: FriendsMock().friends.length)
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

                  // ================================ 친구 리스트
                  // for (int i = 0; i <5; i++) // TODO : 친구의 수만큼 반복시키기
                  //   NewFriend(),
                  NewFriends(friends: FriendsMock().friends, count: FriendsMock().friends.length),
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
          MyFriend(
              name: friends[i].name,
              admissionNumber:friends[i].admissionNumber,
              department: friends[i].university.department),
      ],
    );
  }
}


class MyFriend extends StatelessWidget {
  final String name;
  final int admissionNumber;
  final String department;

  const MyFriend({
    super.key,
    required this.name,
    required this.admissionNumber,
    required this.department,
  });

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
                // TODO : 친구 삭제 기능
              },
              child: Text("삭제", style: TextStyle(
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
          MyFriend(
              name: friends[i].name,
              admissionNumber:friends[i].admissionNumber,
              department: friends[i].university.department),
      ],
    );
  }
}


class NewFriend extends StatelessWidget {
  final String name;
  final int admissionNumber;
  final String department;

  const NewFriend({
    super.key,
    required this.name,
    required this.admissionNumber,
    required this.department,
  });

  @override
  Widget build(BuildContext context) {
    return MyFriend(name: name, admissionNumber: admissionNumber, department: department);
  }
}

