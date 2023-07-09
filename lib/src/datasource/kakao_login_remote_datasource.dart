import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

import '../data/model/kakao_user.dart';

class KakaoLoginRemoteDatasource {
  static Future<KakaoUser> loginWithKakaoTalk() async {
    if (await isKakaoTalkInstalled()) {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
        return await getKakaoUserInform(token);
      } catch (error) {
        print('카카오톡으로 로그인 실패 $error');

        if (error is PlatformException && error.code == 'CANCELED') {  // 카카오 로그인 중 의도적인 취소 (예: 뒤로가기)
          throw Error();
        }
      }
    }

    print("카카오톡으로 로그인 할 수 없습니다. (카톡에 연결된 계정이 없는 경우 또는 카톡 설치되어있지 않음)");
    try {
      OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
      return await getKakaoUserInform(token);
    } catch (error) {
      print('카카오계정으로 로그인 실패 $error');
    }
    throw Error();
  }

  static Future<KakaoUser> getKakaoUserInform(OAuthToken token) async {
    User user = await UserApi.instance.me();
    print(user.toString());
    print('사용자 정보 요청 성공'
        '\n회원번호: ${user.id}'
        '\nAccessToken: ${token.accessToken}'
        '\n프사: ${user.kakaoAccount?.profile?.profileImageUrl}'
        '\n성별: ${user.kakaoAccount?.gender}');

    var json = user.toJson();
    return KakaoUser(
      uuid: json['id'].toString(),
      profileImageUrl: json['kakao_account']['profile']['profile_image_url'],
      gender: json['kakao_account']['gender'],
      accessToken: token.accessToken,
    );
  }

  Future<void> logout() async { // 로그아웃
    try {
      await UserApi.instance.logout();
      print('로그아웃 성공, SDK에서 토큰 삭제');
    } catch (error) {
      print('로그아웃 실패, SDK에서 토큰 삭제 $error');
    }
  }

  Future<void> withdrawal() async { // 회원탈퇴
    try {
      await UserApi.instance.unlink();
      print('연결 끊기 성공, SDK에서 토큰 삭제');
    } catch (error) {
      print('연결 끊기 실패 $error');
    }
  }

  // 연결 끊겼을 때 알림도 설정 가능
  // https://developers.kakao.com/docs/latest/ko/kakaologin/callback#unlink
}