import 'package:dart_flutter/src/domain/entity/type/blind_date_user.dart';
import 'package:dart_flutter/src/domain/entity/type/blind_date_user_detail.dart';

import '../entity/type/student.dart';

class StudentMapper {
  static BlindDateUser toBlindDateUser(Student student) {
    return BlindDateUser(
        id: student.getId(),
        name: student.getName(),
        profileImageUrl: student.getProfileImageUrl(),
        department: student.getDepartment()
    );
  }

  static BlindDateUserDetail toBlindDateUserDetail(Student student) {
    return BlindDateUserDetail(
        id: student.getId(),
        name: student.getName(),
        profileImageUrl: student.getProfileImageUrl(),
        department: student.getDepartment(),
        isCertifiedUser: student.getIsCertifiedUser(),
        birthYear: student.getBirthYear(),
        profileQuestionResponses: student.getTitleVotes()
    );
  }
}
