import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class UniversityLocalDatasource {
  static const String DATABASE_NAME = 'university';
  static const int DATABASE_VERSION = 20231031; // 데이터베이스 버전 설정

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
    } else {
      // 데이터베이스가 이미 존재하면 현재 버전과 비교
      var db = await openDatabase(path);
      int currentVersion = await db.getVersion();

      if (currentVersion < DATABASE_VERSION) {
        // 업데이트 필요한 경우 업데이트 로직 실행
        await _updateDatabase(db, currentVersion, DATABASE_VERSION);
      }
    }

    return await openDatabase(path, version: DATABASE_VERSION);
  }

  static Future<void> _updateDatabase(Database db, int oldVersion, int newVersion) async {
    // 업데이트 로직을 작성합니다.
    // 새로운 데이터베이스 파일을 assets에서 불러옵니다.
    ByteData data = await rootBundle.load(join("assets", "dbs/$DATABASE_NAME.db"));
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    // 데이터베이스 파일 경로를 가져옵니다.
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "$DATABASE_NAME.db");

    // 기존 데이터베이스 파일을 백업하고 새 파일로 대체합니다.
    if (await File(path).exists()) {
      // 기존 데이터베이스 파일이 존재하면 백업
      var backupPath = "$path.backup";
      await File(path).copy(backupPath);
    }

    // 새로운 데이터베이스 파일로 대체
    await File(path).writeAsBytes(bytes, flush: true);

    // 업데이트 완료 후 현재 버전 갱신
    await db.setVersion(newVersion);
  }
}
