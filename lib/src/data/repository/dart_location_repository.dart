import 'package:dart_flutter/src/data/datasource/dart_api_remote_datasource.dart';
import 'package:dart_flutter/src/domain/entity/location.dart';
import 'package:dart_flutter/src/domain/repository/location_repository.dart';

import '../model/type/team_region.dart';

class DartLocationRepository implements LocationRepository {
  @override
  Future<List<Location>> getLocations() async {
    List<TeamRegion> locations = await DartApiRemoteDataSource.getLocations();
    return locations.map((e) => e.newLocation()).toList();
  }
}
