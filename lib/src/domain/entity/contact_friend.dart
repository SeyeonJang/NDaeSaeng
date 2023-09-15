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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phoneNumber'] = this.phoneNumber;
    return data;
  }
}