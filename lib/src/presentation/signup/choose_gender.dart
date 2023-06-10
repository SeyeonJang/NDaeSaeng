import 'package:flutter/material.dart';

class ChooseGender extends StatelessWidget {
  const ChooseGender({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              }, icon: Icon(Icons.arrow_back)),
        ),
        body: Center(
          child: Center(
            child: ScaffoldBody(),
          ),
        ),
      ),
    );
  }
}

class ScaffoldBody extends StatelessWidget {
  const ScaffoldBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const List<Widget> genders = <Widget>[
      Text('남성'),
      Text('여성'),
    ];
    final List<bool> _selectedGender = <bool>[false, false];
    bool vertical = false;

    return Column(
      children: [
        const SizedBox(
          height: 100,
        ),
        const Text("성별 선택", style: TextStyle(fontSize: 25)),
        const SizedBox( height: 140, ),
        
        ToggleButtons(
          direction: vertical ? Axis.vertical : Axis.horizontal,
          // onPressed: () {},
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
          children: genders,
        ),

        const SizedBox( height: 100, ),
        ElevatedButton( // 버튼
          onPressed: () {}, // 임시용
          // onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => 2-1())), // animation은 나중에 추가 + 2-1로 가야함
          // style: ButtonStyle(
          //   foregroundColor: MaterialStateProperty.resolveWith(getColorText), // textcolor
          //   backgroundColor: MaterialStateProperty.resolveWith(getColor), // backcolor
          // ),
          child: const Text("다음으로"),
        ),
      ],
    );
  }
}