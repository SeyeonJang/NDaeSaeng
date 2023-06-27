import 'package:flutter/material.dart';
import '../../../res/size_config.dart';

class MeetPage extends StatefulWidget {
  const MeetPage({super.key});

  @override
  State<MeetPage> createState() => _MeetPageState();
}

class _MeetPageState extends State<MeetPage> {

  // 좋아요
  int likes = 0;
  void onLikeButtonPressed() {
    setState(() {
      likes++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: SizeConfig.defaultSize * 10,),
            Text("7월 OPEN",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: SizeConfig.defaultSize * 4,
              ),),
            SizedBox(height: SizeConfig.defaultSize * 5,),

            IconButton(
              icon: const Icon(Icons.ads_click),
              // icon: const AssetImage('assets/images/meet_heart.png'), // TODO : Icon 바꾸기
              iconSize: SizeConfig.defaultSize * 17,
              // tooltip: 'Increase volume by 10',
              onPressed: () {
                setState(() {
                  likes += 1;
                });
              },
            ),
            Text('얼른 열어주세요! : $likes',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: SizeConfig.defaultSize * 1.9,
                height: SizeConfig.defaultSize * 0.25,
              ),),

            SizedBox(height: SizeConfig.defaultSize * 5,),
            Text("Dart에서 모은 투표를 프로필로 사용하는\n"
                "과팅이 시작될 예정이에요!\n"
                "친구들과의 재밌는 투표로 어필을 쌓아보세요!", // TODO : 포인트 얼마 써서 과팅할거라고 넣기
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: SizeConfig.defaultSize * 1.9,
                height: SizeConfig.defaultSize * 0.25,
              ),),
          ],
        ),
      ),
    );
  }
}