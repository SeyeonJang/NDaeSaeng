import 'package:dart_flutter/res/config/size_config.dart';
import 'package:dart_flutter/src/common/util/analytics_util.dart';
import 'package:dart_flutter/src/common/util/toast_util.dart';
import 'package:dart_flutter/src/presentation/chat/chat_pages.dart';
import 'package:dart_flutter/src/presentation/chat/viewmodel/chat_cubit.dart';
import 'package:dart_flutter/src/presentation/component/webview_fullscreen.dart';
import 'package:dart_flutter/src/presentation/meet/meet_intro_pages.dart';
import 'package:dart_flutter/src/presentation/meet/meet_pages.dart';
import 'package:dart_flutter/src/presentation/meet/viewmodel/meet_cubit.dart';
import 'package:dart_flutter/src/presentation/mypage/mypages.dart';
import 'package:dart_flutter/src/presentation/mypage/viewmodel/mypages_cubit.dart';
import 'package:dart_flutter/src/presentation/page_view_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DartPageView extends StatefulWidget {
  final int initialPage;

  const DartPageView({Key? key, this.initialPage = 0}) : super(key: key);

  @override
  State<DartPageView> createState() => _DartPageViewState();
}

class _DartPageViewState extends State<DartPageView> {
  int _page = 0;
  late final PageController _pageController = PageController(initialPage: widget.initialPage);
  DateTime? currentBackPressTime;

