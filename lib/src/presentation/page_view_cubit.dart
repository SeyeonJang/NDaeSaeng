import 'package:dart_flutter/src/domain/entity/user.dart';
import 'package:dart_flutter/src/domain/use_case/user_use_case.dart';
import 'package:dart_flutter/src/presentation/page_view_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class PageViewCubit extends HydratedCubit<PageViewState> {
  var _userUseCase = UserUseCase();

  PageViewCubit() : super(PageViewState(myInfo: User(titleVotes: []), showPopup: true, openCount: 0));

  void fetchMyInformation() async {
    var myInfo = await _userUseCase.myInfo();
    state.myInfo = myInfo;
    emit(state.copy());
  }

  void neverAgain() {
    state.showPopup = false;
    emit(state.copy());
  }

  bool getPopup() => state.showPopup;

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
