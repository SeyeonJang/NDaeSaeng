import 'package:dart_flutter/src/data/model/sns_request.dart';
import 'package:dart_flutter/src/data/model/university.dart';
import 'package:dart_flutter/src/datasource/dart_api_remote_datasource.dart';

import '../model/dart_auth.dart';

class DartUniversityRepository {
  Future<List<University>> getUniversitys() async {
    // TODO 실제 데이터를 받아오는 코드로 고치기
    final List<University> universitys = [];

    universitys.add(University(id: 1, name: "인하대학교", department: "컴퓨터공학"));
    universitys.add(University(id: 2, name: "인하대학교", department: "컴퓨터예술"));
    universitys.add(University(id: 3, name: "인하대학교", department: "컴퓨터축구"));

    universitys.add(University(id: 4, name: "가톨릭대학교", department: "전자"));
    universitys.add(University(id: 5, name: "가톨릭대학교", department: "전기"));
    universitys.add(University(id: 6, name: "가톨릭대학교", department: "기계"));

    universitys.add(University(id: 7, name: "경북대학교", department: "시각디자인"));
    universitys.add(University(id: 8, name: "경북대학교", department: "건축디자인"));
    universitys.add(University(id: 9, name: "경북대학교", department: "산업디자인"));

    return universitys;
  }
}
