import 'package:dart_flutter/src/common/util/analytics_util.dart';
import 'package:dart_flutter/src/presentation/vote_list/viewmodel/vote_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../res/config/size_config.dart';

class VoteListInformView extends StatelessWidget {
  const VoteListInformView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: Center(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          Text("엔대생에 온 걸 환영해요!",
              style: TextStyle(fontSize: SizeConfig.defaultSize * 2.6, fontWeight: FontWeight.w600)),
          SizedBox(height: SizeConfig.screenHeight * 0.2),
          Text("이 페이지에는 친구들이\n나에게 보낸 투표들이 도착할 거예요!🎉",
              style: TextStyle(fontSize: SizeConfig.defaultSize * 1.8),
          textAlign: TextAlign.center,),
          SizedBox(height: SizeConfig.screenHeight * 0.2),
          Text("시작해볼까요?",
            style: TextStyle(fontSize: SizeConfig.defaultSize * 1.8),
            textAlign: TextAlign.center,),
          SizedBox(height: SizeConfig.defaultSize * 1),
          ElevatedButton(
              onPressed: () {
                AnalyticsUtil.logEvent("투표목록_안내_다음");
                BlocProvider.of<VoteListCubit>(context).firstTime();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xff7C83FD)),
              ),
              child: Text("알림보기", style: TextStyle(fontSize: SizeConfig.defaultSize * 2, color: Colors.white))),
        ],
      ),
    ));
  }
}
