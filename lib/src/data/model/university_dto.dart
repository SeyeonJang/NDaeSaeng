import 'package:dart_flutter/src/domain/entity/university.dart';

class UniversityDto {
  late int id;
  late String name;
  late String department;

  UniversityDto({
    required this.id,
    required this.name,
    required this.department,
  });

  UniversityDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    department = json['department'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['department'] = this.department;
    return data;
  }

  University newUniversity() {
    return University(id: id, name: name, department: department);
  }

  @override
  String toString() {
    return 'University{id: $id, name: $name, department: $department}';
  }
}
