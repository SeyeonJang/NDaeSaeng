import 'dart:io';

abstract interface class GhostRepository {
  Future<String> uploadProfileImage(String userId, String name, File file);
  Future<void> removeProfileImage(String userId, String name);
  String getProfileImageUrl(String userId, String name);
}
