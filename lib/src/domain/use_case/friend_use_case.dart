import 'package:dart_flutter/src/data/repository/dart_friend_repository_impl.dart';
import 'package:dart_flutter/src/domain/entity/friend.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';
import 'package:dart_flutter/src/domain/repository/friend_repository.dart';

class FriendUseCase {
  final FriendRepository _dartFriendRepository = DartFriendRepositoryImpl();

  Future<List<User>> getMyFriends() async {
    return await _dartFriendRepository.getMyFriends();
  }

  Future<List<User>> getRecommendedFriends({bool put = false}) async {
    return await _dartFriendRepository.getRecommendedFriends(put: put);
  }

  Future<void> addFriend(User friend) async {
    await _dartFriendRepository.addFriend(friend);
  }

  Future<User> addFriendBy(String inviteCode) async {
    return await _dartFriendRepository.addFriendBy(inviteCode);
  }

  void removeFriend(User friend) {
    _dartFriendRepository.deleteFriend(friend);
  }
}
