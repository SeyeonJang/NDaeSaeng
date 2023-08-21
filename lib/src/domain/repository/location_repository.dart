import 'package:dart_flutter/src/domain/entity/location.dart';

abstract class LocationRepository {
  Future<List<Location>> getLocations();
}
