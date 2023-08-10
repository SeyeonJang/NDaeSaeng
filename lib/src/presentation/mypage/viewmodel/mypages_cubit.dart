import 'dart:io';

import 'package:dart_flutter/src/domain/entity/user.dart';
import 'package:dart_flutter/src/domain/use_case/friend_use_case.dart';
import 'package:dart_flutter/src/domain/use_case/user_use_case.dart';
import 'package:dart_flutter/src/presentation/mypage/viewmodel/state/mypages_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class MyPagesCubit extends Cubit<MyPagesState> {
  static final UserUseCase _userUseCase = UserUseCase();
  static final FriendUseCase _friendUseCase = FriendUseCase();

  MyPagesCubit() : super(MyPagesState.init());

  // 유저 정보, 친구 정보
  void initPages() async {
    state.setIsLoading(true);
    emit(state.copy());

    // 초기값 설정
    User userResponse = await _userUseCase.myInfo();
    state.setUserResponse(userResponse);

    List<User> friends = await _friendUseCase.getMyFriends();
    state.setMyFriends(friends);
    List<User> newFriends = await _friendUseCase.getRecommendedFriends();
    state.setRecommendedFriends(newFriends);

    state.setIsLoading(false);
    emit(state.copy());
    print("mypage init 끝");
  }

  void pressedFriendAddButton(User friend) {
    _friendUseCase.addFriend(friend);
    state.addFriend(friend);
    emit(state.copy());
  }

  void pressedFriendDeleteButton(User friend) {
    _friendUseCase.removeFriend(friend);
    state.deleteFriend(friend);
    emit(state.copy());
  }

  Future<void> pressedFriendCodeAddButton(String inviteCode) async {
    state.isLoading = true;
    emit(state.copy());

    try {
      User friend = await _friendUseCase.addFriendBy(inviteCode);
      state.addFriend(friend);
      state.newFriends = (await _friendUseCase.getRecommendedFriends(put: true)).toSet();
    } catch (e, trace) {
        print("친구추가 실패! $e $trace");
        throw Error();
      } finally {
        state.isLoading = false;
        emit(state.copy());
    }
  }

  void patchMyInfo(User userResponse) {
    _userUseCase.patchMyInfo(userResponse);
  }

  void refreshMyInfo() async {
    _userUseCase.cleanUpUserResponseCache();
     User user = await _userUseCase.myInfo();
     state.setUserResponse(user);
     emit(state.copy());
  }

  void uploadProfileImage(File file, User userResponse) async {
    _userUseCase.uploadProfileImage(file, userResponse);
  }

  String getProfileImageUrl(String userId) {
    // return _userUseCase.getProfileImageUrl(userId);
    String profileImageUrl = state.userResponse.personalInfo!.profileImageUrl ?? "DEFAULT";
    return profileImageUrl;
  }

  void uploadIdCardImage(File file, User userResponse) async {
    _userUseCase.uploadIdCardImage(file, userResponse);
    state.isVertificateUploaded = true;
    emit(state.copy());
  }

  void setMyLandPage() {
    state.setMyLandPage(true);
    final newState = state.copy();
    print(newState);
    emit(newState);
  }
}
