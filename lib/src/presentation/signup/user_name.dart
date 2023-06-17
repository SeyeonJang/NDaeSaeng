import 'package:dart_flutter/src/presentation/signup/viewmodel/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'user_phone.dart';

// btn 컬러 정의 (설정중)
Color getColor(Set<MaterialState> states) { //
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed, // 클릭했을 때
    MaterialState.hovered, // 마우스 커서를 상호작용 가능한 버튼 위에 올려두었을 때
    MaterialState.focused,
  };
  if (states.any(interactiveStates.contains)) {
    return Colors.blueAccent; // text color값 설정 -> Colors
  }
  return Colors.grey;
}
// text 컬러 정의 (설정중)
Color getColorText(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed, // 클릭했을 때
    MaterialState.hovered, // 마우스 커서를 상호작용 가능한 버튼 위에 올려두었을 때
    MaterialState.focused,
  };
  if (states.any(interactiveStates.contains)) {
    return Colors.white; // text color값 설정 -> Colors
  }
  return Colors.black;
}


// #1-5 이름 입력
class UserName extends StatefulWidget {
  @override
  _UserNameState createState() => _UserNameState();
}

class _UserNameState extends State<UserName> {
  TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text('User Name'),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            }, icon: Icon(Icons.arrow_back)),
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
            ),
            const Text("이름", style: TextStyle(fontSize: 25)),
            const SizedBox( height: 140, ),
            SizedBox( // 입력 공간 Textfield
                width: 400,
                child: TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    // labelText: 'Name',
                      hintText: "이름(본명)을 입력해주세요!" // 서버에서 에러메시지도 만들었으면 같이 가져오기
                  ),
                  // 유효성검사 ************************************
                  // String? _validator(String name) {
                  //   if (name.length<2) {
                  //     return ("이름을 확인해주세요!");
                  //   }
                  //   return null;
                  // },
                ),
            ),
            const SizedBox(height: 160),
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<SignupCubit>(context).stepName(_nameController.text);
              },
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.resolveWith(getColorText), // textcolor
                backgroundColor: MaterialStateProperty.resolveWith(getColor), // backcolor
              ),
              child: const Text('다음으로'),
            ),
          ],
        ),
      ),
    );
  }
}
