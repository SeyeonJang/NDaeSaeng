import 'package:dart_flutter/src/domain/entity/blind_date_team.dart';
import 'package:dart_flutter/src/domain/entity/location.dart';
import 'package:dart_flutter/src/domain/entity/proposal.dart';
import 'package:dart_flutter/src/domain/entity/type/blind_date_user.dart';
import 'package:dart_flutter/src/presentation/chat/view/chat_send_one_team_view.dart';
import 'package:dart_flutter/src/presentation/chat/viewmodel/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../res/config/size_config.dart';
import '../viewmodel/state/chat_state.dart';

class ChatResponseSend extends StatelessWidget {
  const ChatResponseSend({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.grey.shade50,
          body: state.requestedList.length == 0
              ? const _NoResponseSendView()
              : Padding(
                  padding: EdgeInsets.all(SizeConfig.defaultSize),
                  child: Column(
                      children: [
                        // for (int i=0; i<1; i++)
                        for (int i=0; i<state.receivedList.length; i++)
                          Column(
                            children: [
                              ChatSendOneTeamView(chatState: state, proposal: state.receivedList[i],),
                              // ChatSendOneTeamView(chatState: state, proposal: Proposal(proposalId: 1, createdTime: DateTime.now(),
                              //   requestingTeam: BlindDateTeam(id: 0, name: '요이하', averageBirthYear: 2012.3333, regions: [Location(id: 1, name: '서울')], universityName: '보낸대학교', isCertifiedTeam: true , teamUsers: [BlindDateUser(id: 1, name: '이번', profileImageUrl: 'DEFAULT', department: '무슨학과')]),
                              //   requestedTeam: BlindDateTeam(id: 0, name: '하이요', averageBirthYear: 2002.3333, regions: [Location(id: 0, name: '인천')], universityName: '받은대학교', isCertifiedTeam: true , teamUsers: [BlindDateUser(id: 0, name: '일번', profileImageUrl: 'DEFAULT', department: '무슨학과'), BlindDateUser(id: 2, name: '삼번', profileImageUrl: 'DEFAULT', department: '무슨무슨학과')]),),),
                              SizedBox(height: SizeConfig.defaultSize * 1.5,)
                            ],
                          ),
                      ])),
        );
      }
    );
  }
}

class _NoResponseSendView extends StatefulWidget {
  const _NoResponseSendView({
    super.key,
  });

  @override
  State<_NoResponseSendView> createState() => _NoResponseSendViewState();
}

class _NoResponseSendViewState extends State<_NoResponseSendView> with SingleTickerProviderStateMixin {
  bool _isUp = true;
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation = Tween<Offset>(
      begin: const Offset(0,0.15),
      end: const Offset(0,0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _isUp = !_isUp;
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _isUp = !_isUp;
        _controller.forward();
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SlideTransition(
                position: _animation,
                child: Image.asset('assets/images/chat_heart.png', width: SizeConfig.screenWidth * 0.3)
            ),
              SizedBox(height: SizeConfig.screenHeight * 0.1,),
              SizedBox(height: SizeConfig.screenWidth * 0.1,),
            Text("보낸 요청이 없어요!", style: TextStyle(fontSize: SizeConfig.defaultSize * 2, fontWeight: FontWeight.w600),),
              SizedBox(height: SizeConfig.defaultSize,),
            Text("과팅 탭에서 이성 팀에게 채팅을 보내보세요!", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.7),)
          ],
        ),
      ),
    );
  }
}
