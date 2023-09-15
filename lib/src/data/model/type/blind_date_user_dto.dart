
class BlindDateUserDto {
  int? id;
  String? name;
  String? profileImageUrl;
  String? department;

  BlindDateUserDto({this.id, this.name, this.profileImageUrl, this.department});

  BlindDateUserDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    profileImageUrl = json['profileImageUrl'];
    department = json['department'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['profileImageUrl'] = this.profileImageUrl;
    data['department'] = this.department;
    return data;
  }

  @override
  String toString() {
    return 'BlindDateUser{id: $id, name: $name, profileImageUrl: $profileImageUrl, department: $department}';
  }
}
