import 'package:dart_flutter/src/domain/entity/university.dart';

abstract class UniversityRepository {
  Future<List<University>> getUniversities();
}
