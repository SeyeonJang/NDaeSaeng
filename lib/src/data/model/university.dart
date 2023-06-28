import 'package:json_annotation/json_annotation.dart';
part 'university.g.dart';

@JsonSerializable()
class University {
  final int id;
  final String name;
  final String department;

  University({
    required this.id,
    required this.name,
    required this.department,
  });

  Map<String, dynamic> toJson() => _$UniversityToJson(this);
  static University fromJson(Map<String, dynamic> json) => _$UniversityFromJson(json);

  @override
  String toString() {
    return 'University{id: $id, name: $name, department: $department}';
  }
}


