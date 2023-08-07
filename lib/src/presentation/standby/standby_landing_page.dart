import 'package:dart_flutter/src/common/util/analytics_util.dart';
import 'package:dart_flutter/src/common/util/toast_util.dart';
import 'package:dart_flutter/src/presentation/page_view.dart';
import 'package:dart_flutter/src/presentation/signup/tutorial_slide.dart';
import 'package:dart_flutter/src/presentation/standby/viewmodel/standby_cubit.dart';
import 'package:dart_flutter/src/presentation/standby/viewmodel/state/standby_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../res/size_config.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/services.dart';

import '../../data/model/friend_dto.dart';
import '../mypage/friends_mock.dart';
import '../mypage/viewmodel/mypages_cubit.dart';
import '../mypage/viewmodel/state/mypages_state.dart';

class StandbyLandingPage extends StatefulWidget {
  const StandbyLandingPage({
    super.key,
  });

  @override
  State<StandbyLandingPage> createState() => _StandbyLandingPageState();
}

class _StandbyLandingPageState extends State<StandbyLandingPage> with TickerProviderStateMixin {
  final StandbyCubit _standbyCubit = StandbyCubit();
  bool _isUp = true;
  late AnimationController _controller;
  late Animation<Offset> _animation;

  // 질문 애니메이션
  int currentIndex = 0;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  List<String> questions = [
    "인스타에서 제일 관심가는 사람은?",
    "데뷔해 ! 너무 예뻐",
    "Y2K 무드가 잘 어울리는",
    "쇼핑 같이 가고 싶은 사람",
    "주식으로 10억 벌 것 같은 사람",
    "트렌드를 잘 아는 사람",
    "과팅에 데려가고 싶은 사람?"
  ];

  @override
  void initState() {
    super.initState();
    AnalyticsUtil.logEvent("대기_접속");

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation = Tween<Offset>(
      begin: Offset(0, 0.15),
      end: Offset(0, 0),
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

    _fadeController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _fadeAnimation = Tween<double>(begin: 0.3, end: 1).animate(_fadeController);
    _fadeController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(Duration(seconds: 3), () {
          setState(() {
            currentIndex = (currentIndex + 1) % questions.length;
          });
          _fadeController.reset();
          _fadeController.forward();
        });
      }
    });
    _fadeController.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff7C83FD),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: SizeConfig.screenHeight * 0.05,
              ),
              Container(
                width: SizeConfig.screenWidth,
                padding: EdgeInsets.only(left: SizeConfig.screenWidth * 0.07),
                child: Text(
                  "반가워요!",
                  style: TextStyle(
                    fontSize: SizeConfig.defaultSize * 2.5,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.011,
              ),
              Container(
                width: SizeConfig.screenWidth,
                padding: EdgeInsets.only(left: SizeConfig.screenWidth * 0.07),
                child: Text(
                  "친구 4명부터 이미지게임을 시작할 수 있어요!",
                  style: TextStyle(
                    fontSize: SizeConfig.defaultSize * 1.9,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.defaultSize * 3,
              ),
              Container(
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight * 1.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(25), topLeft: Radius.circular(25)),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: SizeConfig.defaultSize * 2.5, right: SizeConfig.defaultSize * 2.5),
                  child: Center(
                    child: Column(
                      children: [
                        // ßSizedBox(height: SizeConfig.screenHeight),
                        SizedBox(
                          height: SizeConfig.defaultSize * 0.4,
                        ),
                        GestureDetector(
                          onTap: () {
                            AnalyticsUtil.logEvent("대기_질문터치", properties: {"질문 인덱스": currentIndex});
                          },
                          child: AnimatedBuilder(
                            animation: _fadeAnimation,
                            builder: (context, child) {
                              return Opacity(
                                opacity: _fadeAnimation.value,
                                child: Text(
                                  '\n${questions[currentIndex]}',
                                  style: TextStyle(
                                      fontSize: SizeConfig.defaultSize * 2.4,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              );
                            },
                          ),
                        ),

                        SizedBox(height: SizeConfig.defaultSize),
                        // Image.asset(
                        //   'assets/images/dart_logo.png',
                        //   width: SizeConfig.defaultSize * 15.5,
                        //   height: SizeConfig.defaultSize * 15.5,
                        // ),
                        Container(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () {
                              AnalyticsUtil.logEvent("대기_아이콘터치");
                            },
                            child: SlideTransition(
                              position: _animation,
                              child: Image.asset(
                                'assets/images/letter.png',
                                width: SizeConfig.defaultSize * 25,
                              ),
                            ),
                          ),
                        ),
                        // SizedBox(height: SizeConfig.defaultSize * 1.5),
                        BlocBuilder<StandbyCubit, StandbyState>(builder: (context, state) {
                          if (state.isLoading) {
                            return CircularProgressIndicator();
                          } else {
                            List<FriendDto> friends = state.addedFriends;
                            int count = friends.length;
                            if (count >= 4) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                Navigator.pushAndRemoveUntil(context,
                                    MaterialPageRoute(builder: (context) => const DartPageView()), (route) => false);
                              }
                              );
                            }
                          }
                          return SizedBox.shrink();
                        }),

                        BlocBuilder<StandbyCubit, StandbyState>(builder: (context, state) {
                          List<FriendDto> friends = state.addedFriends;
                          int count = friends.length;

                          return Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: SizeConfig.defaultSize * 1.1, right: SizeConfig.defaultSize * 0.3),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    count >= 1
                                        ? FriendExistsView(
                                            userName: friends[0].name,
                                            admissionYear: friends[0].admissionYear.toString().substring(2, 4),
                                            friendIndex: 0,
                                          )
                                        : BlocBuilder<StandbyCubit, StandbyState>(builder: (context, state) {
                                            return FriendNotExistsView(
                                              myCode: state.userResponse.user?.recommendationCode ?? '내 코드가 없어요!',
                                              index: 0,
                                              friendCount: count,
                                              disabledFunctions: state.isLoading,
                                            );
                                          }),
                                    count >= 2
                                        ? FriendExistsView(
                                            userName: friends[1].name,
                                            admissionYear: friends[1].admissionYear.toString().substring(2, 4),
                                            friendIndex: 1,
                                          )
                                        : BlocBuilder<StandbyCubit, StandbyState>(builder: (context, state) {
                                            return FriendNotExistsView(
                                              myCode: state.userResponse.user?.recommendationCode ?? '내 코드가 없어요!',
                                              index: 1,
                                              friendCount: count,
                                              disabledFunctions: state.isLoading,
                                            );
                                          }),
                                  ],
                                ),
                              ),
                              SizedBox(height: SizeConfig.defaultSize * 1),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: SizeConfig.defaultSize * 1.1, right: SizeConfig.defaultSize * 0.3),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    count >= 3
                                        ? FriendExistsView(
                                            userName: friends[2].name,
                                            admissionYear: friends[2].admissionYear.toString().substring(2, 4),
                                            friendIndex: 2,
                                          )
                                        : BlocBuilder<StandbyCubit, StandbyState>(builder: (context, state) {
                                            return FriendNotExistsView(
                                              myCode: state.userResponse.user?.recommendationCode ?? '내 코드가 없어요!',
                                              index: 2,
                                              friendCount: count,
                                              disabledFunctions: state.isLoading,
                                            );
                                          }),
                                    count >= 4
                                        ? FriendExistsView(
                                            userName: friends[3].name,
                                            admissionYear: friends[3].admissionYear.toString().substring(2, 4),
                                            friendIndex: 3,
                                          )
                                        : BlocBuilder<StandbyCubit, StandbyState>(builder: (context, state) {
                                            return FriendNotExistsView(
                                              myCode: state.userResponse.user?.recommendationCode ?? '내 코드가 없어요!',
                                              index: 3,
                                              friendCount: count,
                                              disabledFunctions: state.isLoading,
                                            );
                                          }),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }),

                        SizedBox(
                          height: SizeConfig.defaultSize * 3,
                        ),
                        Text(
                          "위의 예시 질문처럼 이미지게임을 할 거예요!",
                          style: TextStyle(
                            fontSize: SizeConfig.defaultSize * 1.5,
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.defaultSize * 0.3,
                        ),
                        Text(
                          "선택지로 고르고 싶은 친구들을 추가하세요!",
                          style: TextStyle(
                            fontSize: SizeConfig.defaultSize * 1.5,
                          ),
                        ),
                        SizedBox(height: SizeConfig.defaultSize * 1),

                        BlocBuilder<StandbyCubit, StandbyState>(
                          builder: (context, state) {
                            List<FriendDto> friends = state.addedFriends;
                            int count = friends.length;
                            return openAddFriends(
                              myCode: state.userResponse.user?.recommendationCode ?? '내 코드가 없어요!',
                              disabledFunctions: state.isLoading,
                              friendCount: count,
                            );
                          },
                        ),
                        SizedBox(height: SizeConfig.defaultSize,),
                        Icon(Icons.keyboard_double_arrow_down_rounded,
                          size: SizeConfig.defaultSize * 4,
                          color: Colors.grey.shade300,),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: SizeConfig.defaultSize * 75,
                child: OnboardingSlide(),
              ),
              Container(
                height: SizeConfig.defaultSize * 3,
                color: Colors.white,
              ),
            ],
          ),
        ));
  }
}

