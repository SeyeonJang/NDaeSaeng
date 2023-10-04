import 'package:dart_flutter/src/domain/entity/user.dart';
import 'package:dart_flutter/src/domain/entity/type/blind_date_user.dart';

@Deprecated("StudnetMapper로 대체")
class MeetUserMapper {
  static BlindDateUser toBlindDateUser(User user) {
    return BlindDateUser(
        id: user.personalInfo?.id ?? 0,
        name: user.personalInfo?.name ?? '(알수없음)',
        profileImageUrl: user.personalInfo?.profileImageUrl ?? 'DEFAULT',
        department: user.university?.department ?? '(알수없음)');
  }
}