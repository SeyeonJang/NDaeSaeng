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
}