import 'package:dart_flutter/src/datasource/dart_api_remote_datasource.dart';
import 'package:dart_flutter/src/domain/entity/university.dart';
import 'package:dart_flutter/src/domain/repository/university_repository.dart';

class DartUniversityRepositoryImpl implements UniversityRepository {
  Future<List<University>> getUniversities() async {
    return (await DartApiRemoteDataSource.getUniversities()).map((university) => university.newUniversity()).toList();
  }
}
