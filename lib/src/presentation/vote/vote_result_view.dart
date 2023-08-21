import 'package:dart_flutter/res/config/size_config.dart';
import 'package:dart_flutter/src/common/util/analytics_util.dart';
import 'package:dart_flutter/src/presentation/vote/vimemodel/vote_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VoteResultView extends StatefulWidget {
  VoteResultView({Key? key}) : super(key: key);

  @override
  State<VoteResultView> createState() => _VoteResultViewState();
}

class _VoteResultViewState extends State<VoteResultView> with SingleTickerProviderStateMixin {
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
        padding: EdgeInsets.only(left: SizeConfig.defaultSize , right: SizeConfig.defaultSize, top: SizeConfig.defaultSize * 5, bottom: SizeConfig.defaultSize * 5),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: [
                      Text(
                        "축하해요!",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: SizeConfig.defaultSize * 5,
                        ),
                      ),
                      SizedBox(height: SizeConfig.defaultSize * 2,),
                      GestureDetector(
                        onTap: () {
                          AnalyticsUtil.logEvent("투표_끝_포인트터치");
                        },
                        child: Text(
                          "투표를 통해 16 포인트를 획득했어요!",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: SizeConfig.defaultSize * 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: Container(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      AnalyticsUtil.logEvent("투표_끝_아이콘터치");
                    },
                    child: SlideTransition(
                      position: _animation,
                      child: Image.asset(
                        'assets/images/cloud.png',
                        width: SizeConfig.defaultSize * 30,
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        "다음 투표도 기대해보세요!",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: SizeConfig.defaultSize * 2.5,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.defaultSize * 2,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        AnalyticsUtil.logEvent("투표_끝_다음");
                        BlocProvider.of<VoteCubit>(context).stepDone();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color(0xff7C83FD)),
                        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.only(left: SizeConfig.defaultSize * 3, right: SizeConfig.defaultSize * 3, top: 0, bottom: 0)),
                      ),
                      child: Text(
                        "다음으로",
                        style: TextStyle(
                            fontSize: SizeConfig.defaultSize * 3.4, fontWeight: FontWeight.w600, color: Colors.white
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // const Flexible(
              //   flex: 1,
              //   child: SizedBox(),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

