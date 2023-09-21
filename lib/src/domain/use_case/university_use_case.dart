import 'package:dart_flutter/src/data/repository/dart_univ_repository_impl.dart';
import 'package:dart_flutter/src/domain/entity/university.dart';
import 'package:dart_flutter/src/domain/repository/university_repository.dart';

class UniversityUseCase {
  final UniversityRepository _dartUniversityRepository = DartUniversityRepositoryImpl();

  Future<List<University>> getUniversities() {
    return _dartUniversityRepository.getUniversities();
  }

  Future<List<University>> getUniversityByName(String name) {
    return _dartUniversityRepository.getUniversitiesByName(name);
  }
}
