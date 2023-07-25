  import 'package:dart_flutter/res/size_config.dart';
import 'package:dart_flutter/src/common/util/analytics_util.dart';
  import 'package:dart_flutter/src/presentation/signup/user_name.dart';
  import 'package:dart_flutter/src/presentation/signup/viewmodel/signup_cubit.dart';
  import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';

  class ChooseId extends StatefulWidget {
    const ChooseId({Key? key}) : super(key: key);

    @override
    State<ChooseId> createState() => _ChooseIdState();
  }

  class _ChooseIdState extends State<ChooseId> {
    @override
  void initState() {
    super.initState();
    AnalyticsUtil.logEvent("회원가입_학번나이_접속");
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
          backgroundColor: Colors.white,
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
          SizedBox(
            height: SizeConfig.screenHeight * 0.15,
          ),
          Text("학번과 나이를 선택해주세요!", style: TextStyle(fontSize: SizeConfig.defaultSize * 2.7, fontWeight: FontWeight.w700)),
          SizedBox(
            height: SizeConfig.defaultSize * 1.5,
          ),
          Text("이후 변경할 수 없어요! 신중히 선택해주세요!",
              style: TextStyle(fontSize: SizeConfig.defaultSize * 1.2, color: Colors.grey)),
          SizedBox(
            height: SizeConfig.defaultSize * 10,
          ),

          Container(
            height: SizeConfig.screenHeight * 0.4,
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
                          background: Color(0xff7C83FD).withOpacity(0.2),
                        ),
                        children: List.generate(ScaffoldBody.adminNumItems.length, (index) {
                          final isSelected = ScaffoldBody.adminIndex == index;
                          final item = ScaffoldBody.adminNumItems[index];
                          final color = isSelected ? Color(0xff7C83FD) : CupertinoColors.black;
                          return Center(
                            child: Text(item,style: TextStyle(color: color, fontSize: SizeConfig.defaultSize * 3)),
                          );
                        }),
                        scrollController: FixedExtentScrollController(
                          initialItem: 0, // 몇 번째 인덱스가 제일 먼저 나올지
                        ),
                        onSelectedItemChanged: (index) {
                          AnalyticsUtil.logEvent("회원가입_학번나이_학번선택", properties: {
                            '학번': ScaffoldBody.ageIndex,
                          });
                          setState(() => ScaffoldBody.adminIndex = index);
                          final item = ScaffoldBody.adminNumItems[index];
                          print('Selected item: ${ScaffoldBody.adminNumItems}');
                        },
                      ),
                    ),
                    SizedBox(height: SizeConfig.defaultSize * 2,),
                    Text(
                      ScaffoldBody.adminNumItems[ScaffoldBody.adminIndex]+" 학번",
                      style: TextStyle(
                          fontSize: SizeConfig.defaultSize * 2.2,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff7C83FD),
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
                          background: Color(0xff7C83FD).withOpacity(0.2),
                        ),
                        children: List.generate(ScaffoldBody.ageItems.length, (index) {
                          final isSelected = ScaffoldBody.ageIndex == index;
                          final item = ScaffoldBody.ageItems[index];
                          final color = isSelected ? Color(0xff7C83FD) :CupertinoColors.black;
                          return Center(
                            child: Text(item,style: TextStyle(color: color, fontSize: SizeConfig.defaultSize * 3)),
                          );
                        }),
                        scrollController: FixedExtentScrollController(
                          initialItem: 0, // 몇 번째 인덱스가 제일 먼저 나올지
                        ),
                        onSelectedItemChanged: (index) {
                          AnalyticsUtil.logEvent("회원가입_학번나이_나이선택", properties: {
                            '나이': ScaffoldBody.ageIndex,
                          });
                          setState(() => ScaffoldBody.ageIndex = index);
                          final item = ScaffoldBody.ageItems[index];
                          print('Selected item: ${ScaffoldBody.ageItems}');
                        },
                      ),
                    ),
                    SizedBox(height: SizeConfig.defaultSize * 2,),
                    Text(
                      ScaffoldBody.ageItems[ScaffoldBody.ageIndex]+" 년생",
                      style: TextStyle(
                          fontSize: SizeConfig.defaultSize * 2.2,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff7C83FD)
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(
            height: SizeConfig.defaultSize * 5,
          ),

          Container(
            width: SizeConfig.screenWidth * 0.9,
            height: SizeConfig.defaultSize * 5,
            child: ScaffoldBody.ageIndex != 0 && ScaffoldBody.adminIndex != 0
              ? ElevatedButton(
                onPressed: () {
                  AnalyticsUtil.logEvent("회원가입_학번나이_다음");
                  BlocProvider.of<SignupCubit>(context).stepAdmissionNumber(
                      twoNumberToYear(int.parse(ScaffoldBody.adminNumItems[ScaffoldBody.adminIndex])),
                      twoNumberToYear(int.parse(ScaffoldBody.ageItems[ScaffoldBody.ageIndex]))
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff7C83FD),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), // 모서리 둥글기 설정
                  ),
                ),
                child: Text("다음으로", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.7, fontWeight: FontWeight.w600, color: Colors.white),)
              )
              : ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.grey[200],
                ),
                child: Text("학번과 나이를 모두 선택해주세요", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.7, fontWeight: FontWeight.w600, color: Colors.black38),)
              ),
          ),
        ],
      );
    }
}
