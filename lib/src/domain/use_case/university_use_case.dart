import 'package:dart_flutter/src/data/repository/dart_univ_repository.dart';
import 'package:dart_flutter/src/domain/entity/university.dart';

class UniversityUseCase {
  final DartUniversityRepository _dartUniversityRepository = DartUniversityRepository();

  Future<List<University>> getUniversities() {
    return _dartUniversityRepository.getUniversites();
  }
}