class OnboardingSlide extends StatefulWidget {
  const OnboardingSlide({
    super.key,
  });

  @override
  State<OnboardingSlide> createState() => _OnboardingSlideState();
}

class _OnboardingSlideState extends State<OnboardingSlide> with TickerProviderStateMixin {
  final _pageController = PageController();
  bool isLastPage = false;

  bool _isUp = true; // 첫 번째 화면 애니메이션
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  // 질문 애니메이션
  int currentIndex = 0;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  List<String> questions = [
    "인스타에서 제일 관심가는 사람은?",
    "데뷔해 ! 너무 예뻐",
    "Y2K 무드가 잘 어울리는",
    "쇼핑 같이 가고 싶은 사람",
    "주식으로 10억 벌 것 같은 사람"
  ];

  // 두 번째 화면 애니메이션
  late AnimationController _fadeInOutController;
  late AnimationController _fadeInOutController2;
  late AnimationController _fadeInOutController3;
  late AnimationController _fadeInOutController4;
  late AnimationController _fadeInOutController5;
  late Animation<double> _fadeInOutAnimation;
  late Animation<double> _fadeInOutAnimation2;
  late Animation<double> _fadeInOutAnimation3;
  late Animation<double> _fadeInOutAnimation4;
  late Animation<double> _fadeInOutAnimation5;

  // 세 번째 화면 애니메이션
  late AnimationController _letterAnimationController;
  late Animation<double> _letterAnimation;

