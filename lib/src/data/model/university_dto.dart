import 'package:dart_flutter/src/domain/entity/university.dart';

class UniversityDto {
  int? id;
  String? name;
  String? department;

  UniversityDto({
    this.id,
    this.name,
    this.department,
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
    return University(id: id ?? 0, name: name ?? 'ㅇㅇ대학교', department: department ?? 'ㅇㅇ학과');
  }

  static UniversityDto fromUniversity(University university) {
    return UniversityDto(
      id: university.id,
      name: university.name,
      department: university.department
    );
  }

  @override
  String toString() {
    return 'University{id: $id, name: $name, department: $department}';
  }
}
