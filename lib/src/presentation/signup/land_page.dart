import 'dart:io';
import 'package:dart_flutter/res/size_config.dart';
import 'package:dart_flutter/src/common/auth/auth_cubit.dart';
import 'package:dart_flutter/src/common/auth/type/social_type.dart';
import 'package:dart_flutter/src/common/util/toast_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'choose_school.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isAppleUser = Platform.isIOS;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 130,
            ),
            const Text("Dart", style: TextStyle(fontSize: 50)),
            const SizedBox(height: 50,),
            Image.asset('assets/images/dart_logo.png', width: 150, height: 150,), // 앱 로고 들어갈 자리
            const SizedBox(
              height: 100,
            ),
            const Text("누가 나를 선택했을지 보러가기", style: TextStyle(fontSize: 15)),
            const SizedBox(height: 20,),
            Container(
              width: SizeConfig.screenWidth * 0.8,
              height: SizeConfig.defaultSize * 4.8,
              decoration: BoxDecoration(
                  color: Color(0xffFEE500),
                  borderRadius: BorderRadius.circular(10)),
              child: GestureDetector(
                onTap: () {
                  try {
                    BlocProvider.of<AuthCubit>(context).kakaoLogin();
                  } catch (e) {
                    ToastUtil.showToast("로그인에 실패하였습니다. 다시 시도해주세요.");
                  }
                },
                child: Image.asset('assets/images/kakao_login_btn.png'), // TODO : MVP HOTFIX 카카오 로그인 깨짐 현상 개선
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
              Container(
                width: SizeConfig.screenWidth * 0.8,
                height: SizeConfig.defaultSize * 4.8,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10)),
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    BlocProvider.of<AuthCubit>(context).appleLogin();
                  },
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
              ),
          ],
        ),
      ),
    );
  }
}