  @override
  void initState() {
    super.initState();
    // 첫 번째 화면 애니메이션
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation = Tween<Offset>(
      begin: Offset(0, 0.15),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _isUp = !_isUp;
        _animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _isUp = !_isUp;
        _animationController.forward();
      }
    });
    _animationController.forward();

    // 두 번째 화면 애니메이션
    _fadeInOutController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _fadeInOutAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_fadeInOutController);
    _fadeInOutController2 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _fadeInOutAnimation2 = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_fadeInOutController2);
    _fadeInOutController3 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _fadeInOutAnimation3 = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_fadeInOutController3);
    _fadeInOutController4 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _fadeInOutAnimation4 = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_fadeInOutController4);
    _fadeInOutController5 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _fadeInOutAnimation5 = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_fadeInOutController5);

    _fadeInOutAnimation.addStatusListener((status) {
      // 애니메이션 리스너 설정
      if (status == AnimationStatus.completed) {
        // 애니메이션이 완료되면 2초 대기 후 다시 실행
        Future.delayed(Duration(seconds: 5), () {
          _fadeInOutController.reverse();
        });
      } else if (status == AnimationStatus.dismissed) {
        // 애니메이션이 처음으로 돌아가면 다시 실행
        Future.delayed(Duration(seconds: 5), () {
          _fadeInOutController.forward();
        });
      }
    });
    _fadeInOutAnimation2.addStatusListener((status) {
      // 애니메이션 리스너 설정
      if (status == AnimationStatus.completed) {
        // 애니메이션이 완료되면 2초 대기 후 다시 실행
        Future.delayed(Duration(seconds: 5), () {
          _fadeInOutController2.reverse();
        });
      } else if (status == AnimationStatus.dismissed) {
        // 애니메이션이 처음으로 돌아가면 다시 실행
        Future.delayed(Duration(seconds: 5), () {
          _fadeInOutController2.forward();
        });
      }
    });
    _fadeInOutAnimation3.addStatusListener((status) {
      // 애니메이션 리스너 설정
      if (status == AnimationStatus.completed) {
        // 애니메이션이 완료되면 2초 대기 후 다시 실행
        Future.delayed(Duration(seconds: 5), () {
          _fadeInOutController3.reverse();
        });
      } else if (status == AnimationStatus.dismissed) {
        // 애니메이션이 처음으로 돌아가면 다시 실행
        Future.delayed(Duration(seconds: 5), () {
          _fadeInOutController3.forward();
        });
      }
    });
    _fadeInOutAnimation4.addStatusListener((status) {
      // 애니메이션 리스너 설정
      if (status == AnimationStatus.completed) {
        // 애니메이션이 완료되면 2초 대기 후 다시 실행
        Future.delayed(Duration(seconds: 5), () {
          _fadeInOutController4.reverse();
        });
      } else if (status == AnimationStatus.dismissed) {
        // 애니메이션이 처음으로 돌아가면 다시 실행
        Future.delayed(Duration(seconds: 5), () {
          _fadeInOutController4.forward();
        });
      }
    });
    _fadeInOutAnimation5.addStatusListener((status) {
      // 애니메이션 리스너 설정
      if (status == AnimationStatus.completed) {
        // 애니메이션이 완료되면 2초 대기 후 다시 실행
        Future.delayed(Duration(seconds: 5), () {
          _fadeInOutController5.reverse();
        });
      } else if (status == AnimationStatus.dismissed) {
        // 애니메이션이 처음으로 돌아가면 다시 실행
        Future.delayed(Duration(seconds: 5), () {
          _fadeInOutController5.forward();
        });
      }
    });

    Future.delayed(Duration(seconds: 1), () {
      _fadeInOutController.forward();
    });
    Future.delayed(Duration(seconds: 2), () {
      _fadeInOutController2.forward();
    });
    Future.delayed(Duration(seconds: 3), () {
      _fadeInOutController3.forward();
    });
    Future.delayed(Duration(seconds: 4), () {
      _fadeInOutController4.forward();
    });
    Future.delayed(Duration(seconds: 5), () {
      _fadeInOutController5.forward();
    });

    // 세 번째 페이지 애니메이션
    _letterAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );
    _letterAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(
        parent: _letterAnimationController,
        curve: Curves.easeInOut,
      ),
    );
    _letterAnimationController.repeat(reverse: true);

    _fadeController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _fadeAnimation = Tween<double>(begin: 0.3, end: 1).animate(_fadeController);
    _fadeController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(Duration(seconds: 2), () {
          setState(() {
            currentIndex = (currentIndex + 1) % questions.length;
          });
          _fadeController.reset();
          _fadeController.forward();
        });
      }
    });
    _fadeController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    _fadeInOutController.dispose();
    _fadeInOutController2.dispose();
    _fadeInOutController3.dispose();
    _fadeInOutController4.dispose();
    _fadeInOutController5.dispose();
    _letterAnimationController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Container(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() => isLastPage = index == 2);
                  },
                  children: [
                    GestureDetector(
                      onTap: () {
                        AnalyticsUtil.logEvent("대기_온보딩_첫번째터치");
                      },
                      child: Container(
                        color: Colors.white,
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: SizeConfig.screenHeight * 0.05,
                              ),
                              RichText(
                                  text: TextSpan(
                                      style: TextStyle(
                                          fontSize: SizeConfig.defaultSize * 2.2, fontWeight: FontWeight.w600),
                                      children: <TextSpan>[
                                    TextSpan(text: "엔대생에서는 ", style: TextStyle(color: Colors.black)),
                                    TextSpan(
                                        text: "긍정적인 질문",
                                        style: TextStyle(color: Color(0xff7C83FD), fontWeight: FontWeight.w800)),
                                    TextSpan(text: "에 대해", style: TextStyle(color: Colors.black)),
                                  ])),
                              SizedBox(height: SizeConfig.defaultSize * 0.3),
                              RichText(
                                  text: TextSpan(
                                      style: TextStyle(
                                          fontSize: SizeConfig.defaultSize * 2.2, fontWeight: FontWeight.w600),
                                      children: <TextSpan>[
                                    TextSpan(text: "내 친구들을 ", style: TextStyle(color: Colors.black)),
                                    TextSpan(text: "투표", style: TextStyle(color: Color(0xff7C83FD))),
                                    TextSpan(text: "할 수 있어요!", style: TextStyle(color: Colors.black)),
                                  ])),
                              SizedBox(height: SizeConfig.screenHeight * 0.08),

                              SlideTransition(
                                position: _animation,
                                child: Image.asset(
                                  'assets/images/contacts.png',
                                  width: SizeConfig.defaultSize * 20,
                                ),
                              ),
                              SizedBox(
                                height: SizeConfig.screenHeight * 0.06,
                              ),
                              AnimatedBuilder(
                                animation: _fadeAnimation,
                                builder: (context, child) {
                                  return Opacity(
                                    opacity: _fadeAnimation.value,
                                    child: Text(
                                      questions[currentIndex],
                                      style: TextStyle(fontSize: SizeConfig.defaultSize * 2.4),
                                    ),
                                  );
                                },
                              ),
                              // Text("${questions[0]}", style: TextStyle(fontSize: SizeConfig.defaultSize * 2, fontWeight: FontWeight.w600),),
                              SizedBox(
                                height: SizeConfig.defaultSize * 2.5,
                              ),

                              Container(
                                width: SizeConfig.screenWidth * 0.83,
                                height: SizeConfig.defaultSize * 18,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        FriendView(name: "강해린", enterYear: "23", department: "경영학과"),
                                        FriendView(name: "김민지", enterYear: "22", department: "물리학과")
                                      ],
                                    ),
                                    SizedBox(
                                      height: SizeConfig.defaultSize,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        FriendView(name: "이영지", enterYear: "21", department: "실용음악과"),
                                        FriendView(name: "카리나", enterYear: "19", department: "패션디자인학과")
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        AnalyticsUtil.logEvent("대기_온보딩_두번째터치");
                      },
                      child: Container(
                        color: Colors.white,
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: SizeConfig.screenHeight * 0.1,
                              ),
                              RichText(
                                  text: TextSpan(
                                      style: TextStyle(
                                          fontSize: SizeConfig.defaultSize * 2.2, fontWeight: FontWeight.w600),
                                      children: <TextSpan>[
                                    TextSpan(text: "내가 투표받으면 ", style: TextStyle(color: Colors.black)),
                                    TextSpan(
                                        text: "알림",
                                        style: TextStyle(color: Color(0xff7C83FD), fontWeight: FontWeight.w800)),
                                    TextSpan(text: "이 와요!", style: TextStyle(color: Colors.black)),
                                  ])),
                              SizedBox(height: SizeConfig.defaultSize * 0.3),
                              Text(
                                "친구들도 내가 보낸 투표를 봐요!",
                                style: TextStyle(fontSize: SizeConfig.defaultSize * 2.2, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: SizeConfig.screenHeight * 0.1),
                              FadeTransition(
                                opacity: _fadeInOutAnimation,
                                child: VoteFriend(
                                    admissionYear: "23",
                                    gender: "여",
                                    question: "6번째 뉴진스 멤버",
                                    datetime: "10초 전",
                                    index: 0),
                              ),
                              SizedBox(height: SizeConfig.defaultSize * 1.6),
                              FadeTransition(
                                opacity: _fadeInOutAnimation2,
                                child: VoteFriend(
                                  admissionYear: "21",
                                  gender: "남",
                                  question: "모임에 꼭 있어야 하는",
                                  datetime: "1분 전",
                                  index: 1,
                                ),
                              ),
                              SizedBox(height: SizeConfig.defaultSize * 1.6),
                              FadeTransition(
                                opacity: _fadeInOutAnimation3,
                                child: VoteFriend(
                                  admissionYear: "22",
                                  gender: "여",
                                  question: "OO와의 2023 ... 여름이었다",
                                  datetime: "5분 전",
                                  index: 2,
                                ),
                              ),
                              SizedBox(height: SizeConfig.defaultSize * 1.6),
                              FadeTransition(
                                opacity: _fadeInOutAnimation4,
                                child: VoteFriend(
                                  admissionYear: "20",
                                  gender: "남",
                                  question: "디올 엠베서더 할 것 같은 사람",
                                  datetime: "10분 전",
                                  index: 3,
                                ),
                              ),
                              SizedBox(height: SizeConfig.defaultSize * 1.6),
                              FadeTransition(
                                opacity: _fadeInOutAnimation5,
                                child: VoteFriend(
                                  admissionYear: "23",
                                  gender: "남",
                                  question: "OOO 갓생 폼 미쳤다",
                                  datetime: "30분 전",
                                  index: 4,
                                ),
                              ),
                              SizedBox(height: SizeConfig.defaultSize * 1.6),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        AnalyticsUtil.logEvent("대기_온보딩_세번째터치");
                      },
                      child: Container(
                        color: Colors.white,
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: SizeConfig.screenHeight * 0.1,
                              ),
                              Text(
                                "누가 나에게 관심을 갖고 있는지",
                                style: TextStyle(fontSize: SizeConfig.defaultSize * 2.2, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: SizeConfig.defaultSize * 0.3),
                              Text(
                                "궁금하지 않으신가요?",
                                style: TextStyle(fontSize: SizeConfig.defaultSize * 2.2, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: SizeConfig.screenHeight * 0.1),
                              Container(
                                child: AnimatedBuilder(
                                  animation: _letterAnimationController,
                                  builder: (context, child) {
                                    return Transform.scale(
                                      scale: _letterAnimation.value,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/images/letter.png',
                                            // color: Colors.indigo,
                                            width: SizeConfig.defaultSize * 33,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: SizeConfig.screenHeight * 0.01),
                              Text(
                                "나를 향한 투표들이 기다리고 있어요!",
                                style: TextStyle(fontSize: SizeConfig.defaultSize * 2, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: SizeConfig.defaultSize * 1),
                              Text(
                                "친구들과 즐기러 가볼까요?",
                                style: TextStyle(fontSize: SizeConfig.defaultSize * 2, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ), // Replace YourPageViewWidget with your actual PageView widget
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: SizeConfig.defaultSize * 1.5),
            child: SmoothPageIndicator(
              controller: _pageController,
              count: 3,
              effect: WormEffect(
                activeDotColor: Color(0xff7C83FD),
                dotColor: Colors.grey.shade200,
                dotHeight: SizeConfig.defaultSize,
                dotWidth: SizeConfig.defaultSize,
                spacing: SizeConfig.defaultSize * 1.5,
              ),
              onDotClicked: (index) => _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FriendNotExistsView extends StatefulWidget {
  final String myCode;
  final int index;
  final int friendCount;
  late bool disabledFunctions;


  FriendNotExistsView({
    super.key,
    required this.myCode,
    required this.index,
    required this.friendCount,
    this.disabledFunctions = false,
  });

  @override
  State<FriendNotExistsView> createState() => _FriendNotExistsViewState();
}

class _FriendNotExistsViewState extends State<FriendNotExistsView> {
  var friendCode = "";

  @override
  Widget build(BuildContext context) {
    // 친구 없음 | 비어있어요!
    return GestureDetector(
      onTap: () {
        AnalyticsUtil.logEvent("대기_눌러서친추_버튼터치", properties: {"버튼 인덱스": widget.index, "현재 친구 수": widget.friendCount});
        showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            backgroundColor: Colors.white,
            isScrollControlled: true,
            builder: (BuildContext _) {
              AnalyticsUtil.logEvent("대기_눌러서친추_접속");
              return StatefulBuilder(
                builder: (BuildContext statefulContext, StateSetter thisState) {
                  return Container(
                    width: SizeConfig.screenWidth,
                    height: SizeConfig.screenHeight * 0.8,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(SizeConfig.defaultSize),
                                child: IconButton(
                                    onPressed: () {
                                      AnalyticsUtil.logEvent("대기_눌러서친추_닫기");
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(Icons.close_rounded, color: Colors.black, size: SizeConfig.defaultSize * 3,)),
                              ),
                            ],
                          ),
                          SizedBox(height: SizeConfig.defaultSize * 2),
                          Text(
                            "친구를 추가해요!",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: SizeConfig.defaultSize * 2.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: SizeConfig.defaultSize * 1.5),
                          Text(
                            "친구 코드를 입력하면 내 친구로 추가할 수 있어요!",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: SizeConfig.defaultSize * 1.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: SizeConfig.defaultSize * 2),
                          SizedBox(
                            width: SizeConfig.defaultSize * 3,
                            height: SizeConfig.defaultSize * 3,
                            child: widget.disabledFunctions ? const CircularProgressIndicator(color: Color(0xff7C83FD)) : null,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: SizeConfig.defaultSize * 2, right: SizeConfig.defaultSize),
                            child: Container(
                              // 친구 추가 버튼
                              width: SizeConfig.screenWidth * 0.9,
                              // height: SizeConfig.defaultSize * 9,
                              // color: Colors.white,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.white
                                    // color: Color(0xff7C83FD),
                                  ),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("내 코드",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: SizeConfig.defaultSize * 2,
                                        fontWeight: FontWeight.w600,
                                      )),
                                  SizedBox(height: SizeConfig.defaultSize * 0.5,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        widget.myCode,
                                        style: TextStyle(
                                          fontSize: SizeConfig.defaultSize * 1.9,
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          AnalyticsUtil.logEvent("대기_눌러서친추_내코드복사");
                                          String myCodeCopy = widget.myCode;
                                          Clipboard.setData(ClipboardData(
                                              text:
                                              myCodeCopy)); // 클립보드에 복사되었어요 <- 메시지 자동으로 Android에서 뜸 TODO : iOS는 확인하고 복사멘트 띄우기
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.white,
                                          onPrimary: Color(0xff7C83FD),
                                          textStyle: TextStyle(
                                            color: Color(0xff7C83FD),
                                          ),
                                          // backgroundColor: Color(0xff7C83FD),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15), // 모서리 둥글기 설정
                                          ),
                                          surfaceTintColor: Colors.white,
                                        ),
                                        child: Text(
                                          "복사",
                                          style: TextStyle(
                                            fontSize: SizeConfig.defaultSize * 1.7,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: SizeConfig.defaultSize * 3.2),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("친구가 아직 엔대생에 가입하지 않았다면?",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: SizeConfig.defaultSize * 1.5,
                                    fontWeight: FontWeight.w500,
                                  )),
                            ],
                          ),
                          SizedBox(height: SizeConfig.defaultSize ,),

                          GestureDetector(
                            onTap: () {
                              AnalyticsUtil.logEvent("대기_눌러서친추_링크공유");
                              shareContent(context, widget.myCode);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(left: SizeConfig.defaultSize, right: SizeConfig.defaultSize),
                              child: Container(
                                // 친구 추가 버튼
                                width: SizeConfig.screenWidth * 0.9,
                                height: SizeConfig.defaultSize * 5.5,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Color(0xff7C83FD),
                                    // color: Colors.white,
                                    border: Border.all(
                                      color: Color(0xff7C83FD),
                                    ),
                                    borderRadius: BorderRadius.circular(15)),
                                child: Text(
                                  "친구에게 링크 공유하기",
                                  style: TextStyle(
                                    fontSize: SizeConfig.defaultSize * 1.8,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                    // color: Color(0xff7C83FD),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: SizeConfig.defaultSize * 4),

                          Container(
                            width: SizeConfig.screenWidth,
                            height: SizeConfig.defaultSize * 2.5,
                            color: Colors.grey.shade100
                          ),
                          SizedBox(height: SizeConfig.defaultSize * 3,),


                          Padding( // 친구추가
                            padding: EdgeInsets.only(left: SizeConfig.defaultSize, right: SizeConfig.defaultSize),
                            child: Container(
                              width: SizeConfig.screenWidth * 0.9,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.white
                                    // color: Color(0xff7C83FD),
                                  ),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: SizeConfig.defaultSize * 0.5),
                                    child: Text("친구 추가",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: SizeConfig.defaultSize * 2,
                                          fontWeight: FontWeight.w600,
                                        )),
                                  ),
                                  SizedBox(height: SizeConfig.defaultSize * 0.5),
                                  Padding(
                                    padding: EdgeInsets.only(left: SizeConfig.defaultSize * 0.5),
                                    child: Text("친구 4명을 추가하면 게임을 시작할 수 있어요!",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: SizeConfig.defaultSize * 1.5,
                                          fontWeight: FontWeight.w400,
                                        )),
                                  ),
                                  SizedBox(height: SizeConfig.defaultSize * 1.5),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: SizeConfig.screenWidth * 0.65,
                                        child: TextField(
                                          scrollPadding: EdgeInsets.only(bottom: SizeConfig.screenHeight * 0.4),
                                          onChanged: (text) {
                                            friendCode = text;
                                          },
                                          style: TextStyle(
                                              fontSize: SizeConfig.defaultSize * 1.7
                                          ),
                                          autocorrect: true,
                                          decoration: InputDecoration(
                                            hintText: '친구 코드를 여기에 입력해주세요!',
                                            hintStyle: TextStyle(color: Colors.grey, fontSize: SizeConfig.defaultSize * 1.5),
                                            filled: true,
                                            fillColor: Colors.white,
                                            contentPadding: EdgeInsets.symmetric(
                                                vertical: SizeConfig.defaultSize * 1.5, horizontal: SizeConfig.defaultSize * 1.5),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                              borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                              borderSide: BorderSide(color: Color(0xff7C83FD)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      ElevatedButton( // 친구 추가 버튼
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: widget.disabledFunctions ? Colors.grey.shade400 : Color(0xff7C83FD),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15), // 모서리 둥글기 설정
                                          ),
                                          padding: EdgeInsets.only(left: SizeConfig.defaultSize * 2.12, right: SizeConfig.defaultSize * 2.12),
                                        ),
                                        onPressed: () async {
                                          String friendCodeConfirm = "";
                                          // 친구추가 중인 경우 버튼 동작 X
                                          if (widget.disabledFunctions) {
                                            return;
                                          }

                                          if (friendCode == widget.myCode) {
                                            ToastUtil.itsMyCodeToast("나는 친구로 추가할 수 없어요!");
                                            friendCodeConfirm = "나";
                                          } else {
                                            print("friendCode $friendCode");
                                            // try {
                                            try {
                                              // ModalBottomSheet 상태 update를 위해 필요함
                                              thisState(() {
                                                setState(() {
                                                  widget.disabledFunctions = true;
                                                });
                                              });

                                              // 실제 친구 추가 동작
                                              await BlocProvider.of<StandbyCubit>(context).pressedFriendCodeAddButton(friendCode);
                                              print(context.toString());

                                              ToastUtil.showAddFriendToast("친구가 추가되었어요!");
                                              friendCodeConfirm = "정상";
                                              Navigator.pop(context);
                                            } catch (e) {
                                              print(e);
                                              ToastUtil.showToast('친구코드를 다시 한번 확인해주세요!');
                                              friendCodeConfirm = "없거나 이미 친구임";
                                            }

                                            thisState(() {
                                              setState(() {
                                                widget.disabledFunctions = false;
                                              });
                                            });
                                            AnalyticsUtil.logEvent("대기_눌러서친추_친구코드_추가", properties: {
                                              '친구코드 번호': friendCode, '친구코드 정상여부': friendCodeConfirm
                                            });
                                          }
                                        },
                                        child: Text("추가",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: SizeConfig.defaultSize * 1.7)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: SizeConfig.defaultSize * 3),

                          Padding(
                            // padding: const EdgeInsets.all(8.0),
                            padding: EdgeInsets.only(left: SizeConfig.defaultSize * 2.6, right: SizeConfig.defaultSize * 2),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("알 수도 있는 친구",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: SizeConfig.defaultSize * 1.9,
                                          color: Color(0xff7C83FD)
                                      ),),
                                  ],
                                ),
                                // SizedBox(height: SizeConfig.defaultSize * 0.5,),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Text("나를 추가한 / 같은 학교 / 내 친구의 친구들이에요!",
                                //       style: TextStyle(
                                //           fontWeight: FontWeight.w400,
                                //           fontSize: SizeConfig.defaultSize * 1.4,
                                //           color: Colors.grey
                                //       ),),
                                //   ],
                                // ),
                                SizedBox(height: SizeConfig.defaultSize * 1.5,),
                                BlocProvider<StandbyCubit>.value(
                                    value: BlocProvider.of<StandbyCubit>(context),
                                    child: BlocBuilder<StandbyCubit, StandbyState>(
                                      builder: (friendContext, state) {
                                        final friends = state.newFriends ?? [];
                                        return NewFriends(friends: friends, count: friends.length);
                                      },
                                    ),
                                  ),
                                SizedBox(height: SizeConfig.defaultSize * 1.5,),
                                BlocProvider<StandbyCubit>.value( // BlocProvider로 감싸기
                                  value: BlocProvider.of<StandbyCubit>(context),
                                  child: BlocBuilder<StandbyCubit, StandbyState>(
                                    builder: (friendContext, state) {
                                      final friends = state.newFriends ?? [];
                                      return friends.length <= 2
                                          ? SizedBox(height: SizeConfig.screenHeight * 0.4,)
                                          : SizedBox(height: SizeConfig.defaultSize * 2,);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            });
      },
      child: Container(
        // 친구 없을 때
        width: SizeConfig.screenWidth * 0.4,
        height: SizeConfig.defaultSize * 8,
        decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(15)),
        // decoration: BoxDecoration(
        //     border: Border.all(
        //       color: Colors.grey.shade400,
        //       width: 1.3,
        //     ),
        //     borderRadius: BorderRadius.circular(15)),
        alignment: Alignment.center,
        child: Text(
          "눌러서 친구추가",
          style: TextStyle(
            fontSize: SizeConfig.defaultSize * 1.8,
          ),
        ),
      ),
    );
  }
}

class FriendExistsView extends StatelessWidget {
  // 친구 존재 | 학번, 이름
  final String? userName;
  final String? admissionYear;
  final int friendIndex;

  const FriendExistsView({super.key, required this.userName, required this.admissionYear, required this.friendIndex});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AnalyticsUtil.logEvent("대기_선택지친구터치", properties: {
          "친구 인덱스": friendIndex
        });
      },
      child: Container(
          // 친구 있을 때
          width: SizeConfig.screenWidth * 0.4,
          height: SizeConfig.defaultSize * 8,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Color(0xff7C83FD),
              border: Border.all(
                color: Color(0xff7C83FD),
              ),
              borderRadius: BorderRadius.circular(15)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/check_circle.png',
                    width: SizeConfig.defaultSize * 2,
                    height: SizeConfig.defaultSize * 2,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: SizeConfig.defaultSize * 0.5,
                  ),
                  Text("완료!",
                      style: TextStyle(
                        fontSize: SizeConfig.defaultSize * 1.6,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      )),
                ],
              ),
              SizedBox(
                height: SizeConfig.defaultSize * 0.2,
              ),
              Text(
                "$admissionYear학번 $userName",
                style: TextStyle(
                  fontSize: SizeConfig.defaultSize * 1.8,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          )),
    );
  }
}

// modal bottom View
class openAddFriends extends StatefulWidget {
  late String myCode;
  late bool disabledFunctions;
  late int friendCount;

  openAddFriends({
    super.key,
    required this.myCode,
    this.disabledFunctions = false,
    required this.friendCount,
  });

  @override
  State<openAddFriends> createState() => _openAddFriendsState();
}

class _openAddFriendsState extends State<openAddFriends> {
  var friendCode = "";

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // ModalBottomSheet 열기
        AnalyticsUtil.logEvent('대기_선택지에친구넣기', properties: {"현재 친구 수": widget.friendCount});
        showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            backgroundColor: Colors.white,
            isScrollControlled: true,
            builder: (BuildContext _) {
              AnalyticsUtil.logEvent("대기_친추_접속");
              return StatefulBuilder(
                builder: (BuildContext statefulContext, StateSetter thisState) {
                  return Container(
                    width: SizeConfig.screenWidth,
                    height: SizeConfig.screenHeight * 0.8,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(SizeConfig.defaultSize),
                                child: IconButton(
                                    onPressed: () {
                                      AnalyticsUtil.logEvent("대기_친추_닫기");
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(Icons.close_rounded, color: Colors.black, size: SizeConfig.defaultSize * 3,)),
                              ),
                            ],
                          ),
                          SizedBox(height: SizeConfig.defaultSize * 2),
                          Text(
                            "친구를 추가해요!",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: SizeConfig.defaultSize * 2.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: SizeConfig.defaultSize * 1.5),
                          Text(
                            "친구 코드를 입력하면 내 친구로 추가할 수 있어요!",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: SizeConfig.defaultSize * 1.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: SizeConfig.defaultSize * 2),
                          SizedBox(
                            width: SizeConfig.defaultSize * 3,
                            height: SizeConfig.defaultSize * 3,
                            child: widget.disabledFunctions ? const CircularProgressIndicator(color: Color(0xff7C83FD)) : null,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: SizeConfig.defaultSize * 2, right: SizeConfig.defaultSize),
                            child: Container(
                              // 친구 추가 버튼
                              width: SizeConfig.screenWidth * 0.9,
                              // height: SizeConfig.defaultSize * 9,
                              // color: Colors.white,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.white
                                    // color: Color(0xff7C83FD),
                                  ),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("내 코드",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: SizeConfig.defaultSize * 2,
                                        fontWeight: FontWeight.w600,
                                      )),
                                  SizedBox(height: SizeConfig.defaultSize * 0.5,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        widget.myCode,
                                        style: TextStyle(
                                          fontSize: SizeConfig.defaultSize * 1.9,
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          AnalyticsUtil.logEvent("대기_친추_내코드복사");
                                          String myCodeCopy = widget.myCode;
                                          Clipboard.setData(ClipboardData(
                                              text:
                                              myCodeCopy)); // 클립보드에 복사되었어요 <- 메시지 자동으로 Android에서 뜸 TODO : iOS는 확인하고 복사멘트 띄우기
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.white,
                                          onPrimary: Color(0xff7C83FD),
                                          textStyle: TextStyle(
                                            color: Color(0xff7C83FD),
                                          ),
                                          // backgroundColor: Color(0xff7C83FD),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15), // 모서리 둥글기 설정
                                          ),
                                          surfaceTintColor: Colors.white,
                                        ),
                                        child: Text(
                                          "복사",
                                          style: TextStyle(
                                            fontSize: SizeConfig.defaultSize * 1.7,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: SizeConfig.defaultSize * 3.2),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("친구가 아직 엔대생에 가입하지 않았다면?",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: SizeConfig.defaultSize * 1.5,
                                    fontWeight: FontWeight.w500,
                                  )),
                            ],
                          ),
                          SizedBox(height: SizeConfig.defaultSize ,),
                          GestureDetector(
                            onTap: () {
                              AnalyticsUtil.logEvent("대기_친추_링크공유");
                              shareContent(context, widget.myCode);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(left: SizeConfig.defaultSize, right: SizeConfig.defaultSize),
                              child: Container(
                                // 친구 추가 버튼
                                width: SizeConfig.screenWidth * 0.9,
                                height: SizeConfig.defaultSize * 5.5,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Color(0xff7C83FD),
                                    // color: Colors.white,
                                    border: Border.all(
                                      color: Color(0xff7C83FD),
                                    ),
                                    borderRadius: BorderRadius.circular(15)),
                                child: Text(
                                  "친구에게 링크 공유하기",
                                  style: TextStyle(
                                    fontSize: SizeConfig.defaultSize * 1.8,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                    // color: Color(0xff7C83FD),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: SizeConfig.defaultSize * 4),

                          Container(
                              width: SizeConfig.screenWidth,
                              height: SizeConfig.defaultSize * 2.5,
                              color: Colors.grey.shade100
                          ),
                          SizedBox(height: SizeConfig.defaultSize * 3,),


                          Padding( // 친구추가
                            padding: EdgeInsets.only(left: SizeConfig.defaultSize, right: SizeConfig.defaultSize),
                            child: Container(
                              width: SizeConfig.screenWidth * 0.9,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.white
                                    // color: Color(0xff7C83FD),
                                  ),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: SizeConfig.defaultSize * 0.5),
                                    child: Text("친구 추가",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: SizeConfig.defaultSize * 2,
                                          fontWeight: FontWeight.w600,
                                        )),
                                  ),
                                  SizedBox(height: SizeConfig.defaultSize * 0.5),
                                  Padding(
                                    padding: EdgeInsets.only(left: SizeConfig.defaultSize * 0.5),
                                    child: Text("친구 4명을 추가하면 게임을 시작할 수 있어요!",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: SizeConfig.defaultSize * 1.5,
                                          fontWeight: FontWeight.w400,
                                        )),
                                  ),
                                  SizedBox(height: SizeConfig.defaultSize * 1.5),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: SizeConfig.screenWidth * 0.65,
                                        child: TextField(
                                          scrollPadding: EdgeInsets.only(bottom: SizeConfig.screenHeight * 0.4),
                                          onChanged: (text) {
                                            friendCode = text;
                                          },
                                          style: TextStyle(
                                              fontSize: SizeConfig.defaultSize * 1.7
                                          ),
                                          autocorrect: true,
                                          decoration: InputDecoration(
                                            hintText: '친구 코드를 여기에 입력해주세요!',
                                            hintStyle: TextStyle(color: Colors.grey, fontSize: SizeConfig.defaultSize * 1.5),
                                            filled: true,
                                            fillColor: Colors.white,
                                            contentPadding: EdgeInsets.symmetric(
                                                vertical: SizeConfig.defaultSize * 1.5, horizontal: SizeConfig.defaultSize * 1.5),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                              borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                              borderSide: BorderSide(color: Color(0xff7C83FD)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      ElevatedButton( // 친구 추가 버튼
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: widget.disabledFunctions ? Colors.grey.shade400 : Color(0xff7C83FD),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15), // 모서리 둥글기 설정
                                          ),
                                          padding: EdgeInsets.only(left: SizeConfig.defaultSize * 2.12, right: SizeConfig.defaultSize * 2.12),
                                        ),
                                        onPressed: () async {
                                          String friendCodeConfirm = "";
                                          // 친구추가 중인 경우 버튼 동작 X
                                          if (widget.disabledFunctions) {
                                            return;
                                          }

                                          if (friendCode == widget.myCode) {
                                            ToastUtil.itsMyCodeToast("나는 친구로 추가할 수 없어요!");
                                            friendCodeConfirm = "나";
                                          } else {
                                            print("friendCode $friendCode");
                                            // try {
                                            try {
                                              // ModalBottomSheet 상태 update를 위해 필요함
                                              thisState(() {
                                                setState(() {
                                                  widget.disabledFunctions = true;
                                                });
                                              });

                                              // 실제 친구 추가 동작
                                              await BlocProvider.of<StandbyCubit>(context).pressedFriendCodeAddButton(friendCode);
                                              print(context.toString());

                                              ToastUtil.showAddFriendToast("친구가 추가되었어요!");
                                              friendCodeConfirm = "정상";
                                              Navigator.pop(context);
                                            } catch (e) {
                                              print(e);
                                              ToastUtil.showToast('친구코드를 다시 한번 확인해주세요!');
                                              friendCodeConfirm = "없거나 이미 친구임";
                                            }

                                            thisState(() {
                                              setState(() {
                                                widget.disabledFunctions = false;
                                              });
                                            });
                                            AnalyticsUtil.logEvent("대기_친추_친구코드_추가", properties: {
                                              '친구코드 번호': friendCode, '친구코드 정상여부': friendCodeConfirm
                                            });
                                          }
                                        },
                                        child: Text("추가",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: SizeConfig.defaultSize * 1.7)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: SizeConfig.defaultSize * 3),

                          Padding(
                            // padding: const EdgeInsets.all(8.0),
                            padding: EdgeInsets.only(left: SizeConfig.defaultSize * 2.6, right: SizeConfig.defaultSize * 2),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("알 수도 있는 친구",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: SizeConfig.defaultSize * 1.9,
                                          color: Color(0xff7C83FD)
                                      ),),
                                  ],
                                ),
                                // SizedBox(height: SizeConfig.defaultSize * 0.5),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Text("나를 추가한 / 같은 학교 / 내 친구의 친구들이에요!",
                                //       style: TextStyle(
                                //           fontWeight: FontWeight.w400,
                                //           fontSize: SizeConfig.defaultSize * 1.4,
                                //           color: Colors.grey
                                //       ),),
                                //   ],
                                // ),
                                SizedBox(height: SizeConfig.defaultSize * 1.5,),
                                BlocProvider<StandbyCubit>.value(
                                  value: BlocProvider.of<StandbyCubit>(context),
                                  child: BlocBuilder<StandbyCubit, StandbyState>(
                                    builder: (friendContext, state) {
                                      final friends = state.newFriends ?? [];
                                      return NewFriends(friends: friends, count: friends.length);
                                    },
                                  ),
                                ),
                                BlocProvider<StandbyCubit>.value( // BlocProvider로 감싸기
                                  value: BlocProvider.of<StandbyCubit>(context),
                                  child: BlocBuilder<StandbyCubit, StandbyState>(
                                    builder: (friendContext, state) {
                                      final friends = state.newFriends ?? [];
                                      return friends.length <= 2
                                          ? SizedBox(height: SizeConfig.screenHeight * 0.4,)
                                          : SizedBox(height: SizeConfig.defaultSize * 2,);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            });
      },
      child: Padding(
        padding: EdgeInsets.only(left: SizeConfig.defaultSize, right: SizeConfig.defaultSize),
        child: Container(
          // 친구 추가 버튼
          width: SizeConfig.screenWidth * 0.9,
          height: SizeConfig.defaultSize * 5.5,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Color(0xff7C83FD),
              ),
              borderRadius: BorderRadius.circular(15)),
          child: Text(
            "선택지에 친구 넣기",
            style: TextStyle(
              fontSize: SizeConfig.defaultSize * 1.8,
              fontWeight: FontWeight.w800,
              color: Color(0xff7C83FD),
            ),
          ),
        ),
      ),
    );
  }
}

