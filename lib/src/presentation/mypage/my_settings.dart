import 'package:dart_flutter/src/presentation/mypage/my_page.dart';
import 'package:dart_flutter/src/presentation/signup/tos1.dart';
import 'package:dart_flutter/src/presentation/signup/tos2.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../res/size_config.dart';

class MySettings extends StatelessWidget {
  const MySettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.symmetric(
            vertical: SizeConfig.defaultSize * 2,
            horizontal: SizeConfig.defaultSize),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => {
                      Navigator.pop(context, MaterialPageRoute(builder: (context) => MyPage()))
                    },
                    icon: Icon(Icons.arrow_back_ios_new_rounded,
                      size: SizeConfig.defaultSize * 2),
                  ),
                  Text("설정",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: SizeConfig.defaultSize * 2,
                    ),
                  ),
                ],
              ),
              SizedBox(height: SizeConfig.defaultSize * 3,),
              Container(
                height: SizeConfig.defaultSize * 20,
                child: Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: SizeConfig.defaultSize,
                      horizontal: SizeConfig.defaultSize * 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("이름",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: SizeConfig.defaultSize * 1.6,
                              ),),
                            Text("장세연",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: SizeConfig.defaultSize * 1.6,
                              ),),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("학교",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: SizeConfig.defaultSize * 1.6,
                              ),),
                            Text("가톨릭대학교",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: SizeConfig.defaultSize * 1.6,
                              ),),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("학과",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: SizeConfig.defaultSize * 1.6,
                              ),),
                            Text("컴퓨터정보공학부",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: SizeConfig.defaultSize * 1.6,
                              ),),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("학번",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: SizeConfig.defaultSize * 1.6,
                              ),),
                            Text("21학번",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: SizeConfig.defaultSize * 1.6,
                              ),),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("성별",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: SizeConfig.defaultSize * 1.6,
                              ),),
                            Text("여성",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: SizeConfig.defaultSize * 1.6,
                              ),),
                          ],
                        ),
                      ],
                    )
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.defaultSize * 2,),
              Container( // 구분선
                padding: EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0,),
                height: SizeConfig.defaultSize * 2,
                color: Colors.grey.withOpacity(0.1),
              ),
              SizedBox(height: SizeConfig.defaultSize * 2,),

              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("회원탈퇴",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: SizeConfig.defaultSize * 1.6,
                      ),
                    ),
                    SizedBox(height: SizeConfig.defaultSize * 2,),
                    Text("로그아웃",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: SizeConfig.defaultSize * 1.6,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: SizeConfig.defaultSize * 33,),

              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, MaterialPageRoute(builder: (context) => Tos1()));
                      },
                      child: Text("이용약관", style: TextStyle(fontSize: 14)),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, MaterialPageRoute(builder: (context) => Tos2()));
                      },
                      child: Text("개인정보 처리방침", style: TextStyle(fontSize: 14)),
                    ),
                    TextButton(
                      onPressed: () {
                        // launch로 Dart 건의 구글폼으로 이동
                        launchUrl(
                          Uri(
                            scheme: 'https',
                            host: 'docs.google.com',
                            path: 'forms/d/e/1FAIpQLSd8H_R1_sq1QZHiuSRGd7XUyLvegZEsV05kLlcxO1JLc6TseQ/viewform?usp=sf_link',

                          ),
                          mode: LaunchMode.inAppWebView,
                        );
                      },
                      child: Text("Dart에 건의하기", style: TextStyle(fontSize: 14)),
                    ),
                    TextButton(
                      onPressed: () {
                        // launch로 우리 카카오톡 페이지로 연결
                      },
                      child: Text("1:1 문의", style: TextStyle(fontSize: 14)),
                    ),
                  ]
              ),
            ],),
        ),
      ),
    );
  }
}
