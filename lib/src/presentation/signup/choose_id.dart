import 'package:dart_flutter/src/presentation/signup/user_name.dart';
import 'package:flutter/material.dart';

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
  // if (states.contains(MaterialState.hovered)) { return color['hover']; }
  // else if (states.contains(MaterialState.pressed) || states.contains(MaterialState.focused)) {
  //   return color['pressed'];
  // } else if (states.contains(MaterialState.disabled)) {
  //   return color['disable'];
  // } else { return color['basic']; }
}


// #1-4 학번 선택
class ChooseId extends StatelessWidget {
  const ChooseId({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            }, icon: Icon(Icons.arrow_back)),
          ),
        body: Center(
          child: ScaffoldBody(),
        ),
    );
  }
}

class ScaffoldBody extends StatelessWidget {
  const ScaffoldBody({
    super.key,
  });

  static final List<String> items = ['--', '23', '22', '21', '20', '19', '18', '17', '16', '15', '14', '13', '12', '11', '10'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 100,
        ),
        const Text("학번 선택", style: TextStyle(fontSize: 25)),
        const SizedBox( height: 100, ),

        Container(
          height: 300,
          child: ListWheelScrollView(
            controller: FixedExtentScrollController(initialItem: 0), // 시작 위치
            physics: const FixedExtentScrollPhysics(),
            itemExtent: 60,
            perspective: 0.005, // 꺾이는 정도 (0.01과 비교하면 잘 보임)
            diameterRatio: 2.5, // item간격
            children: List.generate(items.length, (idx) {
              return Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      items[idx],
                      style: const TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }),
          ),
        ),

        const SizedBox( height: 100, ),
        ElevatedButton( // 버튼
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => UserName())),
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.resolveWith(getColorText), // textcolor
            backgroundColor: MaterialStateProperty.resolveWith(getColor), // backcolor
          ),
          child: const Text("다음으로"),
        ),
      ],
    );
  }
}
