import 'package:dart_flutter/src/data/datasource/dart_api_remote_datasource.dart';
import 'package:dart_flutter/src/data/datasource/university_local_datasource.dart';
import 'package:dart_flutter/src/data/model/university_dto.dart';
import 'package:dart_flutter/src/domain/entity/university.dart';
import 'package:dart_flutter/src/domain/repository/university_repository.dart';
import 'package:sqflite/sqflite.dart';

class DartUniversityRepositoryImpl implements UniversityRepository {
  Future<List<University>> getUniversities() async { // TODO
    var db = await UniversityLocalDatasource.getDatabase();
    var results = await db.rawQuery('''
      SELECT *
      FROM university 
      LIMIT 10
    ''');

    List<University> universities = [];
    for (var res in results) {
      universities.add(UniversityDto.fromJson(res).newUniversity());
    }

    return universities;
  }

  @override
  Future<void> deleteAll() {
    throw Error();
  }

  @override
  Future<University> getUniversityById(int id) async {
    var db = await UniversityLocalDatasource.getDatabase();
    var result = await db.query('university', where: 'id = ?', whereArgs: [id]);

    if (result.isNotEmpty) {
      return UniversityDto.fromJson(result.first).newUniversity();
    } else {
      throw Exception('No university found with ID $id');
    }
  }

  @override
  Future<void> insert(University university) async {
    (await UniversityLocalDatasource.getDatabase()).insert(
        'university', UniversityDto.fromUniversity(university).toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
