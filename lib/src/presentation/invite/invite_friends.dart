import 'package:dart_flutter/res/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../mypage/viewmodel/mypages_cubit.dart';

class InviteFriends extends StatefulWidget {
  const InviteFriends({super.key});

  @override
  State<InviteFriends> createState() => _InviteFriendsState();
}

class _InviteFriendsState extends State<InviteFriends> {
  MyPagesCubit _getMyPageCubit(BuildContext context) =>
      BlocProvider.of<MyPagesCubit>(context);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(children: [
            IconButton(
                onPressed: () => _getMyPageCubit(context).backToMyPageLanding(),
                icon: Icon(Icons.arrow_back_ios_new_rounded,
                    size: SizeConfig.defaultSize * 2)),
            // Text("",
            //     style: TextStyle(
            //       fontWeight: FontWeight.w800,
            //       fontSize: SizeConfig.defaultSize * 2,
            //     )),
          ]),
          for (int i = 0; i < 10; i++)
            Column(
              children: [
                Text("친구이름"),
              ],
            ),
        ],
      ),
    );
  }
}
