import 'package:dart_flutter/src/common/exception/server_error.dart';

class ServiceNotReadyException extends ServerError {
  ServiceNotReadyException(super.cause);
}
