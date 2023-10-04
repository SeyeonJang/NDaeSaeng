import 'package:dart_flutter/res/config/size_config.dart';
import 'package:dart_flutter/src/common/util/analytics_util.dart';
import 'package:dart_flutter/src/domain/entity/university.dart';
import 'package:dart_flutter/src/presentation/signup/viewmodel/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../../common/util/university_finder.dart';

class ChooseSchool extends StatefulWidget {
  const ChooseSchool({Key? key}) : super(key: key);

  @override
  State<ChooseSchool> createState() => _ChooseSchoolState();
}

class _ChooseSchoolState extends State<ChooseSchool> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: ScaffoldBody(),
        ),
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
  late bool isSelectedOnTypeAhead = false;
  String universityName = "";

  void _typeOnTypeAhead() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_typeAheadController.text.isNotEmpty) {
        setState(() {
          isSelectedOnTypeAhead = false;
        });
      }
    });
  }

  void _selectOnTypeAhead() {
    setState(() {
      isSelectedOnTypeAhead = true;
      AnalyticsUtil.logEvent("회원가입_학교_선택");
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
          SizedBox(height: SizeConfig.screenHeight * 0.15,),
        Text("학교를 선택해주세요!", style: TextStyle(fontSize: SizeConfig.defaultSize * 2.7, fontWeight: FontWeight.w700)),
          SizedBox(height: SizeConfig.defaultSize * 1.5,),
        Text("이후 변경할 수 없어요! 신중히 선택해주세요!",
            style: TextStyle(fontSize: SizeConfig.defaultSize * 1.2, color: Colors.grey)),
          SizedBox(height: SizeConfig.defaultSize * 10,),
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(SizeConfig.defaultSize * 2),
            child: TypeAheadField(
              noItemsFoundBuilder: (context) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Text(
                    "학교를 입력해주세요!",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                );
              },
              suggestionsBoxDecoration: const SuggestionsBoxDecoration( // 목록 배경색
                color: Colors.white,
                elevation: 2.0,
              ),
            // 학교 찾기
            textFieldConfiguration: TextFieldConfiguration(
                controller: _typeAheadController,
                autofocus: false, // 키보드 자동으로 올라오는 거
                style: DefaultTextStyle.of(context)
                    .style
                    .copyWith(
                    fontStyle: FontStyle.normal,
                    fontSize: getFlexibleSize(target: 15),
                    fontWeight: FontWeight.w400,
                    color: isSelectedOnTypeAhead ? const Color(0xff7C83FD) : Colors.black),
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade200,
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                      color: Color(0xff7C83FD),
                      width: 2.0,
                      ),
                    ),
                    prefixIcon: const Icon(Icons.school_rounded, color: Color(0xff7C83FD),),
                    hintText: "학교 이름")),

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
                  leading: const Icon(Icons.school),
                  title: Text(suggestion['name']),
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
          SizedBox(height: SizeConfig.defaultSize * 10,),
        SizedBox(
          width: SizeConfig.screenWidth * 0.9,
          height: SizeConfig.defaultSize * 5,
          child: isSelectedOnTypeAhead
              ? ElevatedButton(
                onPressed: () {
                  AnalyticsUtil.logEvent("회원가입_학교_다음");
                  if (isSelectedOnTypeAhead) {BlocProvider.of<SignupCubit>(context).stepSchool(universityName);}
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff7C83FD),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), // 모서리 둥글기 설정
                  ),
                ),
                child: Text("다음으로", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.7, fontWeight: FontWeight.w600, color: Colors.white),)
                )
              : ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200],
                ),
                child: Text("학교를 선택해주세요", style: TextStyle(fontSize: SizeConfig.defaultSize * 1.7, fontWeight: FontWeight.w600, color: Colors.black38),)
              ),
        )
      ],
    );
  }
}