class Location {
  final int id;
  final String name;

  @override
  String toString() {
    return 'Location{id: $id, name: $name}';
  }

  Location({
    required this.id,
    required this.name,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    final tId = json['id'];
    final tName = json['name'];
    return Location(id: tId, name: tName);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}