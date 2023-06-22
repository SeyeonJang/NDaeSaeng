import 'package:flutter/material.dart';
import 'package:dart_flutter/res/size_config.dart';


class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(SizeConfig.defaultSize * 1.5),
            child: Column(
              children: [
                friends(),

                // Text("나와라얍"),
                ListView.separated(
                  itemBuilder: (context, index) {
                    return friends();
                  },
                  separatorBuilder: (context, index) => SizedBox(height: SizeConfig.defaultSize * 1.4),
                  itemCount: 70,
                  // scrollDirection: Axis.vertical,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class friends extends StatefulWidget {
  // final String enterYear;
  // final String sex;
  // final String question;
  // final String datetime;

  const friends({
    super.key,
    // required this.enterYear,
    // required this.sex,
    // required this.question,
    // required this.datetime,
  });

  @override
  State<friends> createState() => _friendsState();
}

class _friendsState extends State<friends> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(SizeConfig.defaultSize * 1),
        decoration: BoxDecoration(
          border: Border.all(
            width: SizeConfig.defaultSize * 0.1,
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Icon(Icons.heart_broken, size: SizeConfig.defaultSize * 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("안녕"),
                //Text("$enterYear학번의 $sex학생이 Dart를 보냈어요!"),
                //Text("$question"),
              ],
            ),
            Text("하세요"),
            // Text("$datetime 전"),
          ],
        ),
      ),
    );
  }
}
