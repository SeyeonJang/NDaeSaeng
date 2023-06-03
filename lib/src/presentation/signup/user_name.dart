import 'package:flutter/material.dart';
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
            ),
            const Text("이름", style: TextStyle(fontSize: 25)),
            const SizedBox( height: 40, ),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                // labelText: 'Name',
                hintText: "이름(본명)을 입력해주세요!" // 서버에서 에러메시지도 만들었으면 같이 가져오기
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => UserPhone(
                      userName: _nameController.text,
                    ),
                  ),
                );
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
