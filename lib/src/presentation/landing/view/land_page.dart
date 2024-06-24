import 'dart:io';
import 'package:dart_flutter/res/config/size_config.dart';
import 'package:dart_flutter/src/common/auth/dart_auth_cubit.dart';
import 'package:dart_flutter/src/common/util/analytics_util.dart';
import 'package:dart_flutter/src/common/util/toast_util.dart';
import 'package:dart_flutter/src/presentation/landing/view/tutorial_slide3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Timer _timer;
  int _currentPage = 0;
  final List<String> _images = [
    'assets/images/girl1.png',
    'assets/images/boy1.png',
    'assets/images/girl2.png',
  ];
  @override
  void initState() {
    super.initState();
    _startTimer();
  }
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      setState(() {
        _currentPage = (_currentPage + 1) % _images.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isAppleUser = Platform.isIOS;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            Expanded(child: TutorialSlide3(onTutorialFinished: () {})),
          ],
        ),
      ),

      // 원래 로그인 View
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       // SizedBox(
      //       //   height: SizeConfig.defaultSize * 2,
      //       // ),
      //       // Text("나에게 호감을 표시한 사람들은?", style: TextStyle(fontSize: SizeConfig.defaultSize * 2, fontWeight: FontWeight.w800)),
      //       // SizedBox(height: SizeConfig.defaultSize * 2,),
      //       // AnimatedContainer(
      //       //   height: SizeConfig.screenHeight * 0.15,
      //       //     duration: Duration(milliseconds: 400),
      //       //     curve: Curves.easeInOut,
      //       //     child: Image.asset(
      //       //       _images[_currentPage],
      //       //       fit: BoxFit.cover,
      //       //     ),
      //       // ),
      //
      //       // TutorialSlide(onTutorialFinished: () {})
      //     ],
      //   ),
      // ),
      bottomNavigationBar: SizedBox( // 로그인 버튼
        // color: Color(0xff7C83FD),
        // height: SizeConfig.screenHeight * 0.18,
        height: SizeConfig.screenHeight * 0.25,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("3초만에 회원가입하기!", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.5)),
              SizedBox(height: SizeConfig.defaultSize * 1,),
              Container(
                width: SizeConfig.screenWidth * 0.8,
                height: SizeConfig.defaultSize * 4.8,
                decoration: BoxDecoration(
                    color: const Color(0xffFEE500),
                    borderRadius: BorderRadius.circular(10)),
                child: GestureDetector(
                  onTap: () {
                    _clickLogin('카카오');
                    try {
                      if (!BlocProvider.of<DartAuthCubit>(context).state.isLoading) {
                        BlocProvider.of<DartAuthCubit>(context).kakaoLogin();
                      } else {ToastUtil.showToast("로그인 처리 중입니다. 잠시만 기다려주세요.");}
                    } catch (e) {
                      ToastUtil.showToast("로그인에 실패하였습니다. 다시 시도해주세요.");
                    }
                  },
                  child: Image.asset('assets/images/kakao_login_large_wide.png'),
                ),
              ),
              SizedBox(height: SizeConfig.defaultSize * 1,),
              if (isAppleUser) // Apple 유저일 때만 실행
              /* TODO : MVP HOTFIX 다만, iOS 플랫폼에서 실행 중인지 확인하려면 Flutter 프로젝트의 iOS 설정도 확인해야 합니다.
                  OS 설정에서 ios 폴더의 Runner 프로젝트를 열고 Runner.xcodeproj를 찾아 Xcode에서 열 수 있습니다.
                  그런 다음, Runner 프로젝트의 Runner 타겟 설정으로 이동하고, Build Settings 탭에서 Preprocessor Macros
                  (또는 GCC_PREPROCESSOR_DEFINITIONS 또는 Preprocessor Macros Not Used in Precompiled Headers)에 TARGET_OS_IOS=1이 있는지 확인합니다.
                  이 설정이 없으면 Platform.isIOS는 정상적으로 작동하지 않을 수 있습니다.

                  TODO : 애플 로그인은 iOS 13부터 지원함 -> 코드에 적용하기 (UI나 로직)
               */
                GestureDetector(
                  onTap: () {
                    _clickLogin('애플');
                    if (!BlocProvider.of<DartAuthCubit>(context).state.isLoading) {
                      BlocProvider.of<DartAuthCubit>(context).appleLogin();
                    } else {ToastUtil.showToast("로그인 처리 중입니다. 잠시만 기다려주세요.");}
                  },
                  child: Container(
                    width: SizeConfig.screenWidth * 0.8,
                    height: SizeConfig.defaultSize * 4.8,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10)),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/apple_logo.png', height: SizeConfig.defaultSize * 1.9,),
                        SizedBox(width: SizeConfig.defaultSize * 0.4,),
                        Text("Apple로 로그인", style: TextStyle(color: Colors.white, fontSize: SizeConfig.defaultSize * 1.7),),
                      ],
                    ),
                  ),
                )
            ],
          )
        )
      ),
    );
  }
}

void _clickLogin(String state) {
  AnalyticsUtil.logEvent("로그인_버튼클릭", properties: {"로그인 타입" : state});
}