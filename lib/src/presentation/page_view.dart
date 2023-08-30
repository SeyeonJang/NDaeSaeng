import 'package:dart_flutter/res/config/size_config.dart';
import 'package:dart_flutter/src/common/util/analytics_util.dart';
import 'package:dart_flutter/src/common/util/toast_util.dart';
import 'package:dart_flutter/src/presentation/meet/meet_pages.dart';
import 'package:dart_flutter/src/presentation/meet/view/meet_standby.dart';
import 'package:dart_flutter/src/presentation/meet/viewmodel/meet_cubit.dart';
import 'package:dart_flutter/src/presentation/mypage/mypages.dart';
import 'package:dart_flutter/src/presentation/mypage/viewmodel/mypages_cubit.dart';
import 'package:dart_flutter/src/presentation/vote/vimemodel/vote_cubit.dart';
import 'package:dart_flutter/src/presentation/vote/vote_pages.dart';
import 'package:dart_flutter/src/presentation/vote_list/viewmodel/vote_list_cubit.dart';
import 'package:dart_flutter/src/presentation/vote_list/vote_list_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DartPageView extends StatefulWidget {
  final int initialPage;
  DartPageView({Key? key, this.initialPage = 0}) : super(key: key);

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
    _page = widget.initialPage;
  }

  void _onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void _onTapNavigation(int page) {
    _pageController.animateToPage(page, duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop(){
    DateTime now = DateTime.now();

    switch (_page) {
      case 0:  // Vote
        if(currentBackPressTime == null || now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
          currentBackPressTime = now;
          const msg = "'뒤로가기'를 한 번 더 누르면 종료됩니다.";
          ToastUtil.showToast(msg);
          return Future.value(false);
        }
        return Future.value(true);
      case 1 || 2 || 3:  // VoteList, MyPage
        _onTapNavigation(0);
        return Future.value(false);
      default:
        return Future.value(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: SizeConfig.defaultSize * 1, right: SizeConfig.defaultSize * 1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _TapBarButton(name: "투표 ", targetPage: 0, nowPage: _page, onTapNavigation: _onTapNavigation),
                      _TapBarButton(name: "받은 투표", targetPage: 1, nowPage: _page, onTapNavigation: _onTapNavigation),
                      _TapBarButton(name: " 과팅", targetPage: 2, nowPage: _page, onTapNavigation: _onTapNavigation),
                      _TapBarButton(name: "내정보", targetPage: 3, nowPage: _page, onTapNavigation: _onTapNavigation),
                    ],
                  ),
                ),
                Expanded(
                  child: PageView(
                    onPageChanged: _onPageChanged,
                    controller: _pageController,
                    children: [
                      BlocProvider<VoteCubit>(
                          create: (context) => VoteCubit()..initVotes(),
                          child: const VotePages(),
                      ),
                      BlocProvider(
                        create: (context) => VoteListCubit()..initVotes(),
                        child: const VoteListPages(),
                      ),
                      BlocProvider<MeetCubit>(
                          create: (context) => MeetCubit()..initState(),
                          // child: const MeetStandby(),
                          child: const MeetPage2(),
                      ),
                      BlocProvider<MyPagesCubit>(
                        create: (BuildContext context) => MyPagesCubit()..initPages(),
                        child: const MyPages(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
        ),
      ),
    );
  }
}

class _TapBarButton extends StatelessWidget {
  final String name;
  final int targetPage;
  final int nowPage;
  final onTapNavigation;
  const _TapBarButton({Key? key, required this.targetPage, this.onTapNavigation, required this.name, required this.nowPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          AnalyticsUtil.logEvent("상단탭_선택", properties: {"탭 이름": name});
          onTapNavigation(targetPage);
        },
        child: Container(
          color: Colors.white,
          width: SizeConfig.screenWidth * 0.22,
          height: SizeConfig.defaultSize * 7,
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(0),
            child:
            Text(name, style:
            TextStyle(fontSize:
            (targetPage == nowPage)
                ? SizeConfig.defaultSize * 1.65
                : SizeConfig.defaultSize * 1.6,
                fontWeight:
                (targetPage == nowPage)
                    ? FontWeight.w600
                    : FontWeight.w500,
                color:
                (targetPage == nowPage)
                    ? (targetPage == 2 ? Color(0xffFF5C58) : Color(0xff7C83FD))
                    : Colors.grey)),
          ),
        )
    );
  }
}
