import 'package:dart_flutter/src/data/model/friend_dto.dart';
import 'package:dart_flutter/src/data/model/user_dto.dart';
import 'package:dart_flutter/src/data/repository/dart_friend_repository.dart';
import 'package:dart_flutter/src/data/repository/dart_user_repository.dart';
import 'package:dart_flutter/src/presentation/mypage/viewmodel/state/mypages_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../data/model/user_response_dto.dart';

class MyPagesCubit extends Cubit<MyPagesState> {
  static final DartUserRepository _dartUserRepository = DartUserRepository();
  static final DartFriendRepository _dartFriendRepository = DartFriendRepository();

  MyPagesCubit() : super(MyPagesState.init());

  // 유저 정보, 친구 정보
  void initPages() async {
    state.setIsLoading(true);
    emit(state.copy());

    // 초기값 설정
    UserResponseDto userResponse = await _dartUserRepository.myInfo();
    state.setUserResponse(userResponse);

    List<FriendDto> friends = await _dartFriendRepository.getMyFriends();
    state.setMyFriends(friends);
    List<FriendDto> newFriends = await _dartFriendRepository.getRecommendedFriends();
    state.setRecommendedFriends(newFriends);

    state.setIsLoading(false);
    emit(state.copy());
    print("mypage init 끝");
  }

  void pressedFriendAddButton(FriendDto friend) {
    _dartFriendRepository.addFriend(friend);
    state.addFriend(friend);
    emit(state.copy());
  }

  void pressedFriendDeleteButton(FriendDto friend) {
    _dartFriendRepository.deleteFriend(friend);
    state.deleteFriend(friend);
    emit(state.copy());
  }

  Future<void> pressedFriendCodeAddButton(String inviteCode) async {
    state.isLoading = true;
    emit(state.copy());

    try {
      FriendDto friend = await _dartFriendRepository.addFriendBy(inviteCode);
      state.addFriend(friend);
      state.newFriends = (await _dartFriendRepository.getRecommendedFriends(put: true)).toSet();
    } catch (e, trace) {
        print("친구추가 실패! $e $trace");
        throw Error();
      } finally {
        state.isLoading = false;
        emit(state.copy());
    }
  }

  void setMyLandPage() {
    state.setMyLandPage(true);
    final newState = state.copy();
    print(newState);
    emit(newState);
  }
}
