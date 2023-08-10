import 'package:dart_flutter/res/config/size_config.dart';
import 'package:dart_flutter/src/common/util/analytics_util.dart';
import 'package:dart_flutter/src/domain/entity/friend.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';
import 'package:dart_flutter/src/presentation/vote/vimemodel/state/vote_state.dart';
import 'package:dart_flutter/src/presentation/vote/vimemodel/vote_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VoteStartView extends StatefulWidget {
  const VoteStartView({Key? key}) : super(key: key);

  @override
  State<VoteStartView> createState() => _VoteStartViewState();
}

class _VoteStartViewState extends State<VoteStartView> with SingleTickerProviderStateMixin {
  bool _isUp = true;
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _animation = Tween<Offset>(
      begin: Offset(0,0.15),
      end: Offset(0,0),
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(SizeConfig.defaultSize * 5),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "새로운 질문 도착!",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: SizeConfig.defaultSize * 3.8,
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: Container(
                    alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      AnalyticsUtil.logEvent("투표_시작_아이콘터치");
                    },
                    child: SlideTransition(
                      position: _animation,
                      child: Image.asset(
                        'assets/images/message.png',
                        width: SizeConfig.defaultSize * 30,
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: BlocBuilder<VoteCubit, VoteState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () {
                        AnalyticsUtil.logEvent("투표_시작_다음");
                        List<User> friendList = state.friends;
                        int friendCount = friendList.length;
                        if (friendCount >= 4) {
                          // 시작
                          BlocProvider.of<VoteCubit>(context).stepStart();
                        } else {
                          // 친구 초대
                          // 카카오톡 공유
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color(0xff7C83FD)),
                        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.only(left: SizeConfig.defaultSize * 3, right: SizeConfig.defaultSize * 3, top: SizeConfig.defaultSize * 0.5, bottom: SizeConfig.defaultSize * 0.5)),
                      ),
                      child: BlocBuilder<VoteCubit, VoteState>(
                        builder: (context, state) {
                          List<User> friendList = state.friends;
                          print(friendList);
                          return Text(
                            "시작하기",
                            // friendCount >= 4 ? "시작하기" : "친구 4명 만들고 시작하기",
                            style: TextStyle(fontSize: SizeConfig.defaultSize * 3, fontWeight: FontWeight.w600, color: Colors.white),
                          );
                        },
                      ),
                    );
                  }
                ),
              ),
              const Flexible(
                flex: 3,
                child: SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
