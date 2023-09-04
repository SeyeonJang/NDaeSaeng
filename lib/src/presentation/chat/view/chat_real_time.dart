import 'package:dart_flutter/res/config/size_config.dart';
import 'package:flutter/material.dart';

class ChatRealTime extends StatelessWidget {
  const ChatRealTime({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: const _NoChatView(),
      // body: SingleChildScrollView(
      //   child: ,
      // ),
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
    return Center(
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
    );
  }
}
