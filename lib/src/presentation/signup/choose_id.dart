  import 'package:dart_flutter/res/size_config.dart';
  import 'package:dart_flutter/src/presentation/signup/user_name.dart';
  import 'package:dart_flutter/src/presentation/signup/viewmodel/signup_cubit.dart';
  import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';

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
  class ChooseId extends StatefulWidget {
    const ChooseId({Key? key}) : super(key: key);

    @override
    State<ChooseId> createState() => _ChooseIdState();
  }

  class _ChooseIdState extends State<ChooseId> {
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

  class ScaffoldBody extends StatefulWidget {
    const ScaffoldBody({
      super.key,
    });

    static final List<String> items = ['--', '23', '22', '21', '20', '19', '18', '17', '16', '15', '14', '13', '12', '11', '10'];
    static final adminNumItems = [ // 학번
      '--','23','22','21','20','19','18','17','16','15'
    ];
    static final ageItems = [ // 나이
      '--','04','03','02','01','00','99','98','97','96','95'
    ];
    static int adminIndex = 0;
    static int ageIndex = 0;

  @override
  State<ScaffoldBody> createState() => _ScaffoldBodyState();
}

class _ScaffoldBodyState extends State<ScaffoldBody> {
    // TODO 로직 빼야됨
    int twoNumberToYear(int twoNumber) {
      if (twoNumber < 70) {  // 70을 기준으로 년도 반환
        return twoNumber + 2000;
      }
      return twoNumber + 1900;
    }

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
            height: SizeConfig.screenHeight * 0.4,
            child: Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column( // 학번
                    children: [
                      SizedBox(height: SizeConfig.defaultSize * 1.2,),
                      SizedBox(
                        height: SizeConfig.defaultSize * 25,
                        width: SizeConfig.screenWidth * 0.45,
                        child: CupertinoPicker(
                          looping: true,
                          backgroundColor: Colors.white,
                          itemExtent: SizeConfig.defaultSize * 5,
                          selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
                            background: CupertinoColors.systemIndigo.withOpacity(0.3),
                          ),
                          children: List.generate(ScaffoldBody.adminNumItems.length, (index) {
                            final isSelected = ScaffoldBody.adminIndex == index;
                            final item = ScaffoldBody.adminNumItems[index];
                            final color = isSelected ? CupertinoColors.systemIndigo :CupertinoColors.black;
                            return Center(
                              child: Text(item,style: TextStyle(color: color, fontSize: SizeConfig.defaultSize * 3)),
                            );
                          }),
                          scrollController: FixedExtentScrollController(
                            initialItem: 0, // 몇 번째 인덱스가 제일 먼저 나올지
                          ),
                          onSelectedItemChanged: (index) {
                            setState(() => ScaffoldBody.adminIndex = index);
                            final item = ScaffoldBody.adminNumItems[index];
                            print('Selected item: ${ScaffoldBody.adminNumItems}');
                          },
                        ),
                      ),
                      SizedBox(height: SizeConfig.defaultSize * 2,),
                      Text(
                        ScaffoldBody.adminNumItems[ScaffoldBody.adminIndex]+"학번",
                        style: TextStyle(
                            fontSize: SizeConfig.defaultSize * 2.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.black
                        ),
                      ),
                    ],
                  ),
                  Column( // 나이
                    children: [
                      SizedBox(height: SizeConfig.defaultSize * 1.2,),
                      SizedBox(
                        height: SizeConfig.defaultSize * 25,
                        width: SizeConfig.screenWidth * 0.45,
                        child: CupertinoPicker(
                          looping: true,
                          backgroundColor: Colors.white,
                          itemExtent: SizeConfig.defaultSize * 5,
                          selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
                            background: CupertinoColors.systemIndigo.withOpacity(0.2),
                          ),
                          children: List.generate(ScaffoldBody.ageItems.length, (index) {
                            final isSelected = ScaffoldBody.ageIndex == index;
                            final item = ScaffoldBody.ageItems[index];
                            final color = isSelected ? CupertinoColors.systemIndigo :CupertinoColors.black;
                            return Center(
                              child: Text(item,style: TextStyle(color: color, fontSize: SizeConfig.defaultSize * 3)),
                            );
                          }),
                          scrollController: FixedExtentScrollController(
                            initialItem: 0, // 몇 번째 인덱스가 제일 먼저 나올지
                          ),
                          onSelectedItemChanged: (index) {
                            setState(() => ScaffoldBody.ageIndex = index);
                            final item = ScaffoldBody.ageItems[index];
                            print('Selected item: ${ScaffoldBody.ageItems}');
                          },
                        ),
                      ),
                      SizedBox(height: SizeConfig.defaultSize * 2,),
                      Text(
                        ScaffoldBody.ageItems[ScaffoldBody.ageIndex]+"년생",
                        style: TextStyle(
                            fontSize: SizeConfig.defaultSize * 2.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.black
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          SizedBox( height: SizeConfig.defaultSize * 5, ),
          ElevatedButton( // 버튼
            onPressed: () {
              BlocProvider.of<SignupCubit>(context).stepAdmissionNumber(
                  twoNumberToYear(int.parse(ScaffoldBody.adminNumItems[ScaffoldBody.adminIndex])),
                  twoNumberToYear(int.parse(ScaffoldBody.ageItems[ScaffoldBody.ageIndex]))
              );
            },
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
