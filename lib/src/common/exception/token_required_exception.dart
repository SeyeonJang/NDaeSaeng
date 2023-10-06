import 'package:dart_flutter/src/common/exception/authroization_exception.dart';

class TokenRequiredException extends AuthorizationException {
  TokenRequiredException(super.cause);
}
