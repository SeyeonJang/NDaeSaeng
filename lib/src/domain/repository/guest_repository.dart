abstract interface class GuestRepository {
  Future<void> inviteGuest(String name, String phoneNumber, String questionContent);
}
