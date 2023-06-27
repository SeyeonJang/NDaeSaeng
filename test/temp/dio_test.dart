import 'package:dart_flutter/src/common/util/HttpUtil.dart';
import 'package:dio/dio.dart';

void main() async {
  final dio = Dio();
  final response = await dio.get('https://dart-server-aiasblaoxa-du.a.run.app/v1/health');
  print(response);

  // final dio2 = Dio();
  // dio2.options.baseUrl = 'https://dart-server-aiasblaoxa-du.a.run.app';
  // dio2.options.headers['Authorization'] = 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJrYWthb18yODE3MDU0MDM1IiwiaWQiOjEwLCJleHAiOjE2ODg3MjIzMTksInVzZXJuYW1lIjoia2FrYW9fMjgxNzA1NDAzNSJ9.lV5MXTQvM_2VRDbRy5gpbGykM5BsaqTgPI0VeVvAfmhKfEdut1TYpOdNJvUwKXF9zBZKduFxK6YLk9nz2HvGug';
  // dio2.options.headers['Accept'] = '*/*';
  // dio2.options.contentType = 'application/json';
  //
  // final response2 = await dio2.get('/v1/users/me');
  // print(response2);

  final httpUtil = HttpUtil(baseUrl: 'https://dart-server-aiasblaoxa-du.a.run.app', headers: {
    'Authorization':
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJrYWthb18yODE3MDU0MDM1IiwiaWQiOjEwLCJleHAiOjE2ODg3MjIzMTksInVzZXJuYW1lIjoia2FrYW9fMjgxNzA1NDAzNSJ9.lV5MXTQvM_2VRDbRy5gpbGykM5BsaqTgPI0VeVvAfmhKfEdut1TYpOdNJvUwKXF9zBZKduFxK6YLk9nz2HvGug',
    'Accept': '*/*',
    'contentType': 'application/json',
  });

  try {
    final response2 = await httpUtil.request().get("/v1/users/me");
    print(response2);
  } catch(dynamic) {
    print("a");
  }

  httpUtil.addHeader('Authorization', 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJrYWthb18yODE3MDU0MDM1IiwiaWQiOjEwLCJleHAiOjE2ODg3MjIzMTksInVzZXJuYW1lIjoia2FrYW9fMjgxNzA1NDAzNSJ9.lV5MXTQvM_2VRDbRy5gpbGykM5BsaqTgPI0VeVvAfmhKfEdut1TYpOdNJvUwKXF9zBZKduFxK6YLk9nz2HvGug');

  try {
    final response2 = await httpUtil.request().get("/v1/users/me");
    print(response2);
  }
  catch(dynamic) {
    print("a");
  }
}

// class _HttpUtil {
//   final dio = Dio();
//
//   _HttpUtil({required String baseUrl, Map<String, String>? headers}) {
//     dio.options.baseUrl = 'https://dart-server-aiasblaoxa-du.a.run.app';
//     if (headers != null) {
//       for (var key in headers.keys) {
//         dio.options.headers[key] = headers[key];
//       }
//     }
//   }
//
//   void addHeader(String headerName, String headerValue) {
//     dio.options.headers[headerName] = headerValue;
//   }
//
//   Dio request() {
//     return dio;
//   }
// }
