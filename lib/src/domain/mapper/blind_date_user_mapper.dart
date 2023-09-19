import 'package:dart_flutter/src/domain/entity/type/blind_date_user_detail.dart';
import 'package:dart_flutter/src/domain/entity/type/blind_date_user.dart';

class BlindDateUserMapper {
  static BlindDateUser toBlindDateUser(BlindDateUserDetail user) {
    return BlindDateUser(
        id: user.id,
        name: user.name,
        profileImageUrl: user.profileImageUrl,
        department: user.department
    );
  }
}