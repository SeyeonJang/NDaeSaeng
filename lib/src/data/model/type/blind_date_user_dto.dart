
import 'package:dart_flutter/src/domain/entity/type/blind_date_user.dart';

class BlindDateUserDto {
  int? id;
  String? name;
  String? profileImageUrl;
  String? department;

  BlindDateUserDto({this.id, this.name, this.profileImageUrl, this.department});

  BlindDateUser newBlindDateUser() {
    return BlindDateUser(
        id: id ?? 0,
        name: name ?? "(알수없음)",
        profileImageUrl: profileImageUrl ?? "DEFAULT",
        department: department ?? "(알수없음)",
    );
  }

  BlindDateUserDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    profileImageUrl = json['profileImageUrl'];
    department = json['department'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
