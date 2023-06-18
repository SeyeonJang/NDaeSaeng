
import 'package:dart_flutter/src/common/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'choose_school.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            GestureDetector(
              onTap: () {
                BlocProvider.of<AuthCubit>(context).kakaoLogin();
              },
              child: Image.asset('assets/images/main_kakao_login.png'),
            ),

            // 임시 BTN **********************
            ElevatedButton( // 다른 UI 확인용 임시 btn
              onPressed: () => BlocProvider.of<AuthCubit>(context).testLogin(),
              child: const Text("확인용 btn"),
            ),

            // 애플 유저일 때 애플 로그인 나오도록 코드 추가하기
          ],
        ),
      ),
    );
  }
}
