import 'package:dart_flutter/src/domain/entity/proposal.dart';
import 'package:flutter/material.dart';
import '../../../../res/config/size_config.dart';
import '../viewmodel/state/chat_state.dart';

class ChatSendOneTeamView extends StatelessWidget { // Component
  final ChatState chatState;
  final Proposal proposal;

  const ChatSendOneTeamView({super.key, required this.chatState, required this.proposal});

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {},
      child: Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.defaultSize * 9.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              spreadRadius: 0,
              blurRadius: 2.0,
              offset: const Offset(0,2), // changes position of shadow
            ),
          ],
        ),
        child: Padding( // Container 내부 패딩
          padding: EdgeInsets.symmetric(vertical: SizeConfig.defaultSize * 1.2, horizontal: SizeConfig.defaultSize * 1.5),
          child: Column(
            children: [
              Row( // 위층
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(proposal.requestedTeam.name, style: TextStyle(fontSize: SizeConfig.defaultSize * 1.6, fontWeight: FontWeight.w600),),
                      Text("  ${proposal.requestedTeam.averageBirthYear.toStringAsFixed(1)}세", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.6),)
                    ],
                  ),
                  Text(proposal.requestingTeam.name, style: TextStyle(fontSize: SizeConfig.defaultSize * 1.4),),
                ],
              ),
              SizedBox(height: SizeConfig.defaultSize * 1,),

              Row( // 아래층
                children: [
                  SizedBox(
                    width: SizeConfig.defaultSize * 12,
                    child: Stack(
                      children: [
                        Container( // 버리는 사진
                          width: SizeConfig.defaultSize * 4,
                          decoration: const BoxDecoration(
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
                        for (int i = proposal.requestedTeam.teamUsers.length-1; i >= 0 ; i--)
                          Positioned(
                            left: i * SizeConfig.defaultSize * 3,
                            child: Container(
                              width: SizeConfig.defaultSize * 4,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                  child: proposal.requestedTeam.teamUsers[i].getProfileImageUrl() == "DEFAULT" || proposal.requestedTeam.teamUsers[i].getProfileImageUrl().startsWith("https://")
                                      ? Image.asset('assets/images/profile-mockup3.png', width: SizeConfig.defaultSize * 4, height: SizeConfig.defaultSize * 4, fit: BoxFit.cover,)
                                      : Image.network(proposal.requestedTeam.teamUsers[i].getProfileImageUrl(), width: SizeConfig.defaultSize * 4, height: SizeConfig.defaultSize * 4, fit: BoxFit.cover,)
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("${proposal.requestedTeam.universityName} ",
                              style: TextStyle(fontSize: SizeConfig.defaultSize * 1.4, fontWeight: FontWeight.w600),),
                            if (proposal.requestedTeam.isCertifiedTeam ?? false)
                              Image.asset("assets/images/check.png", width: SizeConfig.defaultSize * 1.2),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(proposal.requestedTeam.teamUsers.map((user) => user.getDepartment()).toSet().fold('', (previousValue, element) => previousValue.isEmpty ? element : '$previousValue & $element'),
                                style: TextStyle(fontSize: SizeConfig.defaultSize * 1.4, overflow: TextOverflow.ellipsis),),
                            ),
                            Text("${proposal.createdTime.month}/${proposal.createdTime.day} 보냄", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.4, color: const Color(0xff7C83FD)),)
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
