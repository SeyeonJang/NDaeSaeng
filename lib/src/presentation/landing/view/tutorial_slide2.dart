import 'package:dart_flutter/res/config/size_config.dart';
import 'package:dart_flutter/src/common/util/analytics_util.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class TutorialSlide2 extends StatefulWidget {
  final VoidCallback onTutorialFinished;

  const TutorialSlide2({required this.onTutorialFinished, Key? key}) : super(key: key);

  @override
  State<TutorialSlide2> createState() => _TutorialSlideState();
}

class _TutorialSlideState extends State<TutorialSlide2> with TickerProviderStateMixin {
  final _pageController = PageController();
  bool isLastPage = false;

  bool _isUp = true; // 첫 번째 화면 애니메이션
  late AnimationController _animationController;
  late Animation<Offset> _animation;
  // 질문 애니메이션
  int currentIndex = 0;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  List<String> questions = ["인스타에서 제일 관심가는 사람은?", "데뷔해 ! 너무 예뻐", "Y2K 무드가 잘 어울리는", "쇼핑 같이 가고 싶은 사람", "주식으로 10억 벌 것 같은 사람"];

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

    _pageController.addListener(() {
      int currentPage = _pageController.page!.round();
      if (currentPage == 0) {
        AnalyticsUtil.logEvent("온보딩_첫번째_접속");
      } else if (currentPage == 1) {
        AnalyticsUtil.logEvent("온보딩_두번째_접속");
      } else if (currentPage == 2) {
        AnalyticsUtil.logEvent("온보딩_세번째_접속");
      } else if (currentPage == 3) {
        AnalyticsUtil.logEvent("온보딩_네번째_접속");
      }
    });

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => isLastPage = index == 3);
          },
          children: [
            Container(
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.defaultSize * 6,),

                  GestureDetector(onTap: () {AnalyticsUtil.logEvent("온보딩_첫번째_예시프로필1터치");}, child: MeetView(questionName: ['첫 인상이 좋았던', '귀여워서 밥 사주고 싶은 사람', '누구보다 공감을 잘 해주는'], count: ['30+','20+','5+'],)),
                  SizedBox(height: SizeConfig.defaultSize),
                  GestureDetector(onTap: () {AnalyticsUtil.logEvent("온보딩_첫번째_예시프로필2터치");}, child: MeetView2(questionName: ['운동하는 모습이 멋있는 갓생러', '우리 학과 수석으로 들어왔을 것 같은 사람', '너 T야? 큐티?'], count: ['20+','5+','5+'],)),

                  SizedBox(height: SizeConfig.defaultSize * 5,),
                  Text("엔대생에서 인증된 대학생들과 과팅해요!", style: TextStyle(fontSize: SizeConfig.defaultSize * 2, fontWeight: FontWeight.w600),),
                  SizedBox(height: SizeConfig.defaultSize * 2,),
                  Text("엔대생에서는 학생증 인증을 통해 인증된", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.5, fontWeight: FontWeight.w500),),
                  SizedBox(height: SizeConfig.defaultSize * 0.3),
                  Text("다양한 학교, 학과의 대학생들과 연결돼요!", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.5, fontWeight: FontWeight.w500),),
                ],
              )
            ),
            Container(
              color: Colors.white,
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: SizeConfig.defaultSize * 6,),
                    SlideTransition(
                      position: _animation,
                      child: Image.asset(
                        'assets/images/contacts.png',
                        width: SizeConfig.defaultSize * 25,
                      ),
                    ),
                    SizedBox(height: SizeConfig.defaultSize * 5,),
                    GestureDetector(
                      onTap: () {
                        AnalyticsUtil.logEvent("온보딩_두번째_예시질문터치");
                      },
                      child: AnimatedBuilder(
                        animation: _fadeAnimation,
                        builder: (context, child) {
                          return Opacity(
                            opacity: _fadeAnimation.value,
                            child: Text(
                              questions[currentIndex],
                              style: TextStyle(fontSize: SizeConfig.defaultSize * 2.5, fontWeight: FontWeight.w500),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: SizeConfig.defaultSize * 9,),
                    Text("내 친구들과 이미지게임을 즐겨요!", style: TextStyle(fontSize: SizeConfig.defaultSize * 2, fontWeight: FontWeight.w600),),
                    SizedBox(height: SizeConfig.defaultSize * 2,),
                    RichText(
                        text: TextSpan(
                            style: TextStyle(fontSize: SizeConfig.defaultSize * 1.5, fontWeight: FontWeight.w500),
                            children: <TextSpan>[
                              TextSpan(text: "엔대생에서는 ", style: TextStyle(color: Colors.black)),
                              TextSpan(text: "긍정적인 질문", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
                              TextSpan(text: "에 대해", style: TextStyle(color: Colors.black)),
                            ]
                        )
                    ),
                    SizedBox(height: SizeConfig.defaultSize * 0.3),
                    RichText(
                        text: TextSpan(
                            style: TextStyle(fontSize: SizeConfig.defaultSize * 1.5, fontWeight: FontWeight.w500),
                            children: <TextSpan>[
                              TextSpan(text: "내 친구들을 ", style: TextStyle(color: Colors.black)),
                              TextSpan(text: "투표", style: TextStyle(color: Color(0xff7C83FD))),
                              TextSpan(text: "할 수 있어요!", style: TextStyle(color: Colors.black)),
                            ]
                        )
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
                    SizedBox(height: SizeConfig.defaultSize * 6,),
                    FadeTransition(
                      opacity: _fadeInOutAnimation,
                      child: VoteFriend(admissionYear: "23", gender: "여", question: "6번째 뉴진스 멤버", datetime: "10초 전", index: 0),
                    ), SizedBox(height: SizeConfig.defaultSize * 1.6),
                    FadeTransition(
                      opacity: _fadeInOutAnimation2,
                      child: VoteFriend(admissionYear: "21", gender: "남", question: "모임에 꼭 있어야 하는", datetime: "1분 전", index: 1),
                    ), SizedBox(height: SizeConfig.defaultSize * 1.6),
                    FadeTransition(
                      opacity: _fadeInOutAnimation3,
                      child: VoteFriend(admissionYear: "22", gender: "여", question: "OO와의 2023 ... 여름이었다", datetime: "5분 전", index: 2),
                    ), SizedBox(height: SizeConfig.defaultSize * 1.6),
                    FadeTransition(
                      opacity: _fadeInOutAnimation4,
                      child: VoteFriend(admissionYear: "20", gender: "남", question: "디올 엠베서더 할 것 같은 사람", datetime: "10분 전", index: 3,),
                    ), SizedBox(height: SizeConfig.defaultSize * 1.6),
                    FadeTransition(
                      opacity: _fadeInOutAnimation5,
                      child: VoteFriend(admissionYear: "23", gender: "남", question: "OOO 갓생 폼 미쳤다", datetime: "30분 전", index: 4,),
                    ), SizedBox(height: SizeConfig.defaultSize * 1.6),

                    SizedBox(height: SizeConfig.defaultSize * 1),
                    Text("쌓이는 알림, 더해가는 즐거움!", style: TextStyle(fontSize: SizeConfig.defaultSize * 2, fontWeight: FontWeight.w600),),
                    SizedBox(height: SizeConfig.defaultSize * 2),
                    RichText(
                        text: TextSpan(
                            style: TextStyle(fontSize: SizeConfig.defaultSize * 1.5, fontWeight: FontWeight.w500),
                            children: <TextSpan>[
                              TextSpan(text: "내가 투표받으면 ", style: TextStyle(color: Colors.black)),
                              TextSpan(text: "알림", style: TextStyle(color: Color(0xff7C83FD), fontWeight: FontWeight.w500)),
                              TextSpan(text: "이 와요!", style: TextStyle(color: Colors.black)),
                            ]
                        )
                    ),
                    SizedBox(height: SizeConfig.defaultSize * 0.3),
                    Text("친구들도 내가 보낸 투표를 봐요!", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.5, fontWeight: FontWeight.w500),),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: SizeConfig.defaultSize * 12,),
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
                                GestureDetector(
                                  onTap: () {
                                    AnalyticsUtil.logEvent("온보딩_네번째_아이콘터치");
                                  },
                                  child: Image.asset(
                                    'assets/images/letter.png',
                                    // color: Colors.indigo,
                                    width: SizeConfig.defaultSize * 33,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: SizeConfig.defaultSize * 3,),
                    Text("누가 나에게 관심을 갖고 있는지 궁금하다면?", style: TextStyle(fontSize: SizeConfig.defaultSize * 2, fontWeight: FontWeight.w600),),
                    SizedBox(height: SizeConfig.defaultSize * 2,),
                    Text("나를 향한 투표들이 기다리고 있어요!", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.5, fontWeight: FontWeight.w500),),
                    SizedBox(height: SizeConfig.defaultSize * 0.3),
                    Text("친구들과 즐기러 가볼까요?", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.5, fontWeight: FontWeight.w500),),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.only(left: SizeConfig.defaultSize * 2, right: SizeConfig.defaultSize * 2, bottom: SizeConfig.defaultSize * 2.5),
        height: SizeConfig.screenHeight * 0.03,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: SmoothPageIndicator(
                    controller: _pageController,
                    count: 4,
                    effect: WormEffect(
                        activeDotColor: Color(0xff7C83FD),
                        dotColor: Colors.grey.shade200,
                        dotHeight: SizeConfig.defaultSize,
                        dotWidth: SizeConfig.defaultSize,
                        spacing: SizeConfig.defaultSize * 1.5),
                    onDotClicked: (index) => _pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeIn))),
          ],
        ),
      ),
    );
  }
}

