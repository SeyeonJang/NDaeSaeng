import 'package:dart_flutter/src/common/exception/custom_exception.dart';

class ServerError extends CustomException {
  ServerError(super.cause);
}
