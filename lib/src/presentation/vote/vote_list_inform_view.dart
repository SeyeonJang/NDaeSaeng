import 'package:dart_flutter/src/presentation/vote/viewmodel/vote_list_cubit.dart';
import 'package:dart_flutter/src/presentation/vote/vote_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../res/size_config.dart';

class VoteListInformView extends StatelessWidget {
  const VoteListInformView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(SizeConfig.defaultSize * 7),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(height: SizeConfig.defaultSize * 10),
          Text("Dart에 온 걸 환영해요!",
              style: TextStyle(fontSize: SizeConfig.defaultSize * 2.6, fontWeight: FontWeight.w600)),
          SizedBox(height: SizeConfig.defaultSize * 5),
          Text("이 페이지에는 우리 학교 사람이 나에게 보낸 Dart들이 도착해요!🎉",
              style: TextStyle(fontSize: SizeConfig.defaultSize * 1.8)),
          SizedBox(height: SizeConfig.defaultSize * 20),
          ElevatedButton(
              onPressed: () {
                BlocProvider.of<VoteListCubit>(context).firstTime();
              },
              child: Text("닫기", style: TextStyle(fontSize: SizeConfig.defaultSize * 3))),
        ],
      ),
    ));
  }
}
