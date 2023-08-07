import 'package:dart_flutter/src/domain/entity/friend.dart';
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

    List<Friend> friends = await _friendUseCase.getMyFriends();
    state.setAddedFriends(friends);
    List<Friend> newFriends = await _friendUseCase.getRecommendedFriends();
    state.setRecommendedFriends(newFriends);
    _userUseCase.cleanUpUserResponseCache();
    state.userResponse = await _userUseCase.myInfo();

    state.userResponse.user!.recommendationCode;
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
      Friend friend = await _friendUseCase.addFriendBy(inviteCode);
      state.addFriend(friend);
      state.newFriends = await _friendUseCase.getRecommendedFriends(put: true);
      } catch (e, trace) {
        print("친구추가 실패! $e $trace");
        throw Error();
      } finally {
      state.isLoading = false;
      emit(state.copy());
    }
  }

  void pressedFriendAddButton(Friend friend) {
    state.isLoading = true;
    emit(state.copy());

    try {
      _friendUseCase.addFriend(friend);
      state.addFriend(friend);
    } catch (e, trace) {
      print("친구추가 실패! $e $trace");
      throw Error();
    } finally {
      state.isLoading = false;
      emit(state.copy());
    }
  }

  Future<int> getFriendsCount() async {
    List<Friend> friends = await _friendUseCase.getMyFriends();
    return friends.length;
  }
}
