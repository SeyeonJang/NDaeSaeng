import 'dart:io';
import 'package:dart_flutter/src/common/util/toast_util.dart';
import 'package:dart_flutter/src/domain/entity/title_vote.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';
import 'package:dart_flutter/src/domain/use_case/friend_use_case.dart';
import 'package:dart_flutter/src/domain/use_case/user_use_case.dart';
import 'package:dart_flutter/src/presentation/mypage/viewmodel/state/mypages_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

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

    _userUseCase.setTitleVotes(userResponse.titleVotes);
    state.setTitleVotes(userResponse.titleVotes);

    List<User> friends = await _friendUseCase.getMyFriends();
    state.setMyFriends(friends);
    List<User> newFriends = await _friendUseCase.getRecommendedFriends();
    state.setRecommendedFriends(newFriends);
    getMyTitleVote();
    getAllVotes();

    String appVersion = await getAppVersion();
    state.setAppVersion(appVersion);

    state.setIsLoading(false);
    emit(state.copy());
    print("mypage init 끝");
  }

  // 기존 코드
  // Future<void> pressedFriendAddButton(User friend) async {
  //   await _friendUseCase.addFriend(friend);
  //   state.addFriend(friend);
  //   state.newFriends = (await _friendUseCase.getRecommendedFriends(put: true)).toSet();
  //   emit(state.copy());
  // }

  // 변경 코드
  Future<void> pressedFriendAddButton(User friend) async {
    // UI 상에서 먼저 작동
    state.addFriend(friend);
    emit(state.copy());
    // UI 변경 이후 async await 진행
    try {
      await _friendUseCase.addFriend(friend);
      state.newFriends = (await _friendUseCase.getRecommendedFriends(put: true)).toSet();
    } catch (e) {
      state.deleteFriend(friend);
      ToastUtil.showToast("친구 추가에 실패했어요!");
    }
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
    state.setIsLoading(true);
    emit(state.copy());

    _userUseCase.cleanUpUserResponseCache();
     User userResponse = await _userUseCase.myInfo();
     state.setUserResponse(userResponse);
    List<User> friends = await _friendUseCase.getMyFriends();
    state.setMyFriends(friends);
    List<User> newFriends = await _friendUseCase.getRecommendedFriends();
    state.setRecommendedFriends(newFriends);
     getMyTitleVote();

     state.setIsLoading(false);
     emit(state.copy());
  }

  void uploadProfileImage(File file, User userResponse) async {
    try {
      ToastUtil.showToast('내 사진을 업로드하고 있어요!');
      await _userUseCase.uploadProfileImage(file, userResponse);
      ToastUtil.showToast('내 사진 업로드가 완료됐어요!');
    } catch (e) {
      ToastUtil.showToast('사진 업로드 중 오류가 발생했습니다.');
      print('사진 업로드 중 오류: $e');
    }
  }

  String getProfileImageUrl(String userId) {
    String profileImageUrl = state.userResponse.personalInfo?.profileImageUrl ?? "DEFAULT";
    return profileImageUrl;
  }

  void uploadIdCardImage(File file, User userResponse, String name) async {
    _userUseCase.uploadIdCardImage(file, userResponse, name);
    state.isVertificateUploaded = true;
    emit(state.copy());
  }

  void setProfileImage(File file) {
    state.profileImageFile = file;
    emit(state.copy());
  }

  void setMyLandPage() {
    state.setMyLandPage(true);
    final newState = state.copy();
    print(newState);
    emit(newState);
  }

  void addTitleVote(TitleVote titleVote, User user) async {
    await _userUseCase.addTitleVote(titleVote, user);
    refreshMyInfo();
  }

  Future<void> getMyTitleVote() async {
    List<TitleVote> myTitleVotes = await _userUseCase.getMyTitleVote();
    state.setTitleVotes(myTitleVotes);
  }
  
  void removeTitleVote(int questionId, User user) async {
    await _userUseCase.removeTitleVote(questionId, user);
    refreshMyInfo();
  }

  Future<void> getAllVotes() async {
    state.setIsLoading(true);
    emit(state.copy());

    List<TitleVote> myVotes = await _userUseCase.getVotesSummary();
    state.setMyAllVotes(myVotes).setIsLoading(false);
    emit(state.copy());
  }

  Future<String> getAppVersion() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final String version = packageInfo.version;
    return version;
  }
}
