import 'package:dart_flutter/src/common/exception/custom_exception.dart';

class ServerErrorException extends CustomException {
  ServerErrorException(super.cause);
}
