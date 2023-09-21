import 'package:dart_flutter/src/domain/entity/university.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';

void main() async {
  final database = openDatabase(
    join(await getDatabasesPath(), 'doggie_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE univeristy(id INTEGER PRIMARY KEY, name TEXT, department TEXT)',
      );
    },
    version: 1,
  );

  // 데이터 삽입
  (await database).insert(
    'university',
    {"id": 1, "name": "인하대", "department": "가가가과"},
    conflictAlgorithm: ConflictAlgorithm.replace
  );

  // 조회 및 데이터 맵핑
  final List<Map<String, dynamic>> maps = await (await database).query('university');
  var list = List.generate(maps.length, (i) {
    return University(
      id: maps[i]['id'],
      name: maps[i]['name'],
      department: maps[i]['department']
    );
  });

  print(list.toString());
}