void shareContent(BuildContext context, String myCode) {
  Share.share('엔대생에서 내가 널 칭찬 대상으로 투표하고 싶어! 앱에 들어와줘!\n내 코드는 $myCode 야. 나를 친구 추가하고 같이하자!\nhttps://dart.page.link/TG78\n\n내 코드 : $myCode');
  print("셰어");
}

class NewFriends extends StatelessWidget {
  final List<FriendDto> friends;
  final int count;

  const NewFriends({
    super.key,
    required this.friends,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < count; i++)
          NotFriendComponent(true, friends[i]),
      ],
    );
  }
}
class NotFriendComponent extends StatelessWidget {
  late bool isAdd;
  late FriendDto friend;

  NotFriendComponent(bool isAdd, FriendDto friend, {super.key}) {
    this.isAdd = isAdd;
    this.friend = friend;
  }

  void pressedAddButton(BuildContext context, int userId) {
    BlocProvider.of<StandbyCubit>(context).pressedFriendAddButton(friend);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: SizeConfig.defaultSize * 0.1,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                AnalyticsUtil.logEvent("대기_친추_알수도있는친구_목록터치", properties: {
                  "친구 성별": friend.gender=="FEMALE" ? "여자" : "남자",
                  "친구 학번": friend.admissionYear.toString().substring(2,4),
                  "친구 학교": friend.university!.name,
                  "친구 학교코드": friend.university!.id,
                  "친구 학과": friend.university!.department
                });
              },
              child: Container(
                width: SizeConfig.screenWidth * 0.52,
                child: Row(
                  children: [
                    Text(friend.name ?? "XXX", style: TextStyle(
                      fontSize: SizeConfig.defaultSize * 1.9,
                      fontWeight: FontWeight.w600,
                    )),
                    Container(
                      width: SizeConfig.screenWidth * 0.36,
                      child: Text("  ${friend.admissionYear.toString().substring(2,4)}학번∙${friend.university?.department}", style: TextStyle(
                        fontSize: SizeConfig.defaultSize * 1.3,
                        fontWeight: FontWeight.w500,
                        overflow: TextOverflow.ellipsis,
                      )),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: SizeConfig.defaultSize,),

            PopupMenuButton<String>(
              icon: Icon(Icons.more_horiz_rounded, color: Colors.grey.shade300,),
              color: Colors.white,
              surfaceTintColor: Colors.white,
              onSelected: (value) {
                // 팝업 메뉴에서 선택된 값 처리
                if (value == 'report') {
                  AnalyticsUtil.logEvent("대기_친추_알수도있는친구더보기_신고");
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      backgroundColor: Colors.white,
                      surfaceTintColor: Colors.white,
                      title: const Text('사용자를 신고하시겠어요?'),
                      content: const Text('사용자를 신고하면 엔대생에서 빠르게 신고 처리를 해드려요!'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            AnalyticsUtil.logEvent("대기_친추_알수도있는친구더보기_신고_취소");
                            Navigator.pop(context, '취소');
                          },
                          child: const Text('취소', style: TextStyle(color: Color(0xff7C83FD)),),
                        ),
                        TextButton(
                          onPressed: () => {
                            AnalyticsUtil.logEvent("대기_친추_알수도있는친구더보기_신고_신고확정"),
                            Navigator.pop(context, '신고'),
                            ToastUtil.showToast("사용자가 신고되었어요!"),
                            // TODO : 신고 기능 (서버 연결)
                          },
                          child: const Text('신고', style: TextStyle(color: Color(0xff7C83FD)),),
                        ),
                      ],
                    ),
                  );
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem<String>(
                    value: 'report',
                    child: Text("신고하기", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.5)),
                  ),
                ];
              },
            ),

            ElevatedButton(
              onPressed: () {
                AnalyticsUtil.logEvent("대기_친추_알수도있는친구_친구추가");
                if (isAdd) {
                  pressedAddButton(context, friend.userId!);
                  // Navigator.pop(context);
                }
                // else {
                //   pressedDeleteButton(context, friend.userId!);
                // }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff7C83FD),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // 모서리 둥글기 설정
                ),
              ),
              child: Text(isAdd?"추가":"삭제", style: TextStyle(
                fontSize: SizeConfig.defaultSize * 1.5,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              )),
            ),
          ],
        ),
        SizedBox(height: SizeConfig.defaultSize * 0.1,),
        Divider(
          color: Color(0xffddddddd),
        ),
      ],
    );
  }
}