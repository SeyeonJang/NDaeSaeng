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
          print(
              "[HttpRequest][${DateTime.now()}]---------------------------------------------------------------\n"
                  "baseUri: ${options.baseUrl}\n"
                  "path: ${options.path}\n"
                  "data: ${options.data}\n"
                  "queryParameters: ${options.queryParameters}\n"
          );
          return handler.next(options); //continue
        },
        onResponse:(response,handler) {
          print(
              "[HttpRequest][${DateTime.now()}]---------------------------------------------------------------\n"
                  "statusCode: ${response.statusCode} ${response.statusMessage}\n"
                  "headers: ${response.headers}\n"
                  "data: ${response.data}\n"
          );
          return handler.next(response); // continue
        },
        onError: (DioError e, handler) {
          print(
              "[HttpError][${DateTime.now()}]----------------------------------------------------------------\n"
                  "message: ${e.message}\n"
                  "response: ${e.response}\n"
                  "stackTrace: ${e.stackTrace}\n"
          );
          return  handler.next(e);//continue
        }
    ));
  }

  void addHeader(String headerName, String headerValue) {
    _dio.options.headers[headerName] = headerValue;
  }

  Dio request() {
    return _dio;
  }
}
