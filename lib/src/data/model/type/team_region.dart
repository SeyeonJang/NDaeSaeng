import 'package:dart_flutter/src/domain/entity/location.dart';

class TeamRegion {
  int? id;
  String? name;

  TeamRegion({this.id, this.name});

  static TeamRegion fromLocation(Location location) {
    return TeamRegion(id: location.id, name: location.name);
  }

  Location newLocation() {
    return Location(id: id ?? 0, name: name ?? "(알수없음)");
  }

  TeamRegion.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
