import 'package:dart_flutter/res/size_config.dart';
import 'package:dart_flutter/src/presentation/mypage/my_page.dart';
import 'package:dart_flutter/src/presentation/vote/vote_pages.dart';
import 'package:dart_flutter/src/presentation/vote_list/viewmodel/vote_list_cubit.dart';
import 'package:dart_flutter/src/presentation/vote_list/vote_list_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DartPageView extends StatefulWidget {
  const DartPageView({Key? key}) : super(key: key);

  @override
  State<DartPageView> createState() => _DartPageViewState();
}

class _DartPageViewState extends State<DartPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const TabBar(
      //   cont
      //   tabs: <Widget>[
      //     Tab(text: "Darts"),
      //     Tab(text: "Dart"),
      //     Tab(text: "MY"),
      //   ],
      // ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(SizeConfig.defaultSize * 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // TODO pageViewCubit 임시로 만들어서 관리
                  Text("Darts", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.8, fontWeight: FontWeight.w500, color: Colors.black)),
                  Text("Dart", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.8, fontWeight: FontWeight.w500, color: Colors.grey)),
                  Text(" MY ", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.8, fontWeight: FontWeight.w500, color: Colors.grey)),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                children: [
                  // TODO, 각 Page를 cubit으로 제어하도록 해야함
                  BlocProvider(
                      create: (context) => VoteListCubit(),
                      child: const VoteListPages(),
                  ),
                  const VotePages(),
                  const MyPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
