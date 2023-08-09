import 'package:dart_flutter/src/domain/entity/user_response.dart';

class UserRequestDto {
  String? nickname;
  String? profileImageUrl;

  UserRequestDto({this.nickname, this.profileImageUrl});

  UserRequestDto.fromJson(Map<String, dynamic> json) {
    nickname = json['nickname'];
    profileImageUrl = json['profileImageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nickname'] = nickname;
    data['profileImageUrl'] = profileImageUrl;
    return data;
  }

  Map<String, dynamic> toBody() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (nickname != null || nickname == "") {
      data['nickname'] = nickname;
    }
    if (profileImageUrl != null || profileImageUrl == "") {
      data['profileImageUrl'] = profileImageUrl;
    }
    return data;
  }

  static UserRequestDto fromUserResponse(UserResponse userResponse) {
    return UserRequestDto(
      nickname: userResponse.user!.nickname,
      profileImageUrl: userResponse.user!.profileImageUrl
    );
  }
}