  @override
  void initState() {
    super.initState();
    // 앱 실행시 전면 팝업
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      if (!canShowPopup()) return;
      show(
          "친구초대이벤트",
          'assets/images/popup_starbucks.jpg',
          "https://docs.google.com/forms/d/e/1FAIpQLScG4YIlJ8aO3XH6HXrP3hSOxV-IEDAxDJRMfrCPqcl0Zkg63A/viewform"
      );
    });
  }

  bool canShowPopup() {
    return BlocProvider.of<PageViewCubit>(context).getState();
  }

  void neverShowPopup() {
    BlocProvider.of<PageViewCubit>(context).neverAgain();
  }

  void show(String title, String imagePath, String url) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext dialogContext) => AlertDialog(
        surfaceTintColor: Colors.white,
        title: Center(
            child: Text(
              title,
              style: TextStyle(fontSize: SizeConfig.defaultSize * 1.7, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            )),
        content: SizedBox(
          width: SizeConfig.screenWidth * 0.8,
          height: SizeConfig.screenHeight * 0.42,
          child: SingleChildScrollView(
            child: GestureDetector(
              onTap: () {
                AnalyticsUtil.logEvent("전면팝업_이미지_터치");
                Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewFullScreen(url: url, title: title)));
              },
              child: ListBody(
                children: <Widget>[
                  Image.asset(imagePath),
                ],
              ),
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              AnalyticsUtil.logEvent("전면팝업_다시열지않기_터치");
              neverShowPopup();
              Navigator.of(context).pop();
            },
            child: Text(
              '다시 열지 않기',
              style: TextStyle(
                  fontSize: SizeConfig.defaultSize * 1.2, fontWeight: FontWeight.w600, color: Colors.grey),
            ),
          ),
          TextButton(
            onPressed: () {
              AnalyticsUtil.logEvent("전면팝업_닫기_터치");
              Navigator.of(context).pop();
            },
            child: Text(
              '닫기',
              style: TextStyle(
                  fontSize: SizeConfig.defaultSize * 1.2, fontWeight: FontWeight.w600, color: const Color(0xffFE6059)),
            ),
          ),
        ],
      ),
    );
  }

  void _onTapNavigation(int page) {
    setState(() {
      _page = page;
      _pageController.jumpToPage(page); // 페이지 전환
      if (page == 0) {
        AnalyticsUtil.logEvent('하단 탭 터치_홈');
      } else if (page == 1) {
        AnalyticsUtil.logEvent('하단 탭 터치_과팅');
      } else if (page == 2) {
        AnalyticsUtil.logEvent('하단 탭 터치_채팅');
      } else if (page == 3) {
        AnalyticsUtil.logEvent('하단 탭 터치_내정보');
      }
      // else if (page == 4) {
      //   AnalyticsUtil.logEvent('하단 탭 터치_내정보');
      // }
    });
  }

  Future<bool> _onWillPop() {
    DateTime now = DateTime.now();

    switch (_page) {
      case 0:
        if (currentBackPressTime == null || now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
          currentBackPressTime = now;
          const msg = "'뒤로가기'를 한 번 더 누르면 종료됩니다.";
          ToastUtil.showToast(msg);
          return Future.value(false);
        }
        return Future.value(true);
      case 1 || 2 || 3:
        _onTapNavigation(0);
        return Future.value(false);
      default:
        return Future.value(false);
    }
  }

  final _tabs = [
    // BlocProvider<VoteCubit>(
    //   create: (context) => VoteCubit()..initVotes(),
    //   child: const VotePages(),
    // ),
    // BlocProvider<VoteListCubit>(
    //   create: (context) => VoteListCubit()..initVotes(),
    //   child: const VoteListPages(),
    // ),
    BlocProvider<MeetCubit>(
      create: (context) => MeetCubit()..initMeetIntro(),
      // child: const MeetIntro(),
      child: const MeetIntroPages(),
    ),
    BlocProvider<MeetCubit>(
      create: (context) => MeetCubit()..initMeet(),
      child: const MeetPages(),
    ),
    BlocProvider<ChatCubit>(
        create: (context) => ChatCubit(),
        child: const ChatPages()
    ),
    BlocProvider<MyPagesCubit>(
      create: (BuildContext context) => MyPagesCubit()..initPages(),
      child: const MyPages(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Padding(
        padding: EdgeInsets.only(top: _page != 1 ? SizeConfig.defaultSize * 6.5 : 0),
        // padding: EdgeInsets.only(top: SizeConfig.defaultSize * 6.5),
        child: WillPopScope(
          onWillPop: _onWillPop,
          child: _tabs[_page]
        ),
      ),
      // body: WillPopScope(
      //   onWillPop: _onWillPop,
      //   child: _tabs[_page],
      // ),

      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        currentIndex: _page,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedFontSize: SizeConfig.defaultSize * 1.15,
        selectedItemColor: Color(0xffFE6059).withOpacity(0.8),
        // selectedItemColor: _page == 3 ? Color(0xff7C83FD) : Color(0xffFE6059),
        unselectedFontSize: SizeConfig.defaultSize * 1.1,
        unselectedItemColor: Colors.grey.shade400,
        items: [
          // BottomNavigationBarItem(
          //   icon: Column(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children: [
          //       Icon(Icons.play_arrow_rounded, size: SizeConfig.defaultSize * 3.7),
          //     ],
          //   ),
          //   label: "투표",
          // ),
          // BottomNavigationBarItem(
          //   icon: Column(
          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
          //     children: [
          //       Icon(Icons.notifications_rounded, size: SizeConfig.defaultSize * 2.8),
          //       SizedBox(height: SizeConfig.defaultSize * 0.4)
          //     ],
          //   ),
          //   label: "받은 투표",
          // ),
          BottomNavigationBarItem(
            icon: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.home_filled, size: SizeConfig.defaultSize * 2.6),
                SizedBox(height: SizeConfig.defaultSize * 0.4),
              ],
            ),
            label: "홈",
          ),
          BottomNavigationBarItem(
            icon: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.favorite_rounded, size: SizeConfig.defaultSize * 2.6),
                SizedBox(height: SizeConfig.defaultSize * 0.4),
              ],
            ),
            label: "과팅",
          ),
          BottomNavigationBarItem(
            icon: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.chat_bubble_rounded, size: SizeConfig.defaultSize * 2.4),
                SizedBox(height: SizeConfig.defaultSize * 0.5),
              ],
            ),
            label: "채팅",
          ),
          BottomNavigationBarItem(
            icon: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.person_rounded, size: SizeConfig.defaultSize * 3.2),
                SizedBox(height: SizeConfig.defaultSize * 0.15),
              ],
            ),
            label: "내정보",
          ),
        ],
      ),
    );
  }
}

