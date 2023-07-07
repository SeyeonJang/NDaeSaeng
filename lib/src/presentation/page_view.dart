import 'package:dart_flutter/res/size_config.dart';
import 'package:dart_flutter/src/presentation/meet/meet_page.dart';
import 'package:dart_flutter/src/presentation/mypage/mypages.dart';
import 'package:dart_flutter/src/presentation/mypage/viewmodel/mypages_cubit.dart';
import 'package:dart_flutter/src/presentation/vote/vimemodel/vote_cubit.dart';
import 'package:dart_flutter/src/presentation/vote/vote_pages.dart';
import 'package:dart_flutter/src/presentation/vote_list/viewmodel/vote_list_cubit.dart';
import 'package:dart_flutter/src/presentation/vote_list/vote_list_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DartPageView extends StatefulWidget {
  const DartPageView({Key? key}) : super(key: key);

  @override
  State<DartPageView> createState() => _DartPageViewState();
}

class _DartPageViewState extends State<DartPageView> {
  int _page = 0;
  late PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(SizeConfig.defaultSize * 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _TapBarButton(name: "Darts", targetPage: 0, nowPage: _page, onTapNavigation: _onTapNavigation),
                  _TapBarButton(name: "Dart", targetPage: 1, nowPage: _page, onTapNavigation: _onTapNavigation),
                  _TapBarButton(name: " MY ", targetPage: 2, nowPage: _page, onTapNavigation: _onTapNavigation),
                  _TapBarButton(name: "Meet", targetPage: 3, nowPage: _page, onTapNavigation: _onTapNavigation),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                onPageChanged: _onPageChanged,
                controller: _pageController,
                children: [
                  BlocProvider<VoteListCubit>(
                      create: (context) => VoteListCubit(),
                      child: const VoteListPages(),
                  ),
                  BlocProvider<VoteCubit>(
                      create: (context) => VoteCubit(),
                      child: const VotePages(),
                  ),
                  BlocProvider<MyPagesCubit>(
                    create: (BuildContext context) => MyPagesCubit()..initPages(),
                    child: const MyPages(),
                  ),
                  const MeetPage(),
                ],
              ),
            ),
          ],
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
          onTapNavigation(targetPage);
        },
        child: Text(name, style: TextStyle(fontSize: SizeConfig.defaultSize * 1.8, fontWeight: FontWeight.w500, color: (targetPage == nowPage) ? Colors.black : Colors.grey))
    );
  }
}
