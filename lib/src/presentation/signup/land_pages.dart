import 'package:dart_flutter/src/common/auth/auth_cubit.dart';
import 'package:dart_flutter/src/common/auth/auth_state.dart';
import 'package:dart_flutter/src/presentation/signup/choose_school.dart';
import 'package:dart_flutter/src/presentation/signup/land_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LandPages extends StatefulWidget {
  const LandPages({Key? key}) : super(key: key);

  @override
  State<LandPages> createState() => _LandPagesState();
}

class _LandPagesState extends State<LandPages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state.step == AuthStep.land) {
                return const LandingPage();
              }
              if (state.step == AuthStep.signup) {
                // 소셜 로그인을 했지만, 아직 우리 회원가입은 안햇을 때
                return const ChooseSchool();
              }
              if (state.step == AuthStep.login) {
                //TODO 로그인 완료 어떤 메인 페이지로 Navigator.push
              }
              return const SizedBox();
            }
          ),
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (!state.isLoading) {
                print("aaaa");
                return SafeArea(child:Text(state.toString(), style: const TextStyle(fontSize: 15, color: Colors.red)));
                // return const SizedBox();
              }
              print("bbb");
              return const SafeArea(child: Center(child: CircularProgressIndicator()));
            },
          ),
        ],
        // 화면 분배
      ),
    );
  }
}
