import 'package:dart_flutter/src/common/exception/custom_exception.dart';

class StompAuthorizationException extends CustomException {
  StompAuthorizationException(super.cause);
}