import 'package:dio/dio.dart';

class HttpUtil {
  final _dio = Dio();

  HttpUtil({required String baseUrl, Map<String, String>? headers}) {
    _dio.options.baseUrl = baseUrl;
    if (headers != null) {
      for (var key in headers.keys) {
        _dio.options.headers[key] = headers[key];
      }
    }
  }

  void addHeader(String headerName, String headerValue) {
    _dio.options.headers[headerName] = headerValue;
  }

  Dio request() {
    return _dio;
  }
}
