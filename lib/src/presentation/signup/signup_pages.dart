import 'package:dart_flutter/src/common/util/analytics_util.dart';
import 'package:dart_flutter/src/presentation/signup/cert_num.dart';
import 'package:dart_flutter/src/presentation/signup/choose_gender.dart';
import 'package:dart_flutter/src/presentation/signup/choose_id.dart';
import 'package:dart_flutter/src/presentation/signup/choose_major.dart';
import 'package:dart_flutter/src/presentation/signup/choose_school.dart';
import 'package:dart_flutter/src/presentation/signup/user_name.dart';
import 'package:dart_flutter/src/presentation/signup/user_phone.dart';
import 'package:dart_flutter/src/presentation/signup/viewmodel/signup_cubit.dart';
import 'package:dart_flutter/src/presentation/signup/viewmodel/state/signup_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPages extends StatefulWidget {
  const SignupPages({Key? key}) : super(key: key);

  @override
  State<SignupPages> createState() => _SignupPagesState();
}

class _SignupPagesState extends State<SignupPages> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<SignupCubit, SignupState>(
          builder: (context, state) {
            if (state.isLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state.signupStep.isSchool) {
              AnalyticsUtil.logEvent("회원가입_학교_접속");
              return const ChooseSchool();
            }
            if (state.signupStep.isDepartment) {
              AnalyticsUtil.logEvent("회원가입_학과_접속");
              return const ChooseMajor();
            }
            if (state.signupStep.isAdmissionNumber) {
              AnalyticsUtil.logEvent("회원가입_학번나이_접속");
              return const ChooseId();
            }
            if (state.signupStep.isName) {
              AnalyticsUtil.logEvent("회원가입_이름_접속");
              return UserName();
            }
            if (state.signupStep.isPhone) {
              return UserPhone();
            }
            if (state.signupStep.isValidatePhone) {
              return CertNum();
            }
            if (state.signupStep.isGender) {
              AnalyticsUtil.logEvent("회원가입_성별_접속");
              return const ChooseGender();
            }
            return SafeArea(child: Center(child: Text(state.toString())));
          },
        ),
        // BlocBuilder<SignupCubit, SignupState>(
        //   builder: (context, state) {
        //     return SafeArea(child: Container(alignment: Alignment.bottomCenter,child: Text(state.toString())));
        //   },
        // ),
      ],
    );
  }
}