// class _DartPageViewState extends State<DartPageView> {
//   int _page = 0;
//   late final PageController _pageController = PageController(initialPage: widget.initialPage);
//   DateTime? currentBackPressTime;
//
//   @override
//   void initState() {
//     super.initState();
//     _page = widget.initialPage;
//   }
//
//   void _onPageChanged(int page) {
//     setState(() {
//       _page = page;
//     });
//   }
//
//   void _onTapNavigation(int page) {
//     _pageController.animateToPage(page, duration: const Duration(milliseconds: 300), curve: Curves.ease);
//   }
//
//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }
//
//   Future<bool> _onWillPop(){
//     DateTime now = DateTime.now();
//
//     switch (_page) {
//       case 0:  // Vote
//         if(currentBackPressTime == null || now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
//           currentBackPressTime = now;
//           const msg = "'뒤로가기'를 한 번 더 누르면 종료됩니다.";
//           ToastUtil.showToast(msg);
//           return Future.value(false);
//         }
//         return Future.value(true);
//       case 1 || 2 || 3:  // VoteList, MyPage
//         _onTapNavigation(0);
//         return Future.value(false);
//       default:
//         return Future.value(false);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: WillPopScope(
//         onWillPop: _onWillPop,
//         child: SafeArea(
//             child: Column(
//               children: [
//                 Padding(
//                   padding: EdgeInsets.only(left: SizeConfig.defaultSize * 1, right: SizeConfig.defaultSize * 1),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       _TapBarButton(name: "투표 ", targetPage: 0, nowPage: _page, onTapNavigation: _onTapNavigation),
//                       _TapBarButton(name: "받은 투표", targetPage: 1, nowPage: _page, onTapNavigation: _onTapNavigation),
//                       _TapBarButton(name: " 과팅", targetPage: 2, nowPage: _page, onTapNavigation: _onTapNavigation),
//                       _TapBarButton(name: "내정보", targetPage: 3, nowPage: _page, onTapNavigation: _onTapNavigation),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: PageView(
//                     onPageChanged: _onPageChanged,
//                     controller: _pageController,
//                     children: [
//                       BlocProvider<VoteCubit>(
//                           create: (context) => VoteCubit()..initVotes(),
//                           child: const VotePages(),
//                       ),
//                       BlocProvider(
//                         create: (context) => VoteListCubit()..initVotes(),
//                         child: const VoteListPages(),
//                       ),
//                       BlocProvider<MeetCubit>(
//                           create: (context) => MeetCubit()..initState(),
//                           // child: const MeetStandby(),
//                           child: const MeetPage2(),
//                       ),
//                       BlocProvider<MyPagesCubit>(
//                         create: (BuildContext context) => MyPagesCubit()..initPages(),
//                         child: const MyPages(),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//         ),
//       ),
//     );
//   }
// }
//
// class _TapBarButton extends StatelessWidget {
//   final String name;
//   final int targetPage;
//   final int nowPage;
//   final onTapNavigation;
//   const _TapBarButton({Key? key, required this.targetPage, this.onTapNavigation, required this.name, required this.nowPage}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//         onTap: () {
//           AnalyticsUtil.logEvent("상단탭_선택", properties: {"탭 이름": name});
//           onTapNavigation(targetPage);
//         },
//         child: Container(
//           color: Colors.white,
//           width: SizeConfig.screenWidth * 0.22,
//           height: SizeConfig.defaultSize * 7,
//           alignment: Alignment.center,
//           child: Padding(
//             padding: const EdgeInsets.all(0),
//             child:
//             Text(name, style:
//             TextStyle(fontSize:
//             (targetPage == nowPage)
//                 ? SizeConfig.defaultSize * 1.65
//                 : SizeConfig.defaultSize * 1.6,
//                 fontWeight:
//                 (targetPage == nowPage)
//                     ? FontWeight.w600
//                     : FontWeight.w500,
//                 color:
//                 (targetPage == nowPage)
//                     ? (targetPage == 2 ? Color(0xffFF5C58) : Color(0xff7C83FD))
//                     : Colors.grey)),
//           ),
//         )
//     );
//   }
// }