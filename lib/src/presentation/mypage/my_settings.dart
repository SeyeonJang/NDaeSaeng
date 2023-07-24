import 'dart:io';

import 'package:dart_flutter/src/common/auth/auth_cubit.dart';
import 'package:dart_flutter/src/common/util/toast_util.dart';
import 'package:dart_flutter/src/presentation/mypage/logout_goto_landPage.dart';
import 'package:dart_flutter/src/presentation/mypage/my_tos1.dart';
import 'package:dart_flutter/src/presentation/mypage/my_tos2.dart';
import 'package:dart_flutter/src/presentation/mypage/viewmodel/mypages_cubit.dart';
import 'package:dart_flutter/src/presentation/mypage/viewmodel/state/mypages_state.dart';
import 'package:dart_flutter/src/presentation/signup/land_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restart_app/restart_app.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../res/size_config.dart';

class MySettings extends StatelessWidget {
  MySettings({Key? key}) : super(key: key);

  void onLogoutButtonPressed(BuildContext context) async {
    await BlocProvider.of<AuthCubit>(context).kakaoLogout();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LogoutTogoLandPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: SafeArea(
    //     child:
    //       BlocBuilder<MyPagesCubit, MyPagesState>(builder: (context, state) {
    //         return const MyPageView();
    //       }),
    //   ),
    // );
    return const MyPageView();
  }
}

class MyPageView extends StatefulWidget {
  const MyPageView({super.key});

  static final _defaultPadding = EdgeInsets.all(getFlexibleSize(target: 20));

  @override
  State<MyPageView> createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  void onLogoutButtonPressed(BuildContext context) async {
    // 로그아웃 버튼 연결
    await BlocProvider.of<AuthCubit>(context).kakaoLogout();
    Navigator.push(context, MaterialPageRoute(builder: (context) => const LandPages()));
  }

  void halt() {
    print("앱을 강제 종료합니다.");
    if (Platform.isIOS) {
      exit(0);
    } else {
      SystemNavigator.pop();
    }
  }

  void restart() {
    print("앱을 재시작합니다.");
    Restart.restartApp();
  }

  String getId(String admissionYear) {
    return admissionYear.substring(2,6);
  }

  String getGender(String gender) {
    if (gender == "FEMALE") return "여자";
    if (gender == "MALE") return "남자";
    return "";
  }

  final mbti1 = ['-','E','I'];
  final mbti2 = ['-','N','S'];
  final mbti3 = ['-','F','T'];
  final mbti4 = ['-','P','J'];
  int mbtiIndex1 = 0;
  int mbtiIndex2 = 0;
  int mbtiIndex3 = 0;
  int mbtiIndex4 = 0;

  MyPagesCubit _getMyPageCubit(BuildContext context) =>
      BlocProvider.of<MyPagesCubit>(context);

  Widget _topBarSection(BuildContext context) => Row(children: [
        IconButton(
            onPressed: () => _getMyPageCubit(context).backToMyPageLanding(),
            icon: Icon(Icons.arrow_back_ios_new_rounded,
                size: SizeConfig.defaultSize * 2)),
        Text("설정",
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: SizeConfig.defaultSize * 2,
            )),
      ]);

