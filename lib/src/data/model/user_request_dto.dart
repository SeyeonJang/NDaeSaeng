import 'package:dart_flutter/src/domain/entity/user.dart';

class UserRequestDto {
  static const String DEFAULT_VALUE = "DEFAULT";

  String? nickname;
  String? profileImageUrl;
  List<int>? profileQuestionIds;

  UserRequestDto({this.nickname, this.profileImageUrl, this.profileQuestionIds});

  UserRequestDto.fromJson(Map<String, dynamic> json) {
    nickname = json['nickname'];
    profileImageUrl = json['profileImageUrl'];
    profileQuestionIds = json['profileQuestionIds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nickname'] = nickname;
    data['profileImageUrl'] = profileImageUrl;
    data['profileQuestionIds'] = profileQuestionIds;
    return data;
  }

  Map<String, dynamic> toBody() {
    nickname = checkAndSetDefault(nickname);
    profileImageUrl = checkAndSetDefault(profileImageUrl);
    return toJson();
  }

  dynamic checkAndSetDefault(dynamic value) {
      if (value == null || value == "") {
        value = DEFAULT_VALUE;
      }
      return value;
  }

  static UserRequestDto fromUserResponse(User userResponse) {
    return UserRequestDto(
      nickname: userResponse.personalInfo!.nickname,
      profileImageUrl: userResponse.personalInfo!.profileImageUrl,
      profileQuestionIds: userResponse.titleVotes
          .map((titleVote) => titleVote.question.questionId)
          .whereType<int>()  // Filter out null values
          .toList(),
    );
  }

  @override
  String toString() {
    return 'UserRequestDto{nickname: $nickname, profileImageUrl: $profileImageUrl, profileQuestionIds: $profileQuestionIds}';
  }
}
