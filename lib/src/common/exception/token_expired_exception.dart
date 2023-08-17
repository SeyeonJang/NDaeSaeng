import 'package:dart_flutter/src/common/exception/authroization_exception.dart';

class TokenExpiredException extends AuthorizationException {
  TokenExpiredException(super.cause);
}
