import 'package:dart_flutter/src/data/repository/dart_user_repository_impl.dart';
import 'package:dart_flutter/src/domain/entity/user_request.dart';
import 'package:dart_flutter/src/domain/entity/user_response.dart';
import 'package:dart_flutter/src/domain/repository/user_repository.dart';

class UserUseCase {
  final UserRepository _dartUserRepository = DartUserRepositoryImpl();

  Future<UserResponse> myInfo() {
    return _dartUserRepository.myInfo();
  }

  Future<UserResponse> signup(UserRequest user) {
    return _dartUserRepository.signup(user);
  }

  void withdrawal() {
    _dartUserRepository.withdrawal();
  }

  void logout() {
    _dartUserRepository.logout();
  }

  void cleanUpUserResponseCache() {
    _dartUserRepository.cleanUpUserResponseCache();
  }
}
