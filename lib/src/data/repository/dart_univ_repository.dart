import 'package:dart_flutter/src/datasource/dart_api_remote_datasource.dart';
import 'package:dart_flutter/src/domain/entity/university.dart';

class DartUniversityRepository {
  Future<List<University>> getUniversitys() async {
    return (await DartApiRemoteDataSource.getUniversities()).map((university) => university.newUniversity()).toList();
  }
}
