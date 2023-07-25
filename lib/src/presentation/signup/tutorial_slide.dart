import 'package:dart_flutter/res/size_config.dart';
import 'package:dart_flutter/src/presentation/signup/land_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class TutorialSlide extends StatefulWidget {
  final VoidCallback onTutorialFinished;

  const TutorialSlide({required this.onTutorialFinished, Key? key}) : super(key: key);

  @override
  State<TutorialSlide> createState() => _TutorialSlideState();
}

class _TutorialSlideState extends State<TutorialSlide> with TickerProviderStateMixin {
  final _pageController = PageController();
  bool isLastPage = false;

  bool _isUp = true; // 첫 번째 화면 애니메이션
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  late AnimationController _letterAnimationController;
  late Animation<double> _letterAnimation;

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

  List<String> questions = ["인스타에서 제일 관심가는 사람은?", "6번째 뉴진스 멤버"];

  @override
  void initState() {
    super.initState();
    // 첫 번째 화면 애니메이션
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation = Tween<Offset>(
      begin: Offset(0,0.15),
      end: Offset(0,0),
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

    _fadeInOutAnimation.addStatusListener((status) { // 애니메이션 리스너 설정
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
    _fadeInOutAnimation2.addStatusListener((status) { // 애니메이션 리스너 설정
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
    _fadeInOutAnimation3.addStatusListener((status) { // 애니메이션 리스너 설정
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
    _fadeInOutAnimation4.addStatusListener((status) { // 애니메이션 리스너 설정
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
    _fadeInOutAnimation5.addStatusListener((status) { // 애니메이션 리스너 설정
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(bottom: SizeConfig.screenWidth * 0.2),
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => isLastPage = index == 2);
          },
          children: [
            Container(
              color: Colors.white,
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: SizeConfig.screenHeight * 0.1,),
                    RichText(
                        text: TextSpan(
                          style: TextStyle(fontSize: SizeConfig.defaultSize * 2.2, fontWeight: FontWeight.w600),
                          children: <TextSpan>[
                            TextSpan(text: "Frolic에서는 ", style: TextStyle(color: Colors.black)),
                            TextSpan(text: "긍정적인 질문", style: TextStyle(color: Color(0xff7C83FD), fontWeight: FontWeight.w800)),
                            TextSpan(text: "에 대해", style: TextStyle(color: Colors.black)),
                          ]
                        )
                    ),
                    SizedBox(height: SizeConfig.defaultSize * 0.3),
                    RichText(
                        text: TextSpan(
                            style: TextStyle(fontSize: SizeConfig.defaultSize * 2.2, fontWeight: FontWeight.w600),
                            children: <TextSpan>[
                              TextSpan(text: "내 친구들을 ", style: TextStyle(color: Colors.black)),
                              TextSpan(text: "투표", style: TextStyle(color: Color(0xff7C83FD))),
                              TextSpan(text: "할 수 있어요!", style: TextStyle(color: Colors.black)),
                            ]
                        )
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.08),

                    SlideTransition(
                      position: _animation,
                      child: Image.asset(
                        'assets/images/contacts.png',
                        width: SizeConfig.defaultSize * 20,
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.06,),
                    Text("${questions[0]}", style: TextStyle(fontSize: SizeConfig.defaultSize * 2, fontWeight: FontWeight.w600),),
                    SizedBox(height: SizeConfig.defaultSize * 2.5,),

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
                          SizedBox(height: SizeConfig.defaultSize,),
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
            Container(
              color: Colors.white,
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: SizeConfig.screenHeight * 0.1,),
                    RichText(
                        text: TextSpan(
                            style: TextStyle(fontSize: SizeConfig.defaultSize * 2.2, fontWeight: FontWeight.w600),
                            children: <TextSpan>[
                              TextSpan(text: "내가 투표받으면 ", style: TextStyle(color: Colors.black)),
                              TextSpan(text: "알림", style: TextStyle(color: Color(0xff7C83FD), fontWeight: FontWeight.w800)),
                              TextSpan(text: "이 와요!", style: TextStyle(color: Colors.black)),
                            ]
                        )
                    ),
                    SizedBox(height: SizeConfig.defaultSize * 0.3),
                    Text("친구들도 내가 보낸 투표를 봐요!", style: TextStyle(fontSize: SizeConfig.defaultSize * 2.2, fontWeight: FontWeight.w600),),
                    SizedBox(height: SizeConfig.screenHeight * 0.1),

                    FadeTransition(
                      opacity: _fadeInOutAnimation,
                      child: VoteFriend(admissionYear: "23", gender: "여", question: "6번째 뉴진스 멤버", datetime: "10초 전",),
                    ), SizedBox(height: SizeConfig.defaultSize * 1.6),
                    FadeTransition(
                      opacity: _fadeInOutAnimation2,
                      child: VoteFriend(admissionYear: "21", gender: "남", question: "모임에 꼭 있어야 하는", datetime: "1분 전",),
                    ), SizedBox(height: SizeConfig.defaultSize * 1.6),
                    FadeTransition(
                      opacity: _fadeInOutAnimation3,
                      child: VoteFriend(admissionYear: "22", gender: "여", question: "OO와의 2023 ... 여름이었다", datetime: "5분 전",),
                    ), SizedBox(height: SizeConfig.defaultSize * 1.6),
                    FadeTransition(
                      opacity: _fadeInOutAnimation4,
                      child: VoteFriend(admissionYear: "20", gender: "남", question: "디올 엠베서더 할 것 같은 사람", datetime: "10분 전",),
                    ), SizedBox(height: SizeConfig.defaultSize * 1.6),
                    FadeTransition(
                      opacity: _fadeInOutAnimation5,
                      child: VoteFriend(admissionYear: "23", gender: "남", question: "OOO 갓생 폼 미쳤다", datetime: "30분 전",),
                    ), SizedBox(height: SizeConfig.defaultSize * 1.6),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: SizeConfig.screenHeight * 0.1,),
                    Text("누가 나에게 관심을 갖고 있는지", style: TextStyle(fontSize: SizeConfig.defaultSize * 2.2, fontWeight: FontWeight.w600),),
                    SizedBox(height: SizeConfig.defaultSize * 0.3),
                    Text("궁금하지 않으신가요?", style: TextStyle(fontSize: SizeConfig.defaultSize * 2.2, fontWeight: FontWeight.w600),),
                    SizedBox(height: SizeConfig.screenHeight * 0.1),
                    Container(
                      child: AnimatedBuilder(
                        animation: _letterAnimationController,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _letterAnimation.value,
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
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
                    Text("나를 향한 투표들이 기다리고 있어요!", style: TextStyle(fontSize: SizeConfig.defaultSize * 2, fontWeight: FontWeight.w600),),
                    SizedBox(height: SizeConfig.defaultSize * 1),
                    Text("친구들과 즐기러 가볼까요?", style: TextStyle(fontSize: SizeConfig.defaultSize * 2, fontWeight: FontWeight.w600),),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? TextButton(
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.setBool('showHome', true);

              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LandingPage())
              );
            },
            child: Text("Frolic 즐기러가기", style: TextStyle(fontSize: SizeConfig.defaultSize * 2.2, fontWeight: FontWeight.w600),),
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0)
              ),
              primary: Colors.white,
              backgroundColor: Color(0xff7C83FD),
              minimumSize: Size.fromHeight(SizeConfig.screenHeight * 0.09)
            ),
            )
          : Container(
              padding: EdgeInsets.only(left: SizeConfig.defaultSize, right: SizeConfig.defaultSize),
              height: SizeConfig.screenHeight * 0.09,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        _pageController.jumpToPage(2);
                      },
                      child: Text("스킵",
                          style: TextStyle(
                              fontSize: SizeConfig.defaultSize * 1.8,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff7C83FD)))),
                  Center(
                      child: SmoothPageIndicator(
                          controller: _pageController,
                          count: 3,
                          effect: WormEffect(
                              activeDotColor: Color(0xff7C83FD),
                              dotColor: Colors.grey.shade200,
                              dotHeight: SizeConfig.defaultSize,
                              dotWidth: SizeConfig.defaultSize,
                              spacing: SizeConfig.defaultSize * 1.5),
                          onDotClicked: (index) => _pageController.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn))),
                  TextButton(
                      onPressed: () {
                        _pageController.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut);
                      },
                      child: Text("다음",
                          style: TextStyle(
                              fontSize: SizeConfig.defaultSize * 1.8,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff7C83FD)))),
                ],
              ),
            ),
    );
  }
}

