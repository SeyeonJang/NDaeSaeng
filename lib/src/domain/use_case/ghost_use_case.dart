import 'dart:io';

import 'package:dart_flutter/src/common/util/image_util.dart';
import 'package:dart_flutter/src/data/repository/dart_ghost_repository.dart';
import 'package:dart_flutter/src/domain/repository/ghost_repository.dart';

class GhostUseCase {
  final GhostRepository _ghostRepository = DartGhostRepository();

  String getProfileImageUrl(String userId, String name) {
    return _ghostRepository.getProfileImageUrl(userId, name);
  }

  Future<String> uploadProfileImage(String userId, String name, File file) async {
    file = await ImageUtil.compressImage(file);

    await _ghostRepository.removeProfileImage(userId, name);
    return await _ghostRepository.uploadProfileImage(userId, name, file);
  }

  Future<void> removeProfileImage(String userId, String name) async {
    await _ghostRepository.removeProfileImage(userId, name);
  }
}
