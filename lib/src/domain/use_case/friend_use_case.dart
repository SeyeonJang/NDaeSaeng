import 'package:dart_flutter/src/data/repository/dart_friend_repository_impl.dart';
import 'package:dart_flutter/src/domain/entity/friend.dart';
import 'package:dart_flutter/src/domain/repository/friend_repository.dart';

class FriendUseCase {
  final FriendRepository _dartFriendRepository = DartFriendRepositoryImpl();

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
