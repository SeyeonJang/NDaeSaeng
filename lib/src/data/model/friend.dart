class Friend {
  final int userId, univId;
  final int admissionNumber, mutualFriend;
  final String name, phone;
  final bool signUp;

  Friend(
      {required this.userId,
      required this.univId,
      required this.admissionNumber,
      required this.mutualFriend,
      required this.name,
      required this.phone,
      required this.signUp});

  Friend.from(Map<String, dynamic> json)
      : userId = json['userId'],
        univId = json['univId'],
        admissionNumber = json['admissionNumber'],
        mutualFriend = json['mutualFriend'],
        name = json['name'],
        phone = json['phone'],
        signUp = json['signUp'];
}
