import 'package:dart_flutter/src/common/util/analytics_util.dart';
import 'package:dart_flutter/src/common/util/toast_util.dart';
import 'package:dart_flutter/src/domain/entity/chat_room_detail.dart';
import 'package:dart_flutter/src/presentation/chat/viewmodel/state/chatting_cubit.dart';
import 'package:intl/intl.dart';
import 'package:dart_flutter/src/domain/entity/chat_room.dart';
import 'package:dart_flutter/src/presentation/chat/view/chating_room.dart';
import 'package:dart_flutter/src/presentation/chat/viewmodel/chat_cubit.dart';
import 'package:dart_flutter/src/presentation/chat/viewmodel/state/chat_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../res/config/size_config.dart';
import 'chatroom/chatting_room.dart';

class ChatRealTimeOneTeamView extends StatefulWidget { // Component
  final BuildContext ancestorContext;
  final ChatState chatState;
  final ChatRoom matchedTeams;

  const ChatRealTimeOneTeamView({super.key, required this.ancestorContext, required this.chatState, required this.matchedTeams});

  @override
  State<ChatRealTimeOneTeamView> createState() => _ChatRealTimeOneTeamViewState();
}

class _ChatRealTimeOneTeamViewState extends State<ChatRealTimeOneTeamView> {
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    String getTimeDifference(DateTime time) {
      // final adjustedTime = time.add(Duration(hours: 9));
      final now = DateTime.now();
      final difference = now.difference(time);

      if (difference.inDays > 0) {
        final dateFormat = DateFormat('MM월 dd일');
        return dateFormat.format(time);
      } else if (difference.inHours > 0) {
        return '${difference.inHours}시간 전';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes}분 전';
      } else if (difference.inSeconds > 0) {
        return '${difference.inSeconds}초 전';
      } else {
        return ''; // 시간 차이가 없을 경우 빈 문자열 반환
      }
    }

    return GestureDetector(
      onTap: () async {
        AnalyticsUtil.logEvent('채팅_실시간채팅_목록_채팅방터치', properties: {
          '채팅방 ID': widget.matchedTeams.id,
          '상대 팀 ID': widget.matchedTeams.otherTeam.id,
          '상대 팀 학교': widget.matchedTeams.otherTeam.universityName,
          '상대 팀 평균나이': widget.matchedTeams.otherTeam.averageBirthYear,
          '우리 팀 ID': widget.matchedTeams.myTeam.id,
          '우리 팀 학교': widget.matchedTeams.myTeam.universityName,
          '우리 팀 평균나이': widget.matchedTeams.myTeam.averageBirthYear
        });
        if (_isTapped == true) {
          return;
        }
        setState(() {
          _isTapped = true;
        });
        ToastUtil.showMeetToast('채팅방에 입장중입니다 . . .', 1);
        ChatRoomDetail crd = await widget.ancestorContext.read<ChatCubit>().getChatRoomDetail(widget.matchedTeams.id);
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BlocProvider<ChattingCubit>(
              create: (context) => ChattingCubit(),
              child: ChattingRoom(chatRoomDetail: crd, user: widget.chatState.userResponse),
            ),
          ),
        );
        setState(() {
          _isTapped = false;
        });
        widget.ancestorContext.read<ChatCubit>().initChat();
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
              offset: const Offset(0,2), // changes position of shadow
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
                    Text(widget.matchedTeams.otherTeam.name, style: TextStyle(
                      fontSize: SizeConfig.defaultSize * 1.5, fontWeight: FontWeight.w600
                    ),),
                      SizedBox(height: SizeConfig.defaultSize * 0.2,),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(widget.matchedTeams.otherTeam.universityName,
                          style: TextStyle(fontSize: SizeConfig.defaultSize, fontWeight: FontWeight.w300, overflow: TextOverflow.ellipsis),),
                        const Text(" "),
                        if (widget.matchedTeams.otherTeam.isCertifiedTeam ?? false)
                          Image.asset("assets/images/check.png", width: SizeConfig.defaultSize),
                      ],
                    ),
                  ],
                ),
                Text(widget.matchedTeams.myTeam.name ?? '(알 수 없음)', style: TextStyle(
                  fontSize: SizeConfig.defaultSize * 1.2
                ),)
                ],
              ),
                SizedBox(height: SizeConfig.defaultSize * 0.8,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: SizeConfig.defaultSize * 12,
                    child: Stack(
                      children: [
                        Container( // 버리는 사진
                          width: SizeConfig.defaultSize * 3.7,
                          decoration: const BoxDecoration(
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
                        for (int i = widget.matchedTeams.otherTeam.teamUsers.length-1; i >= 0 ; i--)
                          Positioned(
                            left: i * SizeConfig.defaultSize * 3,
                            child: ClipOval(
                              child: widget.matchedTeams.otherTeam.teamUsers[i].getProfileImageUrl() == 'DEFAULT' || !widget.matchedTeams.otherTeam.teamUsers[i].getProfileImageUrl().startsWith('https://')
                                ? Image.asset(
                                  'assets/images/profile-mockup3.png',
                                  width: SizeConfig.defaultSize * 3.7,
                                  height: SizeConfig.defaultSize * 3.7
                                  )
                                : Image.network(
                                  i == 0
                                      ? widget.matchedTeams.otherTeam.teamUsers[0].getProfileImageUrl()
                                      : (i == 1
                                        ? widget.matchedTeams.otherTeam.teamUsers[1].getProfileImageUrl()
                                        : widget.matchedTeams.otherTeam.teamUsers[2].getProfileImageUrl()
                                      ), // 이미지 경로를 각 이미지에 맞게 설정
                                  width: SizeConfig.defaultSize * 3.7, // 이미지 크기
                                  height: SizeConfig.defaultSize * 3.7,
                                  fit: BoxFit.cover
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
                            child: Text(widget.matchedTeams.message.message, maxLines: 2, style: TextStyle(
                                fontSize: SizeConfig.defaultSize * 1.4,
                                overflow: TextOverflow.ellipsis,
                                color: Colors.grey
                            ),)
                        ),
                        Text(getTimeDifference(widget.matchedTeams.message.sendTime), style: TextStyle(
                            fontSize: SizeConfig.defaultSize * 1.1,
                            color: const Color(0xffFF5C58)
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
