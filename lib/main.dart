import 'package:dart_flutter/src/presentation/signup/select_image.dart';
import 'package:dart_flutter/src/presentation/signup/user_name.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

// import 'package:dart_flutter/photo_screen.dart';
import 'package:dart_flutter/src/presentation/signup/choose_id.dart';
import 'package:dart_flutter/src/presentation/signup/choose_school.dart';
// import 'landing_page.dart';

// 랜딩페이지
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  KakaoSdk.init(
    nativeAppKey: 'c83df49e14c914b9bda9b902b6624da2',
  );
  runApp(const MyApp());
}

// stless 입력으로 기존 기본 템플릿 -> stateless로 변경
// stless(변경 필요한 data x) vs stful(변경된 부분을 위젯에 반영하는 동적 위젯)
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
              Image.asset('assets/images/main_kakao_login.png'),

              // 애플 유저일 때 애플 로그인 나오도록 코드 추가하기
            ],
          ),
        ),
      ),
    );
  }
}
