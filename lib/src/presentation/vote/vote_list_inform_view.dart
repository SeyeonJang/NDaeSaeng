import 'package:dart_flutter/src/presentation/vote/vote_list_view.dart';
import 'package:flutter/material.dart';

class VoteListInformView extends StatelessWidget {
  const VoteListInformView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(80),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(height: 50),
          const Text("Dart에 온 걸 환영해요!",
              style: TextStyle(fontSize: 27, fontWeight: FontWeight.w600)),
          const SizedBox(height: 50),
          const Text("이 페이지에는 우리 학교 사람이 나에게 보낸 Dart들이 도착해요!",
              style: TextStyle(fontSize: 20)),
          const Text("(🎉설명섬령🎉)"),
          const SizedBox(height: 300),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VoteListView()));
              },
              child: const Text("닫기", style: TextStyle(fontSize: 27))),
        ],
      ),
    ));
  }
}
