import 'package:dart_flutter/src/common/exception/custom_exception.dart';

class StompException extends CustomException {
  StompException(super.cause);
}
