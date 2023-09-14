import 'package:dart_flutter/res/config/size_config.dart';
import 'package:dart_flutter/src/presentation/chat/view/chat_real_time_one_team_view.dart';
import 'package:dart_flutter/src/presentation/chat/viewmodel/chat_cubit.dart';
import 'package:dart_flutter/src/presentation/chat/viewmodel/state/chat_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatRealTime extends StatelessWidget {
  const ChatRealTime({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.grey.shade50,
          body: (state.isLoading)
          ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                  SizedBox(height: SizeConfig.defaultSize,),
                CircularProgressIndicator(
                  color: Color(0xffFF5C58),
                ),
                  SizedBox(height: SizeConfig.defaultSize * 4),
                Text("채팅 목록을 불러오는 중입니다 . . ."),
                  SizedBox(height: SizeConfig.defaultSize,),
              ],),
          )
          : Column(
            children: [
              state.myChatRooms.length == 0
                  ? Expanded(child: const Center(child: _NoChatView())) // TODO : 채팅 없을 때 뷰 잘 보이는지 확인하기
                  : SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(SizeConfig.defaultSize),
                      child: Column(
                        children: [
                          for (int i=0; i<state.myChatRooms.length; i++)
                            Column(
                              children: [
                                ChatRealTimeOneTeamView(ancestorContext: context, chatState: state, matchedTeams: state.myChatRooms[i],),
                                  SizedBox(height: SizeConfig.defaultSize)
                              ],
                            ),
                        ],
                      ),
                    )
                  ),
            ],
          )// TODO : pagination
        );
      }
    );
  }
}

class _NoChatView extends StatefulWidget {
  const _NoChatView({
    super.key,
  });

  @override
  State<_NoChatView> createState() => _NoChatViewState();
}

class _NoChatViewState extends State<_NoChatView> with SingleTickerProviderStateMixin {
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
      begin: const Offset(0,0.1),
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
              child: Image.asset('assets/images/chat_heart2.png', width: SizeConfig.screenWidth * 0.4)
            ),
              SizedBox(height: SizeConfig.screenHeight * 0.1,),
            Text("아직 시작한 채팅이 없어요!", style: TextStyle(fontSize: SizeConfig.defaultSize * 2, fontWeight: FontWeight.w600),),
              SizedBox(height: SizeConfig.defaultSize,),
            Text("과팅 탭에서 이성 팀에게 채팅을 보내보세요!", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.7),)
          ],
        ),
      ),
    );
  }
}
