import 'package:dart_flutter/src/data/model/university_dto.dart';

void main() {
  List<String> school = [
    '서울대학교',
    '인천대학교',
    '대구대학교',
    '부산대학교',
    '광주대학교',
    '경북대학교',
    '인하대학교',
  ];

  List<UniversityDto> universitys = [
    UniversityDto(id: 1, name: "서울대학교", department: "빡빡이학과"),
    UniversityDto(id: 2, name: "서울대학교", department: "감자튀김학과"),
    UniversityDto(id: 3, name: "인천대학교", department: "컴퓨터공학과"),
    UniversityDto(id: 4, name: "한양대학교", department: "전자공학과"),
    UniversityDto(id: 5, name: "고려대학교", department: "경제학과"),
    UniversityDto(id: 6, name: "성균관대학교", department: "사회학과"),
    UniversityDto(id: 7, name: "서강대학교", department: "심리학과"),
    UniversityDto(id: 8, name: "중앙대학교", department: "화학공학과"),
    UniversityDto(id: 9, name: "경희대학교", department: "의류학과"),
    UniversityDto(id: 10, name: "서울시립대학교", department: "신문방송학과"),
    UniversityDto(id: 11, name: "부산대학교", department: "기계공학과"),
    UniversityDto(id: 12, name: "대구대학교", department: "건축학과"),
    UniversityDto(id: 13, name: "광주과학기술원", department: "신소재공학과"),
    UniversityDto(id: 14, name: "경북대학교", department: "식품영양학과"),
    UniversityDto(id: 15, name: "경남대학교", department: "물리학과"),
    UniversityDto(id: 16, name: "전남대학교", department: "체육학과"),
    UniversityDto(id: 17, name: "제주대학교", department: "생명과학과"),
    UniversityDto(id: 18, name: "울산대학교", department: "지리학과"),
    UniversityDto(id: 19, name: "한국교원대학교", department: "음악학과"),
    UniversityDto(id: 20, name: "한국체육대학교", department: "체육학과"),
    UniversityDto(id: 21, name: "서울과학기술대학교", department: "전기공학과"),
    UniversityDto(id: 22, name: "성신여자대학교", department: "법학과"),
    UniversityDto(id: 23, name: "중앙승가대학교", department: "심리학과"),
    UniversityDto(id: 24, name: "서울사이버대학교", department: "경영학과"),
    UniversityDto(id: 25, name: "한양사이버대학교", department: "디자인학과"),
    UniversityDto(id: 26, name: "세종대학교", department: "행정학과"),
    UniversityDto(id: 27, name: "강릉원주대학교", department: "법학과"),
    UniversityDto(id: 28, name: "충남대학교", department: "화학과"),
    UniversityDto(id: 29, name: "전북대학교", department: "물리학과"),
    UniversityDto(id: 30, name: "경상대학교", department: "영어영문학과"),
    UniversityDto(id: 31, name: "경성대학교", department: "국어국문학과"),
    UniversityDto(id: 32, name: "전주대학교", department: "사회복지학과"),
    UniversityDto(id: 33, name: "한국방송통신대학교", department: "문화콘텐츠학과"),
    UniversityDto(id: 34, name: "서울교육대학교", department: "윤리교육과"),
    UniversityDto(id: 35, name: "광주교육대학교", department: "국어교육과"),
    UniversityDto(id: 36, name: "경북도립대학교", department: "영어교육과"),
    UniversityDto(id: 37, name: "대전교육대학교", department: "수학교육과"),
    UniversityDto(id: 38, name: "부산교육대학교", department: "사회과학교육과"),
    UniversityDto(id: 39, name: "강원도립대학교", department: "지리교육과"),
    UniversityDto(id: 40, name: "충남교육대학교", department: "과학교육과"),
    UniversityDto(id: 41, name: "전남도립대학교", department: "체육교육과"),
    UniversityDto(id: 42, name: "경남도립대학교", department: "음악교육과"),
    UniversityDto(id: 43, name: "제주교육대학교", department: "영어교육과"),
    UniversityDto(id: 44, name: "세종교육대학교", department: "윤리교육과"),
    UniversityDto(id: 45, name: "한국예술종합학교", department: "연극학과"),
    UniversityDto(id: 46, name: "국립한국방송통신대학교", department: "국어교육과"),
    UniversityDto(id: 47, name: "충북도립대학교", department: "수학교육과"),
    UniversityDto(id: 48, name: "경기도립대학교", department: "영어교육과"),
    UniversityDto(id: 49, name: "강원교육대학교", department: "음악교육과"),
    UniversityDto(id: 50, name: "경기교육대학교", department: "체육교육과"),
  ];

  _UniversityFinder citiesService = _UniversityFinder(
    universitys: universitys,
  );

  print(citiesService.getNameSuggestions("인").toString());
  print(citiesService.getNameSuggestions("서").toString());
  print(citiesService.getNameSuggestions("강").toString());
  print(citiesService.getNameSuggestions("국").toString());
}

class _UniversityFinder {
  final List<UniversityDto> universitys;

  _UniversityFinder({
    required this.universitys,
  });

  List<String> getNameSuggestions(String query) {
    List<String> matches = [];

    for (var university in universitys) {
      if (university.name.contains(query)) {
        matches.add(university.name);
      }
    }
    return matches;
  }
}
