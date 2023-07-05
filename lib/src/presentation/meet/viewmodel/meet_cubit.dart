import 'package:dart_flutter/src/presentation/meet/viewmodel/state/meet_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MeetCubit extends Cubit<MeetState> {
  MeetCubit() : super(MeetState.init());

  void initState() async {
    print(state);
    emit(state.copy());
    state.meetPageState = MeetStateEnum.landing;
  }

  void stepMeetLanding() {
    state.meetPageState = MeetStateEnum.landing;
    emit(state.copy());
    print(state.toString());
  }

  void stepTwoPeople() {
    state.meetPageState = MeetStateEnum.twoPeople;
    emit(state.copy());
    print(state.toString());
  }

  void stepThreePeople() {
    state.meetPageState = MeetStateEnum.threePeople;
    emit(state.copy());
    print(state.toString());
  }

  void stepTwoPeopleDone() {
    state.meetPageState = MeetStateEnum.twoPeopleDone;
    emit(state.copy());
    print(state.toString());
  }

  void stepThreePeopleDone() {
    state.meetPageState = MeetStateEnum.threePeopleDone;
    emit(state.copy());
    print(state.toString());
  }

}