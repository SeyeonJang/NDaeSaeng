import 'package:dart_flutter/res/config/size_config.dart';
import 'package:flutter/material.dart';

class MeetStandby extends StatelessWidget {
  const MeetStandby({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          TopSection(teams: 20, notifications: 93), // TODO : 서버 연결
          SizedBox(height: SizeConfig.defaultSize, width: SizeConfig.screenWidth,),
          MiddleSection(),
        ],
      ),
      bottomNavigationBar: Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.defaultSize * 6,
        child: Padding(
          padding: EdgeInsets.all(SizeConfig.defaultSize * 2),
          child: Row(
            children: [
              Container(
                child: Text("내 팀 보기"),
              ),
              Container(
                child: Text("팀 만들기"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TopSection extends StatefulWidget {
  late int teams;
  late int notifications;
  TopSection({
    super.key,
    required this.teams,
    required this.notifications,
  });
  @override
  State<TopSection> createState() => _TopSectionState();
}

class _TopSectionState extends State<TopSection> {
  bool light = true; // 스위치에 쓰임

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text("개강시즌 과팅 OPEN 예정", style: TextStyle(color: Colors.black)),
          Text("오픈 전, 미리 팀을 만들어보며 준비할 수 있어요!", style: TextStyle(color: Colors.grey)),
          Image.asset('assets/images/heart.png', width: SizeConfig.screenWidth * 0.5, height: SizeConfig.screenWidth * 0.5),
          Text("${widget.teams}"),
          Text("지금까지 신청한 팀"),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("과팅 오픈 알림받기 (${widget.notifications}명 대기중)"),
                Switch(
                  value: light,
                  activeColor: Color(0xffFF5C58),
                  onChanged: (bool value) {
                    setState(() { light = value; });
                  },
                )
              ],
            ),
          )
        ],
      )
    );
  }
}

class MiddleSection extends StatelessWidget {
  const MiddleSection({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(SizeConfig.defaultSize),
      child: Column(
        children: [
          Text("이전 시즌 후기"),
          Stack( // 후기1
            children: [

            ],
          ),
          Stack( // 후기2
            children: [

            ],
          ),
        ],
      ),
    );
  }
}
