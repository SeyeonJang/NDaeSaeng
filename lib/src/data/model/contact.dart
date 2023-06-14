class Contact {
  final String name;
  final String phone;

  Contact({required this.name, required this.phone});

  Contact.from(Map<String, dynamic> json)
      : name = json['name'],
        phone = json['phone'];
}
