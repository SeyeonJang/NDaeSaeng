import 'package:dart_flutter/src/common/util/analytics_util.dart';

import '../../../res/size_config.dart';
import 'package:dart_flutter/src/common/auth/auth_cubit.dart';
import 'package:dart_flutter/src/presentation/page_view.dart';
import 'package:dart_flutter/src/presentation/signup/tos1.dart';
import 'package:dart_flutter/src/presentation/signup/tos2.dart';
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
    Text('남성'),
    Text('여성'),
  ];
  final List<bool> _selectedGender = List.generate(2, (_) => false);
  bool vertical = false;
  String selectedGender = "MALE";

  final List<bool> _selectedGender2 = [false, false];
  String selectedGender2 = "";
  
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
                  print("$index, ${_selectedGender[index]}, $selectedGender");
                },
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                selectedBorderColor: Color(0xff7C83FD),
                selectedColor: Colors.white,
                fillColor: Color(0xff7C83FD).withOpacity(0.8),
                color: Color(0xff7C83FD),
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
              Text("본인이 만 14세 이상이며, Dart 서비스의 필수 동의 항목인",
                style: TextStyle(fontSize: SizeConfig.defaultSize * 1.4),
                textAlign: TextAlign.center,),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        AnalyticsUtil.logEvent("회원가입_성별_이용약관");
                        Navigator.push(context, MaterialPageRoute(builder: (_) => Tos1()));
                      },
                      child: Text("이용약관", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.3)),
                    ),
                    Text("및", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.3)),
                    TextButton(
                      onPressed: () {
                        AnalyticsUtil.logEvent("회원가입_성별_개인정보");
                        Navigator.push(context, MaterialPageRoute(builder: (_) => Tos2()));
                      },
                      child: Text("개인정보 처리방침", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.3)),
                    ),
                    Text("에 동의하시면 계속 진행해주세요.", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.3)),
                  ]
              ),

              SizedBox(
                height: SizeConfig.defaultSize * 5,
              ),

              Container(
                width: SizeConfig.screenWidth * 0.9,
                height: SizeConfig.defaultSize * 5,
                child: _selectedGender.contains(true)
                    ? ElevatedButton(
                    onPressed: () {
                      AnalyticsUtil.logEvent("회원가입_성별_다음");
                      BlocProvider.of<SignupCubit>(context).stepGender(selectedGender);  // TODO 성별선택 controller 를 통해 사용자 입력을 받아오기
                      BlocProvider.of<AuthCubit>(context).doneSignup();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff7C83FD),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15), // 모서리 둥글기 설정
                      ),
                    ),
                    child: Text("동의 후 완료하기", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.7, fontWeight: FontWeight.w600, color: Colors.white),)
                )
                    : ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
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
//
// class ScaffoldBody extends StatelessWidget {
//   const ScaffoldBody({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     const List<Widget> genders = <Widget>[
//       Text('남성'),
//       Text('여성'),
//     ];
//     final List<bool> _selectedGender = List.generate(2, (_) => false);
//     bool vertical = false;
//
//     return Column(
//       children: [
//         const SizedBox(
//           height: 100,
//         ),
//         const Text("성별 선택", style: TextStyle(fontSize: 25)),
//         const SizedBox( height: 140, ),
//
//         ToggleButtons(
//           direction: Axis.horizontal,
//           onPressed: (int index) {
//             super.setState(() {
//               _selectedGender[index] != !_selectedGender[index];
//             });
//           },
//           borderRadius: const BorderRadius.all(Radius.circular(8)),
//           selectedBorderColor: Colors.red[700],
//           selectedColor: Colors.white,
//           fillColor: Colors.red[200],
//           color: Colors.red[400],
//           constraints: const BoxConstraints(
//             minHeight: 40.0,
//             minWidth: 80.0,
//           ),
//           isSelected: _selectedGender,
//           children: [
//             Text("여자"),
//             Text("남자"),
//           ],
//           // children: [genders],
//         ),
//
//         const SizedBox( height: 100, ),
//         ElevatedButton( // 버튼
//           onPressed: () {
//             BlocProvider.of<SignupCubit>(context).stepGender("M");
//             BlocProvider.of<AuthCubit>(context).doneSignup();
//             Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const DartPageView()), (route)=>false);
//           }, // 임시용
//           // onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => 2-1())), // animation은 나중에 추가 + 2-1로 가야함
//           // style: ButtonStyle(
//           //   foregroundColor: MaterialStateProperty.resolveWith(getColorText), // textcolor
//           //   backgroundColor: MaterialStateProperty.resolveWith(getColor), // backcolor
//           // ),
//           child: const Text("다음으로"),
//         ),
//       ],
//     );
//   }
// }