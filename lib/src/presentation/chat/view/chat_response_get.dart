import 'package:dart_flutter/src/presentation/chat/view/chat_get_one_team_view.dart';
import 'package:dart_flutter/src/presentation/chat/viewmodel/chat_cubit.dart';
import 'package:dart_flutter/src/presentation/chat/viewmodel/state/chat_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../res/config/size_config.dart';

class ChatResponseGet extends StatelessWidget {
  const ChatResponseGet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.grey.shade50,
          body: Padding(
            padding: EdgeInsets.all(SizeConfig.defaultSize),
            child: ChatGetOneTeamView(chatState: state),
          ),
          // body: const _NoResponseGetView(),
        );
      }
    );
  }
}

class _NoResponseGetView extends StatefulWidget {
  const _NoResponseGetView({
    super.key,
  });

  @override
  State<_NoResponseGetView> createState() => _NoResponseGetViewState();
}

class _NoResponseGetViewState extends State<_NoResponseGetView> with SingleTickerProviderStateMixin {
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
              Text("이성 팀의 요청을 기다리고 있어요!", style: TextStyle(fontSize: SizeConfig.defaultSize * 2, fontWeight: FontWeight.w600),),
                SizedBox(height: SizeConfig.defaultSize,),
              Text("과팅 탭에서 내 팀을 적극적으로 만들어보세요!", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.7),)
          ],
        ),
      ),
    );
  }
}
