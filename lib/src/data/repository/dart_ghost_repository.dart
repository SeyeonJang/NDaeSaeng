import 'dart:io';

import 'package:dart_flutter/src/data/datasource/supabase_remote_datasource.dart';
import 'package:dart_flutter/src/domain/repository/ghost_repository.dart';

class DartGhostRepository implements GhostRepository {
  static const String SINGLE_TEAM_STORAGE_NAME = "single_team";

  @override
  String getProfileImageUrl(String userId, String name) {
    return SupabaseRemoteDatasource.getFileUrl(SINGLE_TEAM_STORAGE_NAME, "$userId/$name");
  }

  @override
  Future<void> removeProfileImage(String userId, String name) async {
    await SupabaseRemoteDatasource.removeFile(SINGLE_TEAM_STORAGE_NAME, "$userId/$name");
  }

  @override
  Future<String> uploadProfileImage(String userId, String name, File file) async {
    await SupabaseRemoteDatasource.uploadFileToStorage(SINGLE_TEAM_STORAGE_NAME, "$userId/$name", file);
    await Future.delayed(const Duration(seconds: 1));

    return getProfileImageUrl(userId, name);
  }

}