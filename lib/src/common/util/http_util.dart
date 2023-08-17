import 'package:dart_flutter/src/common/exception/custom_exception.dart';
import 'package:dart_flutter/src/common/exception/token_expired_exception.dart';
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

    _dio.interceptors.add(InterceptorsWrapper(
        onRequest:(options, handler){
          _printHttpRequest(options);
          return handler.next(options); //continue
        },
        onResponse:(response, handler) {
          _printHttpResponse(response);
          return handler.next(response); // continue
        },
        onError: (DioError e, handler) {
          _printHttpError(e);
          if (e.response == null)
            return handler.next(e);//continue

          int? statusCode = e.response?.statusCode;
          switch(statusCode) {
            case 401:
              throw TokenExpiredException("토큰이 만료되었습니다.");
            case 500:
              throw CustomException("InternalServerError");
            default:
              break;
          }
          return handler.next(e);//continue
        }
    ));
  }

  void addHeader(String headerName, String headerValue) {
    _dio.options.headers[headerName] = headerValue;
  }

  Dio request() {
    return _dio;
  }

  void _printHttpError(DioError e) {
    return print(
          "[HttpError][${DateTime.now()}]----------------------------------------------------------------\n"
              "message: ${e.message}\n"
              "response: ${e.response}\n"
              "stackTrace: ${e.stackTrace}\n"
        );
  }

  void _printHttpResponse(Response<dynamic> response) {
    print(
        "[HttpResponse][${DateTime.now()}]--------------------------------------------------------------\n"
            "statusCode: ${response.statusCode} ${response.statusMessage}\n"
            "headers: ${response.headers}\n"
            "data: ${response.data}\n"
    );
  }

  void _printHttpRequest(RequestOptions options) {
    print(
        "[HttpRequest][${DateTime.now()}]---------------------------------------------------------------\n"
            "baseUri: ${options.baseUrl}\n"
            "path: ${options.path}\n"
            "data: ${options.data}\n"
            "queryParameters: ${options.queryParameters}\n"
    );
  }
}
