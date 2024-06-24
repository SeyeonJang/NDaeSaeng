import 'package:dart_flutter/src/presentation/chat/view/chat_send_one_team_view.dart';
import 'package:dart_flutter/src/presentation/chat/viewmodel/chat_cubit.dart';
import 'package:dart_flutter/src/presentation/component/meet_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../res/config/size_config.dart';
import '../viewmodel/state/chat_state.dart';

class ChatResponseSend extends StatefulWidget {
  const ChatResponseSend({super.key});

  @override
  State<ChatResponseSend> createState() => _ChatResponseSendState();
}

class _ChatResponseSendState extends State<ChatResponseSend> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Stack(
      children: [

      BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          if (!state.isLoading) {
            return Scaffold(
              backgroundColor: Colors.grey.shade50,
              body: state.requestedList.isEmpty
                  ? RefreshIndicator(
                      onRefresh: () async {
                        context.read<ChatCubit>().initResponseSend();
                      },
                      child: const SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: _NoResponseSendView()
                      ),
                  )
                  : Padding(
                      padding: EdgeInsets.all(SizeConfig.defaultSize),
                      child: RefreshIndicator(
                        onRefresh: () async {
                          context.read<ChatCubit>().initResponseSend();
                        },
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Column(
                              children: [
                                for (int i = 0; i < state.requestedList.length; i++)
                                  Column(
                                    children: [
                                      ChatSendOneTeamView(chatState: state, proposal: state.requestedList[i],),
                                      SizedBox(height: SizeConfig.defaultSize * 1.5,)
                                    ],
                                  ),
                                if (state.requestedList.length < 5)
                                  SizedBox(height: SizeConfig.defaultSize * 30)
                              ]),
                        ),
                      )),
            );
          }
          return const SizedBox.shrink();
        }
      ),

        // 로딩 화면
        BlocBuilder<ChatCubit, ChatState>(builder: (context, state) {
          const String text = "보낸 호감을 불러오는 중입니다 . . .";
          if (state.isLoading) {
            return const MeetProgressIndicatorWithMessage(text: text);
          }
          return const SizedBox.shrink();
        }),
      ],
    );
  }
}

class _NoResponseSendView extends StatefulWidget {
  const _NoResponseSendView();

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
      height: SizeConfig.screenHeight * 0.75,
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
