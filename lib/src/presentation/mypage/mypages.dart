import 'package:dart_flutter/src/presentation/invite/invite_friends.dart';
import 'package:dart_flutter/src/presentation/mypage/my_page_landing.dart';
import 'package:dart_flutter/src/presentation/mypage/my_settings.dart';
import 'package:dart_flutter/src/presentation/mypage/viewmodel/mypages_cubit.dart';
import 'package:dart_flutter/src/presentation/mypage/viewmodel/state/mypages_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyPages extends StatelessWidget {
  const MyPages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<MyPagesCubit, MyPagesState> (
          builder: (context, state) {
            return const MyPageLanding();
            // if (state.isSettings) {
            //   return const MySettings();
            // }
            // if (state.isInvitePage) {
            //   return const InviteFriends();
            // }
            // return SafeArea(child: Center(child: Text(state.toString())));
          }
        )
      ]
    );
  }
}
