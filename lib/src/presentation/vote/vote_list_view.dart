import 'package:dart_flutter/src/presentation/vote/vote_detail_view.dart';
import 'package:flutter/material.dart';

class VoteListView extends StatelessWidget {
  const VoteListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.separated(
          itemBuilder: (context, index) {
            return dart(
              enterYear: "20",
              sex: "여",
              question: "질문내용~~~~~~~~~~~",
              datetime: "15초",
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemCount: 70,
        ),
      ),
    );
  }
}

class dart extends StatelessWidget {
  final String enterYear;
  final String sex;
  final String question;
  final String datetime;

  const dart({
    super.key,
    required this.enterYear,
    required this.sex,
    required this.question,
    required this.datetime,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => VoteDetailView()));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(Icons.heart_broken, size: 40),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("$enterYear학번의 $sex학생이 Dart를 보냈어요!"),
                Text("$question"),
              ],
            ),
            Text("$datetime 전"),
          ],
        ),
      ),
    );
  }
}
