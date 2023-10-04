import 'dart:io';
import 'dart:typed_data';

import 'package:dart_flutter/src/common/util/local_database_util.dart';
import 'package:dart_flutter/src/data/model/university_dto.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class UniversityLocalDatasource {
  static const String DATABASE_NAME = 'university';
  static final Future<Database> _universityDb = LocalDatabaseUtil.open(
      '$DATABASE_NAME.db'
      // 'CREATE TABLE $DATABASE_NAME(id INTEGER PRIMARY KEY, department TEXT NOT NULL, name TEXT NOT NULL)'
  );

  static Future<Database> getDatabase() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "$DATABASE_NAME.db");
    var exists = await databaseExists(path);

    if (!exists) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}
      ByteData data = await rootBundle.load(join("assets", "dbs/$DATABASE_NAME.db"));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);
    }

    return await _universityDb;
  }
}
