import 'package:dart_flutter/src/presentation/meet/viewmodel/state/meet_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MeetCubit extends Cubit<MeetState> {
  MeetCubit() : super(MeetState.init());

  void initState() async {
    emit(state.copy());
  }

}