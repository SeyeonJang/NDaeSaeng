import 'package:dart_flutter/src/common/exception/stomp_exception.dart';

class StompConnectionException extends StompException {
  StompConnectionException(String cause) : super(cause);
}
