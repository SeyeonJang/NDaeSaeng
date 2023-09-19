import 'package:dart_flutter/src/domain/entity/university.dart';

abstract class UniversityRepository {
  Future<List<University>> getUniversities();
  Future<void> deleteAll();
  Future<void> insert(University university);
  Future<University> getUniversityById(int id);
}
