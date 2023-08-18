import 'package:dart_flutter/src/data/datasource/dart_api_remote_datasource.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_information.dart';

void main() async {
  TestInformation.dartInit();

  test('내 정보 가져오기', () async {
    var response = await DartApiRemoteDataSource.getMyInformation();
    expect(response, isNotNull);
    print(response);
  });
}
