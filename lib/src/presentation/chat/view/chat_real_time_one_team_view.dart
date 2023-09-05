import 'package:dart_flutter/src/presentation/chat/viewmodel/state/chat_state.dart';
import 'package:flutter/material.dart';
import '../../../../res/config/size_config.dart';

class ChatRealTimeOneTeamView extends StatelessWidget { // Component
  final ChatState chatState;
  // final MeetTeam meetTeam;

  const ChatRealTimeOneTeamView({super.key, required this.chatState});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.defaultSize * 11.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: SizeConfig.defaultSize * 1.2, horizontal: SizeConfig.defaultSize * 1.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: SizeConfig.defaultSize * 10.5,
                  child: Stack(
                    children: [
                      Container( // 버리는 사진
                        width: SizeConfig.defaultSize * 4,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Image.asset(
                            'assets/images/profile-mockup3.png',
                            width: SizeConfig.defaultSize * 4, // 이미지 크기
                            height: SizeConfig.defaultSize * 4,
                          ),
                        ),
                      ),
                      for (int i = 2; i >= 0 ; i--)
                        Positioned(
                          left: i * SizeConfig.defaultSize * 3,
                          child: Container(
                            width: SizeConfig.defaultSize * 4,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Image.asset(
                                i == 0
                                    ? 'assets/images/profile-mockup.png'
                                    : (i == 1 ? 'assets/images/profile-mockup2.png' : 'assets/images/profile-mockup3.png'), // 이미지 경로를 각 이미지에 맞게 설정
                                width: SizeConfig.defaultSize * 4, // 이미지 크기
                                height: SizeConfig.defaultSize * 4,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("${chatState.userResponse.university?.name ?? '학교를 불러오지 못했어요'}",
                            style: TextStyle(fontSize: SizeConfig.defaultSize * 1.4, fontWeight: FontWeight.w600, overflow: TextOverflow.ellipsis),),
                          if (chatState.userResponse.personalInfo?.verification.isVerificationSuccess ?? false)
                            Image.asset("assets/images/check.png", width: SizeConfig.defaultSize * 1.3),
                        ],
                      ),
                      Text("${chatState.userResponse.university?.department ?? '학과를 불러오지 못했어요'}",
                        style: TextStyle(fontSize: SizeConfig.defaultSize * 1.2, overflow: TextOverflow.ellipsis),)
                    ],
                  ),
                )
              ],
            ),
              SizedBox(height: SizeConfig.defaultSize,),
            Row(
              children: [
                  SizedBox(width: SizeConfig.defaultSize * 0.5),
                Container(
                  width: SizeConfig.defaultSize * 9.8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("상대팀이름이름", style: TextStyle(
                        fontSize: SizeConfig.defaultSize * 1.5, fontWeight: FontWeight.w600
                      ),),
                      Text("❤️ 우리팀이름이름", style: TextStyle(
                        fontSize: SizeConfig.defaultSize * 1.2
                      ),)
                    ],
                  ),
                ),
                  SizedBox(width: SizeConfig.defaultSize * 1.4),
                Container(
                  width: SizeConfig.defaultSize * 19.5,
                  height: SizeConfig.defaultSize * 4,
                  alignment: Alignment.topLeft,
                  child: Text("dddddddsaasdasdasdasdasdasdasdasdsadasdasdasdsadasdassa", maxLines: 2, style: TextStyle(
                    fontSize: SizeConfig.defaultSize * 1.4,
                    overflow: TextOverflow.ellipsis,
                    color: Colors.grey
                  ),)
                ),
                  SizedBox(width: SizeConfig.defaultSize * 1.4),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffFF5C58)
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(SizeConfig.defaultSize * 0.3),
                          child: Text("100", style: TextStyle(
                            fontSize: SizeConfig.defaultSize * 1.2,
                            color: Colors.white
                          ),),
                        ),
                      ),
                        SizedBox(height: SizeConfig.defaultSize * 0.5,),
                      Text("오전 11:39", style: TextStyle(
                        fontSize: SizeConfig.defaultSize * 0.8,
                        color: Colors.grey
                      ),)
                    ],
                  ),
                )
              ],
            )
          ],
        )
      ),
    );
  }
}
