import 'package:dart_flutter/src/data/model/friend.dart';
import 'package:dart_flutter/src/data/model/user.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class MeetState {
  late MeetStateEnum meetPageState;

  MeetState ({
    required this.meetPageState,
  });

  MeetState.init() {
    meetPageState = MeetStateEnum.landing;
  }

  MeetState copy() => MeetState(
    meetPageState: meetPageState,
  );
}

enum MeetStateEnum {
  landing ,
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