class GuestInviteMessageRequest {
  String? name;
  String? phoneNumber;
  String? questionContent;

  GuestInviteMessageRequest(
      {this.name, this.phoneNumber, this.questionContent});

  GuestInviteMessageRequest.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    questionContent = json['questionContent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['phoneNumber'] = phoneNumber;
    data['questionContent'] = questionContent;
    return data;
  }
}
