import 'package:dart_flutter/src/common/util/analytics_util.dart';
import 'package:dart_flutter/src/presentation/component/webview_fullscreen.dart';

import '../../../../res/config/size_config.dart';
import 'package:dart_flutter/src/common/auth/dart_auth_cubit.dart';
import 'package:dart_flutter/src/presentation/signup/viewmodel/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChooseGender extends StatefulWidget {
  const ChooseGender({Key? key}) : super(key: key);

  @override
  State<ChooseGender> createState() => _ChooseGenderState();
}

class _ChooseGenderState extends State<ChooseGender> {
  List<Widget> genders = <Widget>[
    const Text('남성'),
    const Text('여성'),
  ];
  final List<bool> _selectedGender = List.generate(2, (_) => false);
  bool vertical = false;
  String selectedGender = "MALE";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.screenHeight * 0.15,
              ),
              Text("성별을 선택해주세요!", style: TextStyle(fontSize: SizeConfig.defaultSize * 2.7, fontWeight: FontWeight.w700)),
              SizedBox(
                height: SizeConfig.defaultSize * 1.5,
              ),
              Text("이후 변경할 수 없어요! 신중히 선택해주세요!",
                  style: TextStyle(fontSize: SizeConfig.defaultSize * 1.2, color: Colors.grey)),
              SizedBox(
                height: SizeConfig.defaultSize * 10,
              ),

              ToggleButtons(
                direction: Axis.horizontal,
                onPressed: (int index) {
                  setState(() {
                    // The button that is tapped is set to true, and the others to false.
                    for (int i = 0; i < _selectedGender.length; i++) {
                      _selectedGender[i] = i == index;
                    }
                    if (index == 0) selectedGender = "FEMALE";
                    if (index == 1) selectedGender = "MALE";
                  });
                  AnalyticsUtil.logEvent("회원가입_성별_선택", properties: {
                    "성별": selectedGender=="FEMALE" ? "여자" : "남자"
                  });
                },
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                selectedBorderColor: const Color(0xff7C83FD),
                selectedColor: Colors.white,
                fillColor: const Color(0xff7C83FD).withOpacity(0.8),
                color: const Color(0xff7C83FD),
                constraints: BoxConstraints(
                  minHeight: SizeConfig.screenHeight * 0.2,
                  minWidth: SizeConfig.screenWidth * 0.4,
                ),
                isSelected: _selectedGender,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(Icons.girl_rounded, size: SizeConfig.defaultSize * 8,),
                      Text("여자", style: TextStyle(
                        fontSize: SizeConfig.defaultSize * 2.7,
                        fontWeight: FontWeight.w600,
                      ),),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(Icons.boy_rounded, size: SizeConfig.defaultSize * 8),
                      Text("남자", style: TextStyle(
                        fontSize: SizeConfig.defaultSize * 2.7,
                        fontWeight: FontWeight.w600,
                      ),),
                    ],
                  ),
                ],
              ),
              SizedBox(height: SizeConfig.defaultSize * 10 ,),
              Text("본인이 만 14세 이상이며, 엔대생 서비스의 필수 동의 항목인",
                style: TextStyle(fontSize: SizeConfig.defaultSize * 1.4),
                textAlign: TextAlign.center,),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        AnalyticsUtil.logEvent("회원가입_성별_이용약관");
                        Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewFullScreen(url: "https://swye0n.tistory.com/14", title: "이용약관")));
                      },
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.symmetric(vertical: SizeConfig.defaultSize * 1.2),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(" 이용약관 ", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.3, color: const Color(0xff7C83FD))),
                    ),
                    Text("및", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.3)),
                    TextButton(
                      onPressed: () {
                        AnalyticsUtil.logEvent("회원가입_성별_개인정보");
                        Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewFullScreen(url: "https://swye0n.tistory.com/9", title: "개인정보 처리방침")));
                      },
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(" 개인정보 처리방침", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.3, color: const Color(0xff7C83FD))),
                    ),
                    Text("에 동의하시면 계속 진행해주세요.", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.3)),
                  ]
              ),

              SizedBox(
                height: SizeConfig.defaultSize * 5,
              ),

              SizedBox(
                width: SizeConfig.screenWidth * 0.9,
                height: SizeConfig.defaultSize * 5,
                child: _selectedGender.contains(true)
                    ? ElevatedButton(
                    onPressed: () {
                      AnalyticsUtil.logEvent("회원가입_성별_다음");
                      BlocProvider.of<SignupCubit>(context).stepGender(selectedGender);
                      BlocProvider.of<DartAuthCubit>(context).doneSignup();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff7C83FD),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15), // 모서리 둥글기 설정
                      ),
                    ),
                    child: Text("동의 후 완료하기", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.7, fontWeight: FontWeight.w600, color: Colors.white),)
                )
                    : ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                    ),
                    child: Text("성별을 선택해주세요", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.7, fontWeight: FontWeight.w600, color: Colors.black38),)
                ),
              )
            ],
          ),
        ),
    );
  }
}