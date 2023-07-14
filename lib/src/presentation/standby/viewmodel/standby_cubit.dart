import 'package:dart_flutter/src/presentation/standby/viewmodel/state/standby_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../data/model/friend.dart';
import '../../../data/repository/dart_friend_repository.dart';
import '../../../data/repository/dart_user_repository.dart';

class StandbyCubit extends Cubit<StandbyState> {
  static final DartUserRepository _dartUserRepository = DartUserRepository();
  static final DartFriendRepository _dartFriendRepository = DartFriendRepository();

  StandbyCubit() : super(StandbyState.init());

  void initPages() async {
    state.isLoading = true;
    emit(state.copy());
    List<Friend> friends = await _dartFriendRepository.getMyFriends();
    state.setAddedFriends(friends);
    state.userResponse = await _dartUserRepository.myInfo();

    state.userResponse.user!.recommendationCode;
    state.isLoading = false;
    emit(state.copy());
    print("대기화면 무사 진입 ~ !"); // TODO : ERASE
  }

  void refresh() {
    emit(state.copy());
  }

  void pressedFriendCodeAddButton(String inviteCode) async {
    print(state.hashCode);
    state.isLoading = true;
    emit(state.copy());

    Friend friend = await _dartFriendRepository.addFriendBy(inviteCode);
    state.addFriend(friend);
    print("친추함 $friend");

    state.isLoading = false;
    print(state.hashCode);
    emit(state.copy());
    print(state.hashCode);
  }
}
