import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseRemoteDatasource {
  static final _supabase = Supabase.instance.client;

  static Future<String> uploadFileToStorage(String dbName, String path, File file) {
    return _supabase.storage.from(dbName).upload(path, file);
  }

  static String getFileUrl(String dbName, String filePath) {
    return _supabase.storage.from(dbName).getPublicUrl(filePath);
  }

  static Future<List<FileObject>> removeFile(String dbName, String filePath) {
    return _supabase.storage.from(dbName).remove([filePath]);
  }
}
