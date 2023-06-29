import 'package:dart_flutter/src/data/model/friend.dart';
import 'package:dart_flutter/src/data/repository/dart_friend_repository.dart';
import 'package:dart_flutter/src/data/repository/dart_user_repository.dart';
import 'package:dart_flutter/src/presentation/mypage/friends_mock.dart';
import 'package:dart_flutter/src/presentation/mypage/viewmodel/state/mypages_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class MyPagesCubit extends Cubit<MyPagesState> {
  static final DartUserRepository _dartUserRepository = DartUserRepository();
  static final DartFriendRepository _dartFriendRepository = DartFriendRepository();

  MyPagesCubit() : super(MyPagesState.init());

  // 유저 정보, 친구 정보
  void initPages() async {
    // TODO : 실제 데이터 받아오기 (아래는 mock)
    // List<Friend> friends = FriendsMock().getFriends();
    List<Friend> friends = await _dartFriendRepository.getMyFriends();
    state.setUserInfo(friends);
    List<Friend> newFriends = await _dartFriendRepository.getRecommendedFriends();
    state.setRecommendedFriends(newFriends);
    // 초기값 설정
    state.userResponse = await _dartUserRepository.myInfo();
    state.setMyLandPage(true);
    state.setIsSettingPage(false);
    state.setIsTos1(false);
    state.setIsTos2(false);

    emit(state.copy());
  }

  void pressedFriendAddButton(int friendUserId) {
    _dartFriendRepository.addFriend(friendUserId);
  }

  void pressedFriendDeleteButton(int friendUserId) {
    _dartFriendRepository.deleteFriend(friendUserId);
  }

  void setMyLandPage() {
    state.setMyLandPage(true);
    state.setIsSettingPage(false);
    state.setIsTos1(false);
    state.setIsTos2(false);
    final newState = state.copy();
    print(newState);
    emit(newState);
  }

  // 설정 아이콘 -> 설정페이지(MySettings)로 변경
  void pressedSettingsIcon() {
    state.setIsSettingPage(true);
    state.setMyLandPage(false);
    state.setIsTos1(false);
    state.setIsTos2(false);
    final newState = state.copy();
    print(newState);
    emit(newState);
  }

  void pressedTos1() {
    state.setMyLandPage(false);
    state.setIsSettingPage(false);
    state.setIsTos1(true);
    state.setIsTos2(false);
    final newState = state.copy();
    print(newState);
    emit(newState);
  }

  void pressedTos2() {
    state.setMyLandPage(false);
    state.setIsSettingPage(false);
    state.setIsTos1(false);
    state.setIsTos2(true);
    final newState = state.copy();
    print(newState);
    emit(newState);
  }

  // 마이페이지(MyPageLanding)로 돌아가기
  void backToMyPageLanding() {
    state.setMyLandPage(true);
    state.setIsSettingPage(false);
    state.setIsTos1(false);
    state.setIsTos2(false);
    emit(state.copy());
  }

  // 설정(MySettings)로 돌아가기
  void backToSetting() {
    state.setMyLandPage(false);
    state.setIsSettingPage(true);
    state.setIsTos1(false);
    state.setIsTos2(false);
    emit(state.copy());
  }

  // @override
  // MyPagesState fromJson(Map<String, dynamic> json) => state.fromJson(json);
  //
  // @override
  // Map<String, dynamic> toJson(MyPagesState state) => state.toJson();
}