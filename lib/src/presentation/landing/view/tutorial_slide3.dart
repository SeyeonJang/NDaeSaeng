import 'package:dart_flutter/res/config/size_config.dart';
import 'package:dart_flutter/src/common/util/analytics_util.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../static/visited_tutorial_slide.dart';

class TutorialSlide3 extends StatefulWidget {
  final VoidCallback onTutorialFinished;

  const TutorialSlide3({required this.onTutorialFinished, Key? key}) : super(key: key);

  @override
  State<TutorialSlide3> createState() => _TutorialSlideState();
}

class _TutorialSlideState extends State<TutorialSlide3> with TickerProviderStateMixin {
  final _pageController = PageController();
  bool isLastPage = false;

  @override
  void initState() {
    super.initState();

    _pageController.addListener(() {
      int currentPage = _pageController.page!.round();
      if (VisitedTutorialSlide.isNowIndex(currentPage)) return;  // 임시조치. 엠플리튜드 중복 로깅 발생에 대한 임시조치
      VisitedTutorialSlide.visit(currentPage);

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
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => isLastPage = index == 3);
        },
        children: [
          SingleChildScrollView(
            // physics: NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.08,),
                const MeetIntro1(),
                  SizedBox(height: SizeConfig.screenHeight * 0.1,),
                Text("엔대생에서 N명의 대학생들과 과팅해요!", style: TextStyle(fontSize: SizeConfig.defaultSize * 2, fontWeight: FontWeight.w600),),
                  SizedBox(height: SizeConfig.defaultSize * 2,),
                Text("엔대생에서는 학생증 인증을 통해 인증된", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.5, fontWeight: FontWeight.w500),),
                  SizedBox(height: SizeConfig.defaultSize * 0.3),
                Text("다양한 학교, 학과의 대학생들과 연결돼요!", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.5, fontWeight: FontWeight.w500),),
              ],
            ),
          ),
          SingleChildScrollView(
            // physics: NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.08,),
                const MeetIntro2(),
                  SizedBox(height: SizeConfig.screenHeight * 0.1,),
                Text("팀 정보는 최소한으로 초간단!", style: TextStyle(fontSize: SizeConfig.defaultSize * 2, fontWeight: FontWeight.w600),),
                  SizedBox(height: SizeConfig.defaultSize * 2,),
                Text("내 친구가 엔대생 앱에 가입하지 않았어도", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.5, fontWeight: FontWeight.w500),),
                  SizedBox(height: SizeConfig.defaultSize * 0.3),
                Text("내가 팀명, 지역, 팀원만 입력하면 끝!", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.5, fontWeight: FontWeight.w500),),
              ],
            ),
          ),
          SingleChildScrollView(
            // physics: NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.08,),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: SizeConfig.defaultSize * 11.5,),
                        SizedBox(
                            width: SizeConfig.screenWidth,
                            child: SizedBox(
                                child: Image.asset('assets/images/likesend.png'))),
                        SizedBox(height: SizeConfig.defaultSize * 5,),
                      ],
                    )
                ),

                  SizedBox(height: SizeConfig.screenHeight * 0.1,),
                Text("내 마음에 들면? 호감 보내기!", style: TextStyle(fontSize: SizeConfig.defaultSize * 2, fontWeight: FontWeight.w600),),
                  SizedBox(height: SizeConfig.defaultSize * 2,),
                Text("둘러보다가 내 마음에 들면 👀", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.5, fontWeight: FontWeight.w500),),
                  SizedBox(height: SizeConfig.defaultSize * 0.3),
                Text("바로 호감을 보내서 어필해요!", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.5, fontWeight: FontWeight.w500),),
              ],
            ),
          ),
          SingleChildScrollView(
            // physics: NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.08,),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: SizeConfig.defaultSize * 9,),
                        SizedBox(
                            width: SizeConfig.screenWidth,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: SizeConfig.defaultSize * 25,
                                      height: SizeConfig.defaultSize * 6,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(13), topRight: Radius.circular(13), bottomRight: Radius.circular(13)),
                                      ),
                                      child: const Text("안녕하세요! 저희는 OOOO학과\n학생들이에요! 대화해보고 싶어요! ☺️"),
                                    ),
                                  ],
                                ),
                                  SizedBox(height: SizeConfig.defaultSize * 3,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: SizeConfig.defaultSize * 27.2,
                                      height: SizeConfig.defaultSize * 3.2,
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                        color: Color(0xffFE6059),
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(13), topRight: Radius.circular(13), bottomLeft: Radius.circular(13)),
                                      ),
                                      child: const Text("안녕하세요! 저희도 대화해보고 싶어요! 😊", style: TextStyle(color: Colors.white),),
                                    ),
                                  ],
                                ),
                              ],
                            ),),
                        SizedBox(height: SizeConfig.defaultSize * 4,),
                      ],
                    )
                ),

                  SizedBox(height: SizeConfig.screenHeight * 0.1,),
                Text("이성 팀과 바로 채팅 시작!", style: TextStyle(fontSize: SizeConfig.defaultSize * 2, fontWeight: FontWeight.w600),),
                  SizedBox(height: SizeConfig.defaultSize * 2,),
                Text("내 호감을 상대가 수락하거나", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.5, fontWeight: FontWeight.w500),),
                  SizedBox(height: SizeConfig.defaultSize * 0.3),
                Text("상대가 나한테 호감을 보내오면 채팅해요!", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.5, fontWeight: FontWeight.w500),),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        padding: EdgeInsets.only(left: SizeConfig.defaultSize * 2, right: SizeConfig.defaultSize * 2, bottom: SizeConfig.defaultSize * 2.5),
        height: SizeConfig.screenHeight * 0.02,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: SmoothPageIndicator(
                    controller: _pageController,
                    count: 4,
                    effect: WormEffect(
                        activeDotColor: const Color(0xffFE6059),
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

class MeetIntro2 extends StatelessWidget {
  const MeetIntro2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
              SizedBox(height: SizeConfig.defaultSize * 4,),
            SizedBox(
              width: SizeConfig.screenWidth,
              child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffFE6059),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(SizeConfig.defaultSize),
                    child: Image.asset('assets/images/meet_intro.png'),
                  ))),
              SizedBox(height: SizeConfig.defaultSize * 3.7,),
          ],
        )
    );
  }
}

class MeetIntro1 extends StatelessWidget {
  const MeetIntro1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
            SizedBox(height: SizeConfig.defaultSize * 2,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: SizeConfig.defaultSize * 22,
                height: SizeConfig.defaultSize * 5,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xffFE6059),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Text("친구가 앱에 없어도 👀", style: TextStyle(
                  fontSize: SizeConfig.defaultSize * 2,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),),
              )
            ],
          ),
            SizedBox(height: SizeConfig.defaultSize * 3,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: SizeConfig.defaultSize * 21,
                height: SizeConfig.defaultSize * 5,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xffFE6059),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Text("친구 정보로 팀 만들고", style: TextStyle(
                  fontSize: SizeConfig.defaultSize * 2,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),),
              )
            ],
          ),
            SizedBox(height: SizeConfig.defaultSize * 3,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: SizeConfig.defaultSize * 21,
                height: SizeConfig.defaultSize * 5,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xffFE6059),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Text("바로 과팅 시작! 🥰❤️", style: TextStyle(
                  fontSize: SizeConfig.defaultSize * 2,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),),
              )
            ],
          ),
          SizedBox(height: SizeConfig.defaultSize * 2,),
        ],
      )
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
          backgroundColor: Colors.white,   // background color
          foregroundColor: const Color(0xff7C83FD), // text color
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
              "$enterYear학번 $department",
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