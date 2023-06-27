import 'package:dart_flutter/src/data/repository/kakao_login_repository.dart';
import 'package:dart_flutter/src/presentation/invite/invite_friends.dart';
import 'package:dart_flutter/src/presentation/mypage/my_page_landing.dart';
import 'package:dart_flutter/src/presentation/mypage/my_settings.dart';
import 'package:dart_flutter/src/presentation/mypage/my_tos1.dart';
import 'package:dart_flutter/src/presentation/mypage/viewmodel/mypages_cubit.dart';
import 'package:dart_flutter/src/presentation/mypage/viewmodel/state/mypages_state.dart';
import 'package:dart_flutter/src/presentation/signup/tos1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'my_tos2.dart';

class MyPages extends StatelessWidget {
  const MyPages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<MyPagesCubit, MyPagesState> (
          builder: (context, state) {
            // return const MyPageLanding();
            if (state.isSettings) {
              // if (state.isTos1) {
              //   return const MyTos1();
              // }
              // if (state.isTos2) {
              //   return const MyTos2();
              // }
              return MySettings(); // TODO : 0627 이거맞나?
            }
            if (!state.isSettings) {
              return const MyPageLanding();
            }
            return SafeArea(child: Center(child: Text(state.toString())));
          }
        )
      ]
    );
  }
}
