import 'package:dart_flutter/src/data/model/university.dart';
import 'package:dart_flutter/src/datasource/dart_api_remote_datasource.dart';

class DartUniversityRepository {
  Future<List<University>> getUniversitys() async {
    return await DartApiRemoteDataSource.getUniversities();
  }
}
