import 'package:dart_flutter/src/presentation/meet/viewmodel/meet_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dart_flutter/res/size_config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MeetLandingPage extends StatefulWidget {
  const MeetLandingPage({super.key});

  @override
  State<MeetLandingPage> createState() => _MeetLandingPageState();
}

class _MeetLandingPageState extends State<MeetLandingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _animation = Tween<double>(begin: 1.0, end: 0.99).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    // 애니메이션을 반복 실행하도록 설정
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(
            left: SizeConfig.screenWidth * 0.07,
            right: SizeConfig.screenWidth * 0.07),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: SizeConfig.screenHeight * 0.1,
            ),
            Text("가톨릭대학교",
                style: TextStyle(
                  fontSize: SizeConfig.defaultSize * 1.9,
                  fontWeight: FontWeight.w600,
                )), // TODO : school mockup 넣기
            SizedBox(
              height: SizeConfig.defaultSize * 0.4,
            ),
            Text("정보통신전자공학부 친구들과",
                style: TextStyle(
                  fontSize: SizeConfig.defaultSize * 1.9,
                  fontWeight: FontWeight.w600,
                )), // TODO : department mockup 넣기
            SizedBox(
              height: SizeConfig.defaultSize * 2,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TwoPeopleMatchingView(animationController: _animationController, animation: _animation),
                  ThreePeopleMatchingView(animationController: _animationController, animation: _animation),
                ]
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.03,),
            Center(
              child: Text("다양한 학과 학생들과 만날 수 있어요!", style: TextStyle(
                fontSize: SizeConfig.defaultSize * 1.7,
                fontWeight: FontWeight.w500,
              )),
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.15),
            Container(
              height: SizeConfig.defaultSize * 6,
              width: SizeConfig.screenWidth,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.indigoAccent,
                ),
                borderRadius: BorderRadius.circular(13),
              ),
              alignment: Alignment.center,
              child: Text("같이 과팅할 친구들 초대하기", style: TextStyle(
                fontSize: SizeConfig.defaultSize * 1.9,
                fontWeight: FontWeight.w600,
                color: Colors.indigoAccent,
              )),
            ),
          ],
        ),
      ),
    );
  }
}


class ThreePeopleMatchingView extends StatelessWidget {
  const ThreePeopleMatchingView({
    super.key,
    required AnimationController animationController,
    required Animation<double> animation,
  }) : _animationController = animationController, _animation = animation;

  final AnimationController _animationController;
  final Animation<double> _animation;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // 3대3
      onTap: () {
        BlocProvider.of<MeetCubit>(context).stepThreePeople();
      },
      child: Container(
        height: SizeConfig.screenHeight * 0.28,
        width: SizeConfig.screenWidth * 0.41,
        decoration: BoxDecoration(
          color: Colors.indigoAccent,
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Container(
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Transform.scale(
                scale: _animation.value,
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: SizeConfig.defaultSize * 2.5,
                        ),
                        Icon(
                          Icons.groups,
                          color: Colors.white,
                          size: SizeConfig.defaultSize * 11,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text("3대3",
                            style: TextStyle(
                              fontSize:
                                  SizeConfig.defaultSize * 2.7,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            )),
                        SizedBox(
                          height: SizeConfig.defaultSize * 0.5,
                        ),
                        Text("과팅",
                            style: TextStyle(
                              fontSize:
                                  SizeConfig.defaultSize * 2.2,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            )),
                        SizedBox(
                          height: SizeConfig.defaultSize * 3.5,
                        )
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class TwoPeopleMatchingView extends StatelessWidget {
  const TwoPeopleMatchingView({
    super.key,
    required AnimationController animationController,
    required Animation<double> animation,
  }) : _animationController = animationController, _animation = animation;

  final AnimationController _animationController;
  final Animation<double> _animation;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<MeetCubit>(context).stepTwoPeople();
      },
      child: Container(
        // 2대2
        height: SizeConfig.screenHeight * 0.28,
        width: SizeConfig.screenWidth * 0.41,
        decoration: BoxDecoration(
          color: Colors.indigoAccent,
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Container(
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Transform.scale(
                scale: _animation.value,
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: SizeConfig.defaultSize * 3,
                        ),
                        Icon(
                          Icons.group,
                          color: Colors.white,
                          size: SizeConfig.defaultSize * 10,
                        ),
                      ],
                    ),
                    // SizedBox(width: SizeConfig.screenWidth * 0.03,),
                    Column(
                      children: [
                        Text("2대2",
                            style: TextStyle(
                              fontSize:
                                  SizeConfig.defaultSize * 2.7,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            )),
                        SizedBox(
                          height: SizeConfig.defaultSize * 0.5,
                        ),
                        Text("과팅",
                            style: TextStyle(
                              fontSize:
                                  SizeConfig.defaultSize * 2.2,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            )),
                        SizedBox(
                          height: SizeConfig.defaultSize * 3.5,
                        )
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
