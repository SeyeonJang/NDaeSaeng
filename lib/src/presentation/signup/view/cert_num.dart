import 'package:dart_flutter/src/presentation/component/webview_fullscreen.dart';
import 'package:dart_flutter/src/presentation/signup/viewmodel/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CertNum extends StatelessWidget {
  CertNum({Key? key}) : super(key: key);

  final TextEditingController _certNumController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // title: const Text('Certification Number'),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              }, icon: const Icon(Icons.arrow_back)),
        ),
        body: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 나중에 필요하면 쓰기 (아마 sharedPreferences 쓰면 안 쓸듯)
            // ('Name: ${widget.userName}'),
            // ('Phone Number: ${widget.phoneNumber}'),

              const SizedBox(
                height: 100,
              ),
              const Text("인증 코드", style: TextStyle(fontSize: 25)),
              const SizedBox( height: 140, ),
              SizedBox( // 입력 공간 Textfield
                width: 400,
                child: TextFormField(
                  decoration: const InputDecoration(
                    // labelText: 'Name',
                      hintText: "인증코드 입력" // 서버에서 에러메시지도 만들었으면 같이 가져오기
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text("05:00", style: TextStyle(fontSize: 20)),

              const SizedBox(height: 140),
              const Text("본인이 만 14세 이상이며, Dart 서비스의 필수 동의 항목인",
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const WebViewFullScreen(url: "https://swye0n.tistory.com/14", title: "이용약관")));
                    },
                    child: const Text("이용약관", style: TextStyle(fontSize: 14)),
                  ),
                  const Text("및"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const WebViewFullScreen(url: "https://swye0n.tistory.com/9", title: "개인정보 처리방침")));
                    },
                    child: const Text("개인정보 처리방침", style: TextStyle(fontSize: 14)),
                  ),
                  const Text("에 동의하시면 계속 진행해주세요."),
                ]
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  // 인증번호 확인 로직 구현

                  // 인증번호 맞았을 때
                  BlocProvider.of<SignupCubit>(context).stepValidatePhone(_certNumController.text);
                },
                child: const Text('동의하고 계속'),
            ),
          ],
          ),
        ),
    );
  }
}
