import 'package:dart_flutter/res/config/size_config.dart';
import 'package:dart_flutter/src/common/util/analytics_util.dart';
import 'package:dart_flutter/src/presentation/chat/view/chat_real_time.dart';
import 'package:dart_flutter/src/presentation/chat/view/chat_response_get.dart';
import 'package:dart_flutter/src/presentation/chat/view/chat_response_send.dart';
import 'package:dart_flutter/src/presentation/chat/viewmodel/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPages extends StatefulWidget {
  const ChatPages({super.key});

  @override
  State<ChatPages> createState() => _ChatPagesState();
}

class _ChatPagesState extends State<ChatPages> {
  int _page = 0;
  late final PageController _pageController = PageController(initialPage: _page);

  @override
  void initState() {
    super.initState();
    _page = 0;
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: SizeConfig.defaultSize * 1, right: SizeConfig.defaultSize * 1, top: SizeConfig.defaultSize),
            child: Container(
              width: SizeConfig.screenWidth * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(width: SizeConfig.defaultSize,),
                      Text("채팅", style: TextStyle(
                          fontSize: SizeConfig.defaultSize * 1.8,
                          fontWeight: FontWeight.w600
                      ),),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _TapBarButton(name: "실시간 채팅", targetPage: 0, nowPage: _page, onTapNavigation: _onTapNavigation),
                      _TapBarButton(name: "받은 요청", targetPage: 1, nowPage: _page, onTapNavigation: _onTapNavigation),
                      _TapBarButton(name: "보낸 요청", targetPage: 2, nowPage: _page, onTapNavigation: _onTapNavigation),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: PageView(
              onPageChanged: _onPageChanged,
              controller: _pageController,
              children: const [
                ChatRealTime(),
                ChatResponseGet(),
                ChatResponseSend(),
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
          // AnalyticsUtil.logEvent("상단탭_선택", properties: {"탭 이름": name});
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
                ? SizeConfig.defaultSize * 1.62
                : SizeConfig.defaultSize * 1.6,
                fontWeight:
                (targetPage == nowPage)
                    ? FontWeight.w600
                    : FontWeight.w500,
                color:
                (targetPage == nowPage)
                    ? const Color(0xffFF5C58)
                    : Colors.grey)),
          ),
        )
    );
  }
}
