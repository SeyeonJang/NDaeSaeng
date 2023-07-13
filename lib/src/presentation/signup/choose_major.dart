import 'package:dart_flutter/src/common/util/university_finder.dart';
import 'package:dart_flutter/src/data/model/university.dart';
import 'package:dart_flutter/src/presentation/signup/choose_id.dart';
import 'package:dart_flutter/src/presentation/signup/viewmodel/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

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


class ChooseMajor extends StatelessWidget {
  const ChooseMajor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Center(
        child: ScaffoldBody(),
      ),
    );
  }
}
class ScaffoldBody extends StatefulWidget {
  const ScaffoldBody({
    super.key,
  });

  @override
  State<ScaffoldBody> createState() => _ScaffoldBodyState();
}

class _ScaffoldBodyState extends State<ScaffoldBody> {
  late UniversityFinder universityFinder;
  final TextEditingController _typeAheadController = TextEditingController();
  late bool isSelectedOnTypeAhead;
  late String universityName;
  String universityDepartment = "";
  late University university;

  @override
  void initState() {
    super.initState();
    List<University> universities = BlocProvider.of<SignupCubit>(context).getUniversities;
    universityFinder = UniversityFinder(universities: universities);
    universityName = BlocProvider.of<SignupCubit>(context).state.inputState.tempUnivName!;
    setState(() {
      isSelectedOnTypeAhead = false;
    });
  }

  void _typeOnTypeAhead() {
    setState(() {
      isSelectedOnTypeAhead = false;
    });
  }

  void _selectOnTypeAhead() {
    setState(() {
      isSelectedOnTypeAhead = true;
    });
  }

  void _setUniversity(University university) {
    _setUniversityDepartment(university.department);
    this.university = university;
  }

  void _setUniversityDepartment(String name) {
    universityDepartment = name;
    _typeAheadController.text = name;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          const Text("학과 선택", style: TextStyle(fontSize: 25)),
          const SizedBox(
            height: 40,
          ),
          const Text("이후 변경할 수 없어요! 신중히 선택해주세요!",
              style: TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(
            height: 100,
          ),
          SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: TypeAheadField(
                  // 학교 찾기
                  textFieldConfiguration: TextFieldConfiguration(
                      controller: _typeAheadController,
                      autofocus: false, // 키보드 자동으로 올라오는 거
                      style: DefaultTextStyle.of(context)
                          .style
                          .copyWith(fontStyle: FontStyle.italic, color: isSelectedOnTypeAhead ? Colors.blueAccent : Colors.black),
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: "학과명을 입력해주세요")),

                  suggestionsCallback: (pattern) {
                    // 입력된 패턴에 기반하여 검색 결과를 반환
                    _typeOnTypeAhead();
                    if (pattern.isEmpty || isSelectedOnTypeAhead) {
                      return [];
                    }
                    return universityFinder.getDepartmentSuggestions(universityName, pattern);
                  },

                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      leading: Icon(Icons.school),
                      title: Text(suggestion['department']),
                      subtitle: Text('${suggestion['name']}'),
                    );
                  },

                  // 추천 text를 눌렀을 때 일어나는 액션 (밑의 코드는 ProductPage로 넘어감)
                  onSuggestionSelected: (suggestion) {
                    if (isSelectedOnTypeAhead == false) {
                      _selectOnTypeAhead();
                    }

                    _setUniversity(University.fromJson(suggestion));
                  },
                ),
              )),
          const SizedBox( height: 100, ),
          ElevatedButton( // 버튼
            onPressed: () {
              if (isSelectedOnTypeAhead) {
                BlocProvider.of<SignupCubit>(context).stepDepartment(university);
              }
            },
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.resolveWith(getColorText), // textcolor
              backgroundColor: MaterialStateProperty.resolveWith(getColor), // backcolor
            ),
            child: isSelectedOnTypeAhead ? const Text("다음으로") : const Text("선택해주세요"),
          ),
        ],
      ),
    );
  }
}
