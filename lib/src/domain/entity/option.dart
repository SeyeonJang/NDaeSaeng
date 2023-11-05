class Option {
  final int id;
  final String name;
  final int headCount;

  Option({
    required this.id,
    required this.name,
    required this.headCount
    });

  factory Option.fromJson(Map<String, dynamic> json) {
    final int parsedId = json['id'];
    final String parsedName = json['name'];
    final int parsedHeadCount = json['headCount'];

    return Option(
      id: parsedId,
      name: parsedName,
      headCount: parsedHeadCount
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['headCount'] = headCount;
    return data;
  }

  @override
  String toString() {
    return 'Option{id: $id, name: $name, percent: $headCount}';
  }
}