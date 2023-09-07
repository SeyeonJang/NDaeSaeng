import 'package:dart_flutter/src/presentation/chat/view/chat_room.dart';
import 'package:dart_flutter/src/presentation/chat/viewmodel/state/chat_state.dart';
import 'package:flutter/material.dart';
import '../../../../res/config/size_config.dart';

class ChatRealTimeOneTeamView extends StatelessWidget { // Component
  final ChatState chatState;
  // final MeetTeam meetTeam;

  const ChatRealTimeOneTeamView({super.key, required this.chatState});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatRoom()));
      },
      child: Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.defaultSize * 11.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              spreadRadius: 0,
              blurRadius: 2.0,
              offset: Offset(0,2), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: SizeConfig.defaultSize * 1.2, horizontal: SizeConfig.defaultSize * 1.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("팀이름이름이름", style: TextStyle(
                      fontSize: SizeConfig.defaultSize * 1.5, fontWeight: FontWeight.w600
                    ),),
                      SizedBox(height: SizeConfig.defaultSize * 0.2,),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("${chatState.userResponse.university?.name ?? '(알 수 없음)'}",
                          style: TextStyle(fontSize: SizeConfig.defaultSize, fontWeight: FontWeight.w300, overflow: TextOverflow.ellipsis),),
                        Text(" "),
                        if (chatState.userResponse.personalInfo?.verification.isVerificationSuccess ?? false)
                          Image.asset("assets/images/check.png", width: SizeConfig.defaultSize),
                      ],
                    ),
                  ],
                ),
                Text("우리팀이름이름", style: TextStyle(
                  fontSize: SizeConfig.defaultSize * 1.2
                ),)
                ],
              ),
                SizedBox(height: SizeConfig.defaultSize * 0.8,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: SizeConfig.defaultSize * 12,
                    child: Stack(
                      children: [
                        Container( // 버리는 사진
                          width: SizeConfig.defaultSize * 3.7,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Image.asset(
                              'assets/images/profile-mockup3.png',
                              width: SizeConfig.defaultSize * 3.7, // 이미지 크기
                              height: SizeConfig.defaultSize * 3.7
                            ),
                          ),
                        ),
                        for (int i = 2; i >= 0 ; i--)
                          Positioned(
                            left: i * SizeConfig.defaultSize * 3,
                            child: Container(
                              width: SizeConfig.defaultSize * 3.7,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Image.asset(
                                  i == 0
                                      ? 'assets/images/profile-mockup.png'
                                      : (i == 1 ? 'assets/images/profile-mockup2.png' : 'assets/images/profile-mockup3.png'), // 이미지 경로를 각 이미지에 맞게 설정
                                  width: SizeConfig.defaultSize * 3.7, // 이미지 크기
                                  height: SizeConfig.defaultSize * 3.7,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            width: SizeConfig.defaultSize * 18,
                            height: SizeConfig.defaultSize * 3.5,
                            alignment: Alignment.topLeft,
                            child: Text("dddddddsaasdasdasdasdasdasdasdasdsadasdasdasdsadasdassa", maxLines: 2, style: TextStyle(
                                fontSize: SizeConfig.defaultSize * 1.4,
                                overflow: TextOverflow.ellipsis,
                                color: Colors.grey
                            ),)
                        ),
                        Text('1시간 전', style: TextStyle(
                            fontSize: SizeConfig.defaultSize * 1.1,
                            color: Color(0xffFF5C58)
                        ),),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}
