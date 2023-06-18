import 'package:dart_flutter/src/presentation/mypage/my_page.dart';
import 'package:dart_flutter/src/presentation/vote/vote_list_inform_view.dart';
import 'package:dart_flutter/src/presentation/vote/vote_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DartPageView extends StatelessWidget {
  const DartPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dart PageView'),
      ),
      body: PageView(
        children: const [
          // TODO, 각 Page를 cubit으로 제어하도록 해야함
          VoteListInformView(),
          VotePages(),
          MyPage(),
        ],
      ),
    );
  }
}
