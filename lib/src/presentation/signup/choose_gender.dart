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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {

              }, icon: Icon(Icons.arrow_back)),
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              const Text("성별 선택", style: TextStyle(fontSize: 25)),
              const SizedBox( height: 140, ),

              ToggleButtons(
                direction: Axis.horizontal,
                onPressed: (int index) {
                  setState(() {
                    // The button that is tapped is set to true, and the others to false.
                    for (int i = 0; i < _selectedGender.length; i++) {
                      _selectedGender[i] = i == index;
                    }
                  });
                },
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                selectedBorderColor: Colors.red[700],
                selectedColor: Colors.white,
                fillColor: Colors.red[200],
                color: Colors.red[400],
                constraints: const BoxConstraints(
                  minHeight: 40.0,
                  minWidth: 80.0,
                ),
                isSelected: _selectedGender,
                children: [
                  Text("여자"),
                  Text("남자"),
                ],
                // children: [genders],
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.2,),
              const Text("본인이 만 14세 이상이며, Dart 서비스의 필수 동의 항목인",
                style: TextStyle(fontSize: 13),
                textAlign: TextAlign.center,),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => Tos1()));
                      },
                      child: Text("이용약관", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.3)),
                    ),
                    Text("및", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.3)),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => Tos2()));
                      },
                      child: Text("개인정보 처리방침", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.3)),
                    ),
                    Text("에 동의하시면 계속 진행해주세요.", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.3)),
                  ]
              ),

              const SizedBox( height: 100, ),
              ElevatedButton( // 버튼
                onPressed: () {
                  BlocProvider.of<SignupCubit>(context).stepGender("M");
                  BlocProvider.of<AuthCubit>(context).doneSignup();
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const DartPageView()), (route)=>false);
                }, // 임시용
                // onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => 2-1())), // animation은 나중에 추가 + 2-1로 가야함
                // style: ButtonStyle(
                //   foregroundColor: MaterialStateProperty.resolveWith(getColorText), // textcolor
                //   backgroundColor: MaterialStateProperty.resolveWith(getColor), // backcolor
                // ),
                child: const Text("다음으로"),
              ),
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