import 'package:dart_flutter/src/data/repository/dart_location_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_information.dart';

void main() {
  DartLocationRepository repository = DartLocationRepository();
  setUpAll(() =>
      TestInformation.dartInit()
  );

  test('지역 목록 가져오기', () async {
    List<dynamic> result = await repository.getLocations();
    expect(result, isNotNull);
    print(result.toString());
  });
}