class MeetView extends StatelessWidget {
  List<String> questionName;
  List<String> count;

  MeetView({
    super.key,
    required this.questionName,
    required this.count
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 3),
      child: Container( // 카드뷰 시작 *****************
        width: SizeConfig.screenWidth,
        height: SizeConfig.defaultSize * 18,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: Color(0xffFF5C58).withOpacity(0.5),
                width: 1.5
            )
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: SizeConfig.defaultSize * 1, horizontal: SizeConfig.defaultSize * 1.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row( // 위층 (받은 투표 윗 부분 Row)
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          AnalyticsUtil.logEvent("과팅_팀만들기_카드_프사_터치");
                        },
                        child: ClipOval(
                          child: Image.asset('assets/images/profile1.jpeg', width: SizeConfig.defaultSize * 5.2, fit: BoxFit.cover,),
                      )),
                      SizedBox(width: SizeConfig.defaultSize * 0.8),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: SizeConfig.defaultSize * 3,
                            child: Row( // 위층 (이름 ~ 년생)
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: SizeConfig.defaultSize * 3.3,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(width: SizeConfig.defaultSize * 0.5,),
                                      Text(
                                        '포챠코',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: SizeConfig.defaultSize * 1.6,
                                          color: Colors.black,
                                        ),),
                                      Text(
                                        "∙ 03년생",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: SizeConfig.defaultSize * 1.6,
                                          color: Colors.black,
                                        ),),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row( // 2층
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: SizeConfig.defaultSize * 0.5,),
                              Container(
                                child: Text(
                                  "연세대학교 교육학과",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: SizeConfig.defaultSize * 1.6,
                                    color: Colors.black,
                                    overflow: TextOverflow.ellipsis,

                                  ),
                                ),
                              ),
                              SizedBox(width: SizeConfig.defaultSize * 0.3),
                              Image.asset("assets/images/check.png", width: SizeConfig.defaultSize * 1.3),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                height: SizeConfig.defaultSize * 9.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (int i = 0; i < 3; i++)
                      Container(
                          width: SizeConfig.screenWidth,
                          height: SizeConfig.defaultSize * 3,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color(0xffFF5C58)
                          ),
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(questionName[i], style: TextStyle(
                                    color: Colors.white,
                                    fontSize: SizeConfig.defaultSize * 1.3
                                ),),
                                Text(count[i],  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: SizeConfig.defaultSize * 1.3
                                ),)
                              ],
                            ),
                          )
                      ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MeetView2 extends StatelessWidget {
  List<String> questionName;
  List<String> count;

  MeetView2({
    super.key,
    required this.questionName,
    required this.count
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 3),
      child: Container( // 카드뷰 시작 *****************
        width: SizeConfig.screenWidth,
        height: SizeConfig.defaultSize * 18,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: Color(0xffFF5C58).withOpacity(0.5),
                width: 1.5
            )
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: SizeConfig.defaultSize * 1, horizontal: SizeConfig.defaultSize * 1.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row( // 위층 (받은 투표 윗 부분 Row)
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () {
                            AnalyticsUtil.logEvent("과팅_팀만들기_카드_프사_터치");
                          },
                          child: ClipOval(
                            child: Image.asset('assets/images/hyeonsikchoi.jpeg', width: SizeConfig.defaultSize * 4.2, fit: BoxFit.cover,),
                          )),
                      SizedBox(width: SizeConfig.defaultSize * 0.8),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: SizeConfig.defaultSize * 3,
                            child: Row( // 위층 (이름 ~ 년생)
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: SizeConfig.defaultSize * 3.3,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(width: SizeConfig.defaultSize * 0.5,),
                                      Text(
                                        '도라에몽',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: SizeConfig.defaultSize * 1.6,
                                          color: Colors.black,
                                        ),),
                                      Text(
                                        "∙ 01년생",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: SizeConfig.defaultSize * 1.6,
                                          color: Colors.black,
                                        ),),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row( // 2층
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: SizeConfig.defaultSize * 0.5,),
                              Container(
                                child: Text(
                                  "서울대학교 경제학과",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: SizeConfig.defaultSize * 1.6,
                                    color: Colors.black,
                                    overflow: TextOverflow.ellipsis,

                                  ),
                                ),
                              ),
                              SizedBox(width: SizeConfig.defaultSize * 0.3),
                              Image.asset("assets/images/check.png", width: SizeConfig.defaultSize * 1.3),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                height: SizeConfig.defaultSize * 9.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (int i = 0; i < 3; i++)
                      Container(
                          width: SizeConfig.screenWidth,
                          height: SizeConfig.defaultSize * 3,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color(0xffFF5C58)
                          ),
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(questionName[i], style: TextStyle(
                                    color: Colors.white,
                                    fontSize: SizeConfig.defaultSize * 1.3
                                ),),
                                Text(count[i],  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: SizeConfig.defaultSize * 1.3
                                ),)
                              ],
                            ),
                          )
                      ),
                  ],
                ),
              )
            ],
          ),
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
  late int index;

  VoteFriend({
    super.key,
    required this.admissionYear,
    required this.gender,
    required this.question,
    required this.datetime,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AnalyticsUtil.logEvent("온보딩_세번째_목록터치", properties: {"목록 인덱스" : index});
      },
      child: Container(
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
                  width: SizeConfig.screenWidth * 0.55,
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