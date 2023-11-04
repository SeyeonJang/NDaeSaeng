import 'package:dart_flutter/src/common/pagination/pagination.dart';
import 'package:dart_flutter/src/domain/entity/comment.dart';
import 'package:dart_flutter/src/domain/entity/option.dart';
import 'package:dart_flutter/src/domain/entity/personal_info.dart';
import 'package:dart_flutter/src/domain/entity/survey.dart';
import 'package:dart_flutter/src/domain/entity/type/IdCardVerificationStatus.dart';
import 'package:dart_flutter/src/domain/entity/university.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';

class FeedUseCase {
  Survey dummySurvey = Survey(
      id: 0,
      question: '여사친에게 겉옷 빌려주는 행동 플러팅일까?',
      options: [Option(id: 1, name: '그렇다', percent: 54.3), Option(id: 2, name: '아니다', percent: 45.7)],
      picked: false,
      pickedOption: 1
  );

  Survey getSurvey() { // 오늘의 질문 get
    return dummySurvey;
  }

  void pickOption() { // 오늘의 질문 선택 post
    dummySurvey = Survey(
        id: 0,
        question: '여사친에게 겉옷 빌려주는 행동 플러팅일까?',
        options: [Option(id: 1, name: '그렇다', percent: 54.3), Option(id: 2, name: '아니다', percent: 45.7)],
        picked: true,
        pickedOption: 1
    );
  }
}