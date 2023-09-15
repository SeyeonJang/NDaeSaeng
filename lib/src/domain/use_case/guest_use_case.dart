import 'package:dart_flutter/src/data/repository/guest_repository_impl.dart';
import 'package:dart_flutter/src/domain/repository/guest_repository.dart';

class GuestUseCase {
  final GuestRepository _guestRepository = GuestRepositoryImpl();

  Future<void> inviteGuest(String name, String phoneNumber, String questionContent) async {
    return await _guestRepository.inviteGuest(name, phoneNumber, questionContent);
  }
}
