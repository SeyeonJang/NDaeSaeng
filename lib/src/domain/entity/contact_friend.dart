class ContactFriend {
  final String name;
  final String phoneNumber;

  ContactFriend({
    required this.name,
    required this.phoneNumber
  });

  static ContactFriend fromJson(Map<String, dynamic> json) {
    var name = json['name'];
    var phoneNumber = json['phoneNumber'];

    return ContactFriend(
      name: name,
      phoneNumber: phoneNumber
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['phoneNumber'] = phoneNumber;
    return data;
  }
}