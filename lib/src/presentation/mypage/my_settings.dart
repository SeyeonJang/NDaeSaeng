import 'package:dart_flutter/src/common/auth/auth_cubit.dart';
import 'package:dart_flutter/src/data/repository/kakao_login_repository.dart';
import 'package:dart_flutter/src/presentation/mypage/logout_goto_landPage.dart';
import 'package:dart_flutter/src/presentation/mypage/my_page_landing.dart';
import 'package:dart_flutter/src/presentation/mypage/my_tos2.dart';
import 'package:dart_flutter/src/presentation/mypage/viewmodel/mypages_cubit.dart';
import 'package:dart_flutter/src/presentation/mypage/viewmodel/state/mypages_state.dart';
import 'package:dart_flutter/src/presentation/signup/land_page.dart';
import 'package:dart_flutter/src/presentation/signup/land_pages.dart';
import 'package:dart_flutter/src/presentation/signup/tos1.dart';
import 'package:dart_flutter/src/presentation/signup/tos2.dart';
import 'package:dart_flutter/src/presentation/signup/viewmodel/signup_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LogoutTogoLandPage()),
      (route) => false,
    );
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
                  String name = state.userResponse.name ?? "XXX";
                  String universityName =
                      state.userResponse.universityName ?? "XX대학교";
                  String department = state.userResponse.department ?? "XXX학과";
                  String admissionNumber =
                      "${state.userResponse.admissionNumber ?? 'XX'}학번";
                  String gender = '남성';

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _infoSectionItem(title: "이름", value: name),
                      _infoSectionItem(title: "학교", value: universityName),
                      _infoSectionItem(title: "학과", value: department),
                      _infoSectionItem(title: "학번", value: admissionNumber),
                      _infoSectionItem(title: "성별", value: gender),
                      Container(
                        height: SizeConfig.defaultSize * 5,
                        child: Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("MBTI", style: TextStyle(
                                fontSize: SizeConfig.defaultSize * 1.6,
                                fontWeight: FontWeight.w400,
                              ),),
                              CupertinoButton.filled(
                                padding: EdgeInsets.fromLTRB(0,0,0,0),
                                onPressed: () {
                                  showCupertinoModalPopup(
                                  context: context,
                                  builder: (context) => CupertinoActionSheet(
                                    actions: [buildPicker()],
                                    cancelButton: CupertinoActionSheetAction(
                                      child: Text("취소"),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                    ),
                                );},
                                child: Text(mbti1[mbtiIndex1]+mbti2[mbtiIndex2]+mbti3[mbtiIndex3]+mbti4[mbtiIndex4]),
                                // TODO : state, cubit 만들어서 선택한 MBTI 저장해야함 + 서버 넘겨야함
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      );

  Container buildPicker() {
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
    return Column(
      children: [
        _infoSection(context),
        const DtFlexSpacer(20),

        /// 구분선
        const DtDivider(),
        Padding(
          padding: MyPageView._defaultPadding,
          child: Column(
            children: [
              const DtFlexSpacer(20),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                        onPressed: () async {
                          await BlocProvider.of<AuthCubit>(context)
                              .kakaoWithdrawal();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const LogoutTogoLandPage()),
                              (route) => false); // TODO : 0627 얘만 작동하면 됨 로그아웃
                        },
                        child: Text(
                          "회원탈퇴",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: getFlexibleSize(target: 16),
                          ),
                        )),
                    const DtFlexSpacer(20),
                    // TextButton( // TODO : MVP 이후 복구하기
                    //     onPressed: () => onLogoutButtonPressed(context),
                    //     child: Text("로그아웃",
                    //       textAlign: TextAlign.start,
                    //       style: TextStyle(
                    //         fontWeight: FontWeight.w500,
                    //         fontSize: getFlexibleSize(target: 16),
                    //       ),
                    //     )),
                  ],
                ),
              ),
              const DtFlexSpacer(120),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                TextButton(
                  onPressed: () {
                    BlocProvider.of<MyPagesCubit>(context)
                        .pressedTos1(); // 설정 화면으로 넘어가기
                  },
                  child: Text("이용약관",
                      style: TextStyle(fontSize: SizeConfig.defaultSize * 1.2)),
                ),
                TextButton(
                  onPressed: () {
                    BlocProvider.of<MyPagesCubit>(context)
                        .pressedTos2(); // 설정 화면으로 넘어가기
                  },
                  child: Text("개인정보 처리방침",
                      style: TextStyle(fontSize: SizeConfig.defaultSize * 1.2)),
                ),
                TextButton(
                  onPressed: () {
                    // launch로 Dart 건의 구글폼으로 이동
                    launchUrl(
                      Uri(
                        scheme: 'https',
                        host: 'docs.google.com',
                        path:
                            'forms/d/e/1FAIpQLSd8H_R1_sq1QZHiuSRGd7XUyLvegZEsV05kLlcxO1JLc6TseQ/viewform?usp=sf_link',
                      ),
                      mode: LaunchMode.inAppWebView,
                    );
                  },
                  child: Text("Dart에 건의하기",
                      style: TextStyle(fontSize: SizeConfig.defaultSize * 1.2)),
                ),
                TextButton(
                  onPressed: () {
                    // launch로 우리 카카오톡 페이지로 연결
                  },
                  child: Text("1:1 문의",
                      style: TextStyle(fontSize: SizeConfig.defaultSize * 1.2)),
                ),
              ]),
            ],
          ),
        ),
      ],
    );
  }
}

class DtDivider extends StatelessWidget {
  final double? height;

  const DtDivider({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? getFlexibleSize(target: 20),
      color: Colors.grey.shade200,
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