  Widget _infoSection(BuildContext context) => Padding(
        padding: MyPageView._defaultPadding,
        child: Column(
          children: [
            _topBarSection(context),
            const DtFlexSpacer(30),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: getFlexibleSize(),
                  horizontal: getFlexibleSize(target: 20)),
              child: BlocBuilder<MyPagesCubit, MyPagesState>(
                builder: (context, state) {
                  String name = state.userResponse.user?.name ?? "XXX";
                  String universityName =
                      state.userResponse.university?.name ?? "XX대학교";
                  String department = state.userResponse.university?.department ?? "XXX학과";
                  String admissionNumber =
                      "${state.userResponse.user?.admissionYear ?? 'XX'}학번";
                  String newAdmissionNumber = getId(admissionNumber);
                  String gender = state.userResponse.user?.gender ?? 'XX';
                  String newGender = getGender(gender);
                  String inviteCode = state.userResponse.user?.recommendationCode ?? 'XXXXXXXX';

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _infoSectionItem(title: "이름", value: name),
                      _infoSectionItem(title: "학교", value: universityName),
                      _infoSectionItem(title: "학과", value: department),
                      _infoSectionItem(title: "학번", value: newAdmissionNumber),
                      _infoSectionItem(title: "성별", value: newGender),
                      _infoSectionItem(title: "초대코드", value: inviteCode),
                      // Container( // MBTI 구현은 완료해둠
                      //   height: SizeConfig.defaultSize * 5,
                      //   child: Flexible(
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         Text("MBTI", style: TextStyle(
                      //           fontSize: SizeConfig.defaultSize * 1.6,
                      //           fontWeight: FontWeight.w400,
                      //         ),),
                      //         CupertinoButton.filled(
                      //           padding: EdgeInsets.fromLTRB(10,0,10,0),
                      //           onPressed: () {
                      //             showCupertinoModalPopup(
                      //             context: context,
                      //             builder: (context) => CupertinoActionSheet(
                      //               actions: [buildPicker()],
                      //               cancelButton: CupertinoActionSheetAction(
                      //                 child: Text("취소"),
                      //                 onPressed: () => Navigator.pop(context),
                      //               ),
                      //               ),
                      //           );},
                      //           child: Text(mbti1[mbtiIndex1]+mbti2[mbtiIndex2]+mbti3[mbtiIndex3]+mbti4[mbtiIndex4]),
                      //           // TODO : state, cubit 만들어서 선택한 MBTI 저장해야함 + 서버 넘겨야함 (MEET)
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      );

  Container buildPicker() { // MBTI 고르는 화면
    return Container(
      height: SizeConfig.screenHeight * 0.3,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: SizeConfig.defaultSize * 25,
            width: SizeConfig.screenWidth * 0.23,
            child: CupertinoPicker(
              // looping: true,
              backgroundColor: Colors.white,
              itemExtent: SizeConfig.defaultSize * 5,
              selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
                background: CupertinoColors.systemIndigo.withOpacity(0.3),
              ),
              children: List.generate(mbti1.length, (index) {
                final isSelected = mbtiIndex1 == index;
                final item = mbti1[index];
                final color =
                    isSelected ? CupertinoColors.systemIndigo : CupertinoColors.black;
                return Center(
                  child: Text(item,
                      style: TextStyle(
                          color: color, fontSize: SizeConfig.defaultSize * 3)),
                );
              }),
              scrollController: FixedExtentScrollController(
                initialItem: 0, // 몇 번째 인덱스가 제일 먼저 나올지
              ),
              onSelectedItemChanged: (index) {
                setState(() => mbtiIndex1 = index);
                final item = mbti1[index];
                print('Selected item: ${mbti1}');
              },
            ),
          ),
          SizedBox(
            height: SizeConfig.defaultSize * 25,
            width: SizeConfig.screenWidth * 0.23,
            child: CupertinoPicker(
              // looping: true,
              backgroundColor: Colors.white,
              itemExtent: SizeConfig.defaultSize * 5,
              selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
                background: CupertinoColors.systemIndigo.withOpacity(0.3),
              ),
              children: List.generate(mbti2.length, (index) {
                final isSelected = mbtiIndex2 == index;
                final item = mbti2[index];
                final color =
                isSelected ? CupertinoColors.systemIndigo : CupertinoColors.black;
                return Center(
                  child: Text(item,
                      style: TextStyle(
                          color: color, fontSize: SizeConfig.defaultSize * 3)),
                );
              }),
              scrollController: FixedExtentScrollController(
                initialItem: 0, // 몇 번째 인덱스가 제일 먼저 나올지
              ),
              onSelectedItemChanged: (index) {
                setState(() => mbtiIndex2 = index);
                final item = mbti2[index];
                print('Selected item: ${mbti2}');
              },
            ),
          ),
          SizedBox(
            height: SizeConfig.defaultSize * 25,
            width: SizeConfig.screenWidth * 0.23,
            child: CupertinoPicker(
              // looping: true,
              backgroundColor: Colors.white,
              itemExtent: SizeConfig.defaultSize * 5,
              selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
                background: CupertinoColors.systemIndigo.withOpacity(0.3),
              ),
              children: List.generate(mbti3.length, (index) {
                final isSelected = mbtiIndex3 == index;
                final item = mbti3[index];
                final color =
                isSelected ? CupertinoColors.systemIndigo : CupertinoColors.black;
                return Center(
                  child: Text(item,
                      style: TextStyle(
                          color: color, fontSize: SizeConfig.defaultSize * 3)),
                );
              }),
              scrollController: FixedExtentScrollController(
                initialItem: 0, // 몇 번째 인덱스가 제일 먼저 나올지
              ),
              onSelectedItemChanged: (index) {
                setState(() => mbtiIndex3 = index);
                final item = mbti3[index];
                print('Selected item: ${mbti3}');
              },
            ),
          ),
          SizedBox(
            height: SizeConfig.defaultSize * 25,
            width: SizeConfig.screenWidth * 0.23,
            child: CupertinoPicker(
              // looping: true,
              backgroundColor: Colors.white,
              itemExtent: SizeConfig.defaultSize * 5,
              selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
                background: CupertinoColors.systemIndigo.withOpacity(0.3),
              ),
              children: List.generate(mbti4.length, (index) {
                final isSelected = mbtiIndex4 == index;
                final item = mbti4[index];
                final color =
                isSelected ? CupertinoColors.systemIndigo : CupertinoColors.black;
                return Center(
                  child: Text(item,
                      style: TextStyle(
                          color: color, fontSize: SizeConfig.defaultSize * 3)),
                );
              }),
              scrollController: FixedExtentScrollController(
                initialItem: 0, // 몇 번째 인덱스가 제일 먼저 나올지
              ),
              onSelectedItemChanged: (index) {
                setState(() => mbtiIndex4 = index);
                final item = mbti4[index];
                print('Selected item: ${mbti4}');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoSectionItem({required String title, required String value}) =>
      Padding(
          padding: EdgeInsets.symmetric(vertical: getFlexibleSize(target: 12)),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: getFlexibleSize(target: 16))),
            Text(value,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: getFlexibleSize(target: 16))),
          ]));

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _infoSection(context),
          const DtFlexSpacer(20),

