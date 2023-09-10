
class BlindDateUser {
  final int id;
  final String name;
  final String profileImageUrl;
  final String department;

  BlindDateUser({required this.id, required this.name, required this.profileImageUrl, required this.department});

  factory BlindDateUser.fromJson(Map<String, dynamic> json) {
    final int parsedId = json['id'];
    final String parsedName = json['name'];
    final String parsedProfileImageUrl = json['profileImageUrl'];
    final String parsedDepartment = json['department'];

    return BlindDateUser(
      id: parsedId,
      name: parsedName,
      profileImageUrl: parsedProfileImageUrl,
      department: parsedDepartment,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['profileImageUrl'] = profileImageUrl;
    data['department'] = department;
    return data;
  }

  @override
  String toString() {
    return 'BlindDateUser{id: $id, name: $name, profileImageUrl: $profileImageUrl, department: $department}';
  }
}
