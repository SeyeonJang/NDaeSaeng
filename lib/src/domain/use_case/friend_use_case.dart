import 'package:dart_flutter/src/data/repository/dart_friend_repository.dart';
import 'package:dart_flutter/src/domain/entity/friend.dart';

class FriendUseCase {
  final DartFriendRepository _dartFriendRepository = DartFriendRepository();

  Future<List<Friend>> getMyFriends() {
    return _dartFriendRepository.getMyFriends();
  }

  Future<List<Friend>> getRecommendedFriends({bool put = false}) {
    return _dartFriendRepository.getRecommendedFriends(put: put);
  }

  void addFriend(Friend friend) {
    _dartFriendRepository.addFriend(friend);
  }

  Future<Friend> addFriendBy(String inviteCode) async {
    return await _dartFriendRepository.addFriendBy(inviteCode);
  }

  void removeFriend(Friend friend) {
    _dartFriendRepository.deleteFriend(friend);
  }
}
