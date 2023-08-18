import 'package:dart_flutter/src/common/exception/server_error_exception.dart';

class ServiceNotReadyException extends ServerErrorException {
  ServiceNotReadyException(super.cause);
}
