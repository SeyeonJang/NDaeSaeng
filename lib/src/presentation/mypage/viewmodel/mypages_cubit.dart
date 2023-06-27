import 'package:dart_flutter/src/data/model/friend.dart';
import 'package:dart_flutter/src/data/repository/dart_user_repository.dart';
import 'package:dart_flutter/src/presentation/mypage/friends_mock.dart';
import 'package:dart_flutter/src/presentation/mypage/viewmodel/state/mypages_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class MyPagesCubit extends HydratedCubit<MyPagesState> {
  static final DartUserRepository _dartUserRepository = DartUserRepository(); // TODO : 현식오빠 확인 받기

  MyPagesCubit() : super(MyPagesState.init());

  // 유저 정보, 친구 정보
  void initPages() async {
    // TODO : 실제 데이터 받아오기 (아래는 mock)
    List<Friend> friends = FriendsMock().getFriends();
    state.setUserInfo(friends);

    emit(state.copy());
  }

  // 설정 아이콘 -> 설정페이지(MySettings)로 변경
  void pressedSettingsIcon() {
    state.setIsSettingPage(true);
    final newState = state.copy();
    print(newState);
    emit(newState);
  }

  // 초대하기 버튼 -> 친구 초대 페이지(InviteFriends)로 페이지 변경
  void pressedInviteButton() {
    state.setIsInvitePage(true);
    final newState = state.copy();
    print(newState);
    emit(newState);
  }

  // 마이페이지(MyPageLanding)로 돌아가기
  void backToMyPageLanding() {
    state.setIsSettingPage(false);
    state.setIsSettingPage(false);
    emit(state.copy());
  }

  @override
  MyPagesState fromJson(Map<String, dynamic> json) => state.fromJson(json);

  @override
  Map<String, dynamic> toJson(MyPagesState state) => state.toJson();
}