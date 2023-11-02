class Option {
  final int _id;
  final String _name;
  final double _percent;

  Option({
    required int id,
    required String name,
    required double percent
  }) : _percent = percent, _name = name, _id = id;

  factory Option.fromJson(Map<String, dynamic> json) {
    final int parsedId = json['id'];
    final String parsedName = json['name'];
    final double parsedPercent = json['percent'];

    return Option(
      id: parsedId,
      name: parsedName,
      percent: parsedPercent
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = _id;
    data['name'] = _name;
    data['percent'] = _percent;
    return data;
  }

  @override
  String toString() {
    return 'Option{id: $_id, name: $_name, percent: $_percent}';
  }
}