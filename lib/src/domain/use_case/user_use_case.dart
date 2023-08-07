import 'package:dart_flutter/src/data/repository/dart_user_repository.dart';
import 'package:dart_flutter/src/domain/entity/user_request.dart';
import 'package:dart_flutter/src/domain/entity/user_response.dart';

class UserUseCase {
  final DartUserRepository _dartUserRepository = DartUserRepository();

  Future<UserResponse> myInfo() {
    return _dartUserRepository.myInfo();
  }

  Future<UserResponse> signup(UserRequest user) {
    return _dartUserRepository.signup(user);
  }

  void withdrawal() {
    _dartUserRepository.drawal();
  }

  void logout() {
    _dartUserRepository.logout();
  }

  void cleanUpUserResponseCache() {
    _dartUserRepository.cleanUpUserResponseCache();
  }
}
