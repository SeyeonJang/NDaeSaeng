import 'package:dart_flutter/src/data/model/university.dart';
import 'package:dart_flutter/src/presentation/signup/land_page.dart';
import 'package:dart_flutter/src/presentation/signup/viewmodel/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../common/util/university_finder.dart';

// btn 컬러 정의 (설정중)
Color getColor(Set<MaterialState> states) {
  //
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

// #1-2 학교 선택
class ChooseSchool extends StatefulWidget {
  const ChooseSchool({Key? key}) : super(key: key);

  @override
  State<ChooseSchool> createState() => _ChooseSchoolState();
}

class _ChooseSchoolState extends State<ChooseSchool> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
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
  String universityName = "";

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

  void _setUniversityName(String name) {
    universityName = name;
    _typeAheadController.text = name;
  }

  @override
  void initState() {
    super.initState();
    List<University> universities = BlocProvider.of<SignupCubit>(context).getUniversities;
    universityFinder = UniversityFinder(universities: universities);
    setState(() {
      isSelectedOnTypeAhead = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 100,
        ),
        const Text("학교 선택", style: TextStyle(fontSize: 25)),
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
                    border: OutlineInputBorder(), hintText: "학교명을 입력해주세요")),

            suggestionsCallback: (pattern) {
              // 입력된 패턴에 기반하여 검색 결과를 반환
              _typeOnTypeAhead();
              if (pattern.isEmpty || isSelectedOnTypeAhead) {
                return [];
              }
              return universityFinder.getNameSuggestions(pattern);
            },

            itemBuilder: (context, suggestion) {
                return ListTile(
                  leading: Icon(Icons.school),
                  title: Text(suggestion['name']),
                  // subtitle: Text('\$${suggestion['price']}'),
                );
            },

            // 추천 text를 눌렀을 때 일어나는 액션 (밑의 코드는 ProductPage로 넘어감)
            onSuggestionSelected: (suggestion) {
              if (isSelectedOnTypeAhead == false) {
                _selectOnTypeAhead();
              }
              _setUniversityName(suggestion['name']);
            },
          ),
        )),
        const SizedBox(
          height: 100,
        ),
        ElevatedButton(
          onPressed: () {
            if (isSelectedOnTypeAhead) {
              BlocProvider.of<SignupCubit>(context).stepSchool(universityName);
            }
          },
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.resolveWith(getColorText),
            // textcolor
            backgroundColor:
                MaterialStateProperty.resolveWith(getColor), // backcolor
          ),
          child: isSelectedOnTypeAhead ? const Text("다음으로") : const Text("선택해주세요"),
        ),
      ],
    );
  }
}

