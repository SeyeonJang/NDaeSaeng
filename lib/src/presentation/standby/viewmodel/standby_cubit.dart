import 'package:dart_flutter/src/domain/entity/user.dart';
import 'package:dart_flutter/src/domain/use_case/friend_use_case.dart';
import 'package:dart_flutter/src/domain/use_case/user_use_case.dart';
import 'package:dart_flutter/src/presentation/standby/viewmodel/state/standby_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class StandbyCubit extends Cubit<StandbyState> {
  static final UserUseCase _userUseCase = UserUseCase();
  static final FriendUseCase _friendUseCase = FriendUseCase();

  StandbyCubit() : super(StandbyState.init());

  void initPages() async {
    state.isLoading = true;
    emit(state.copy());

    List<User> friends = await _friendUseCase.getMyFriends();
    state.setAddedFriends(friends);
    List<User> newFriends = await _friendUseCase.getRecommendedFriends();
    state.setRecommendedFriends(newFriends);
    _userUseCase.cleanUpUserResponseCache();
    state.userResponse = await _userUseCase.myInfo();

    state.userResponse.personalInfo!.recommendationCode;
    state.isLoading = false;
    state.isFirstCommCompleted = true;
    emit(state.copy());
  }

  void refresh() {
    emit(state.copy());
  }

  Future<void> pressedFriendCodeAddButton(String inviteCode) async {
    state.isLoading = true;
    emit(state.copy());

    try {
      User friend = await _friendUseCase.addFriendBy(inviteCode);
      state.addFriend(friend);
      state.setRecommendedFriends(await _friendUseCase.getRecommendedFriends(put: true));
      } catch (e, trace) {
        print("친구추가 실패! $e $trace");
        throw Error();
      } finally {
      state.isLoading = false;
      emit(state.copy());
    }
  }

  Future<void> pressedFriendAddButton(User friend) async {
    state.isLoading = true;
    emit(state.copy());

    try {
      await _friendUseCase.addFriend(friend);
      state.addFriend(friend);
      state.setRecommendedFriends(await _friendUseCase.getRecommendedFriends(put: true));
    } catch (e, trace) {
      print("친구추가 실패! $e $trace");
      throw Error();
    } finally {
      state.isLoading = false;
      emit(state.copy());
    }
  }

  Future<int> getFriendsCount() async {
    List<User> friends = await _friendUseCase.getMyFriends();
    return friends.length;
  }
}
