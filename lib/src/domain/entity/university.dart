class University {
  late int id;
  late String name;
  late String department;

  University({
    required this.id,
    required this.name,
    required this.department,
  });

  University.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    department = json['department'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['department'] = department;
    return data;
  }

  @override
  String toString() {
    return 'University{id: $id, name: $name, department: $department}';
  }
}