          /// 구분선
          const DtDivider(),
          Padding(
            padding: MyPageView._defaultPadding,
            child: Column(
              children: [
                const DtFlexSpacer(10),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                          onPressed: () async {
                            BlocProvider.of<AuthCubit>(context).kakaoWithdrawal();
                            ToastUtil.showToast("회원탈퇴가 완료되었습니다.\n잠시후 앱이 종료됩니다.");
                            await Future.delayed(const Duration(seconds: 2));
                            restart();
                          },
                          child: Text(
                            "회원탈퇴",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: getFlexibleSize(target: 16),
                              color: Color(0xff7C83FD)
                            ),
                          )),
                      const DtFlexSpacer(10),
                      TextButton(
                          onPressed: () async {
                            ToastUtil.showToast("로그아웃이 완료되었습니다.\n잠시후 앱이 종료됩니다.");
                            BlocProvider.of<AuthCubit>(context).kakaoLogout();
                            await Future.delayed(const Duration(seconds: 2));
                            restart();
                          },
                        child: Text("로그아웃",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: getFlexibleSize(target: 16),
                                color: Color(0xff7C83FD)

                            ),
                          ),
                      ),
                    ],
                  ),
                ),
                const DtFlexSpacer(10),
              ],
            ),
          ),
          const DtDivider(),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: SizeConfig.defaultSize * 2),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: SizeConfig.defaultSize * 1.5,),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const MyTos1()));
                },
                child: Text("이용약관",
                    style: TextStyle(fontSize: SizeConfig.defaultSize * 1.4, color: Color(0xff7C83FD))),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const MyTos2()));
                },
                child: Text("개인정보 처리방침",
                    style: TextStyle(fontSize: SizeConfig.defaultSize * 1.4, color: Color(0xff7C83FD))),
              ),
              TextButton(
                onPressed: () {
                  launchUrl(
                    Uri(
                      scheme: 'https',
                      host: 'tally.so',
                      path:
                      'r/mYR270',
                    ),
                    mode: LaunchMode.inAppWebView,
                  );
                },
                child: Text("건의하기",
                    style: TextStyle(fontSize: SizeConfig.defaultSize * 1.4, color: Color(0xff7C83FD))),
              ),
              TextButton(
                onPressed: () {
                  // TODO : launch로 우리 카카오톡 페이지로 연결 (카카오채널 생기면)
                  launchUrl(
                    Uri(
                      scheme: 'https',
                      host: 'tally.so',
                      path:
                      'r/wzNV5E',
                    ),
                    mode: LaunchMode.inAppWebView,
                  );
                },
                child: Text("1:1 문의",
                    style: TextStyle(fontSize: SizeConfig.defaultSize * 1.4, color: Color(0xff7C83FD))),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

class DtDivider extends StatelessWidget {
  final double? height;

  const DtDivider({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? getFlexibleSize(target: 15),
      color: Colors.grey.shade100,
    );
  }
}

class DtFlexSpacer extends StatelessWidget {
  final double size;
  final bool flexible;

  const DtFlexSpacer(this.size, {super.key, this.flexible = true});

  @override
  Widget build(BuildContext context) {
    final double resultSize = flexible ? getFlexibleSize(target: size) : size;
    return SizedBox(width: resultSize, height: resultSize);
  }
}
