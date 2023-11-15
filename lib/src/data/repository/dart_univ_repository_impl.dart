import 'package:dart_flutter/src/data/datasource/dart_api_remote_datasource.dart';
import 'package:dart_flutter/src/data/datasource/university_local_datasource.dart';
import 'package:dart_flutter/src/data/model/university_dto.dart';
import 'package:dart_flutter/src/domain/entity/university.dart';
import 'package:dart_flutter/src/domain/repository/university_repository.dart';
import 'package:sqflite/sqflite.dart';

class LocalUniversityRepositoryImpl implements UniversityRepository {
  @override
  Future<List<University>> getUniversities() async {
    String query = '''
      SELECT *
      FROM university 
    ''';

    return await getAllWithQuery(query);
  }

  @override
  Future<List<University>> getUniversitiesByName(String name) async {
    String query = '''
      SELECT * 
      FROM university
      WHERE university.name LIKE ? 
    ''';

    var db = await UniversityLocalDatasource.getDatabase();
    var results = await db.rawQuery(query, [name]);

    List<University> universities = [];
    for (var res in results) {
      universities.add(UniversityDto.fromJson(res).newUniversity());
    }

    return universities;
  }

  @override
  Future<List<University>> getUniversitiesDistinctName() async {
    String query = ''' 
      SELECT university.university_id, university.name
      FROM university 
      GROUP BY university.name;
    ''';

    return await getAllWithQuery(query);
  }

  Future<List<University>> getAllWithQuery(String query) async {
    var db = await UniversityLocalDatasource.getDatabase();
    var results = await db.rawQuery(query);

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
