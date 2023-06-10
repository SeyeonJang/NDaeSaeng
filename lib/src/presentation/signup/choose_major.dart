import 'package:dart_flutter/src/presentation/signup/choose_id.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
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
    );
  }
}
class ScaffoldBody extends StatelessWidget {
  const ScaffoldBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 100,
        ),
        const Text("학과 선택", style: TextStyle(fontSize: 25)),
        const SizedBox( height: 40, ),
        const Text("이후 변경할 수 없어요! 신중히 선택해주세요!", style: TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox( height: 100, ),

        SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(18.0),
              child : TypeAheadField( // 학교 찾기
                textFieldConfiguration: TextFieldConfiguration(
                    autofocus: true, // 키보드 자동으로 올라오는 거
                    style: DefaultTextStyle.of(context).style.copyWith(
                        fontStyle: FontStyle.italic
                    ),
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "학과명을 입력해주세요"
                    )
                ),

                suggestionsCallback: (pattern) async { // 실제 검색 로직 구현
                  // 입력된 패턴에 기반하여 검색 결과를 반환
                  return await BackendService.getSuggestions(pattern);
                },

                itemBuilder: (context, suggestion) {
                  return ListTile(
                    // leading: Icon(Icons.shopping_cart),
                    title: Text(suggestion['name']),
                    // subtitle: Text('\$${suggestion['price']}'),
                  );
                },

                // 추천 text를 눌렀을 때 일어나는 액션 (밑의 코드는 ProductPage로 넘어감)
                onSuggestionSelected: (suggestion) {

                  // 추천된 항목이 선택되었을 때의 동작
                  // 터치했을 때 textfield에 글씨가 들어가도록 하는 로직 필요

                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => ProductPage(product: suggestion)
                  // ));
                },
              ),
            )
        ),

        const SizedBox( height: 100, ),
        ElevatedButton( // 버튼
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChooseId())),
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

class BackendService {
  static Future<List<Map<String, dynamic>>> getSuggestions(String query) async {
    await Future.delayed(Duration(seconds: 1));

    List<Map<String, dynamic>> matches = [];

    List<String> cities = CitiesService.getSuggestions(query).cast<String>();
    for (String city in cities) {
      matches.add({
        'name': city,
      });
    }

    return matches;
  }
}

class CitiesService {
  static final List<String> cities = [
    'Beirut',
    'Damascus',
    'San Fransisco',
    'Rome',
    'Los Angeles',
    'Madrid',
    'Bali',
    'Barcelona',
    'Paris',
    'Bucharest',
    'New York City',
    'Philadelphia',
    'Sydney',
  ];

  static List<String> getSuggestions(String query) {
    List<String> matches = [];

    for (String city in cities) {
      if (city.toLowerCase().contains(query.toLowerCase())) {
        matches.add(city);
      }
    }
    return matches;
  }
}