class VoteFriend extends StatelessWidget {
  late String admissionYear;
  late String gender;
  late String question;
  late String datetime;

  VoteFriend({
    super.key,
    required this.admissionYear,
    required this.gender,
    required this.question,
    required this.datetime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth * 0.9,
      padding: EdgeInsets.all(SizeConfig.defaultSize * 1),
      decoration: BoxDecoration(
        border: Border.all(
          width: SizeConfig.defaultSize * 0.06,
          color: Color(0xff7C83FD),
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.person_pin_rounded, size: SizeConfig.defaultSize * 4.5, color: Color(0xff7C83FD),),
              SizedBox(width: SizeConfig.defaultSize * 0.7),
              Container(
                width: SizeConfig.screenWidth * 0.63,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                          style: TextStyle(fontSize: SizeConfig.defaultSize * 1.5),
                          children: <TextSpan>[
                            TextSpan(text:'${admissionYear}',
                                style: TextStyle(color: Color(0xff7C83FD), fontWeight: FontWeight.w600)),
                            TextSpan(text:'학번 ',
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400)),
                            TextSpan(text:'${gender}학생',
                                style: TextStyle(color: Color(0xff7C83FD), fontWeight: FontWeight.w600)),
                            TextSpan(text:'이 보냈어요!',
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400)),
                          ]
                      ),
                    ),
                    // Text("${admissionYear.substring(2,4)}학번 ${getGender(gender)}학생이 Dart를 보냈어요!", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.5, fontWeight: FontWeight.w500,)),
                    SizedBox(height: SizeConfig.defaultSize * 0.5,),
                    Text("$question",
                        style: TextStyle(
                          fontSize: SizeConfig.defaultSize * 1.3
                              * ((question.length <= 25 ? 1 : 1 - ((question.length - 25) * 0.01))),
                          // ((question.length <= 25 ? 1 : 1 - ((question.length - 15) * 0.035))), // 원래 식
                          fontWeight: FontWeight.w400,
                          overflow: TextOverflow.ellipsis,
                        )),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text("$datetime", style: TextStyle(fontSize: SizeConfig.defaultSize * 1)),
              SizedBox(width: SizeConfig.defaultSize * 0.5,)
            ],
          ),
        ],
      ),
    );
  }
}

class FriendView extends StatelessWidget {
  final String name;
  final String enterYear;
  final String department;

  const FriendView({
    super.key,
    required this.name,
    required this.enterYear,
    required this.department
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth * 0.4,
      height: SizeConfig.defaultSize * 7.7,
      color: Colors.white,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          surfaceTintColor: Colors.white,
          primary: Colors.white,
          onPrimary: Color(0xff7C83FD),
          backgroundColor: Colors.white,   // background color
          foregroundColor: Color(0xff7C83FD), // text color
          shadowColor: Colors.grey.shade200,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // 모서리 둥글기 설정
          ),
          padding: EdgeInsets.only(left: SizeConfig.defaultSize * 0.6, right: SizeConfig.defaultSize * 0.6)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(name,
              style: TextStyle(
                fontSize: SizeConfig.defaultSize * 2,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: SizeConfig.defaultSize * 1,),
            Text(
              "${enterYear}학번 ${department}",
              style: TextStyle(
                  fontSize: SizeConfig.defaultSize * 1.4,
                  fontWeight: FontWeight.w500,
                  color: Colors.black
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      )
    );
  }
}