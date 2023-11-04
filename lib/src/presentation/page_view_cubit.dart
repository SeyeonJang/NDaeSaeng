import 'package:dart_flutter/src/presentation/page_view_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class PageViewCubit extends HydratedCubit<PageViewState> {
  PageViewCubit() : super(PageViewState(popup: true, openCount: 0));

  void neverAgain() {
    state.popup = false;
    emit(state.copy());
  }

  bool getState() => state.popup;

  void addOpenAppCount() {
    state.openCount++;
    emit(state.copy());
  }
  int getOpenAppCount() => state.openCount;

  @override
  PageViewState fromJson(Map<String, dynamic> json) {
    return state.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(PageViewState state) {
    return state.toJson();
  }
}
