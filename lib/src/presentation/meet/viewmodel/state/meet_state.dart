import 'package:dart_flutter/src/data/model/friend_dto.dart';
import 'package:dart_flutter/src/data/model/personal_info_dto.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class MeetState {
  late MeetStateEnum meetPageState;

  MeetState ({
    required this.meetPageState,
  });

  MeetState.init() { // 초기값 설정
    meetPageState = MeetStateEnum.landing;
  }

  MeetState copy() => MeetState(
    meetPageState: meetPageState,
  );

  @override
  String toString() { // toString은 디버깅(개발)에만 사용
    return 'MeetState{meetPageState: $meetPageState}';
  }
}

enum MeetStateEnum {
  landing,
  twoPeople,
  threePeople,
  twoPeopleDone,
  threePeopleDone;

  bool get isMeetLanding => this == MeetStateEnum.landing;
  bool get isTwoPeople => this == MeetStateEnum.twoPeople;
  bool get isThreePeople => this == MeetStateEnum.threePeople;
  bool get isTwoPeopleDone => this == MeetStateEnum.twoPeopleDone;
  bool get isThreePeopleDone => this == MeetStateEnum.threePeopleDone;
}