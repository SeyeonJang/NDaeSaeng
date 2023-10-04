
import 'package:dart_flutter/src/data/datasource/dart_api_remote_datasource.dart';
import 'package:dart_flutter/src/data/model/guest_invite_message_request.dart';

import '../../domain/repository/guest_repository.dart';

class GuestRepositoryImpl implements GuestRepository {
  @override
  Future<void> inviteGuest(String name, String phoneNumber, String questionContent) async {
    var requestDto = GuestInviteMessageRequest(name: name, phoneNumber: phoneNumber, questionContent: questionContent);
    return await DartApiRemoteDataSource.postGuestInviteMessage(requestDto);
  }
}
