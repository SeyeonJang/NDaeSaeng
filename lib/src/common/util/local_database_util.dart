
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabaseUtil {
  static Future<Database> openWithCreateQuery(String dbPath, String createQuery) async {
    return await openDatabase(
      join(await getDatabasesPath(), dbPath),
      onCreate: (db, version) async {
// Department table
        await db.execute(
          createQuery,
        );
      },
      version: 1,
    );
  }

  static Future<Database> open(String dbPath) async {
    return await openDatabase(
      join(await getDatabasesPath(), dbPath),
      version: 1,
    );
  }
}
