@Deprecated("전화번호부를 사용하지 않습니다.")
class Contact {
  final String name;
  final String phone;

  Contact({required this.name, required this.phone});

  Contact.from(Map<String, dynamic> json)
      : name = json['name'],
        phone = json['phone'];
}
