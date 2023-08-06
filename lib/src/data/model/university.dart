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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['department'] = this.department;
    return data;
  }

  @override
  String toString() {
    return 'University{id: $id, name: $name, department: $department}';
  }
}
