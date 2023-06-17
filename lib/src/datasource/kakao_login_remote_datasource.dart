import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

import '../data/model/kakao_user.dart';

class KakaoLoginRemoteDatasource {
  static Future<KakaoUser> loginWithKakaoTalk() async {
    if (await isKakaoTalkInstalled()) {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
        print('카카오톡으로 로그인 성공');
        try {
          User user = await UserApi.instance.me();
          print(user.toString());
          print('사용자 정보 요청 성공'
              '\n회원번호: ${user.id}'
              '\nAccessToken: ${token.accessToken}'
              '\n프사: ${user.kakaoAccount?.profile?.profileImageUrl}'
              '\n이메일: ${user.kakaoAccount?.gender}');

          var json = user.toJson();
          return KakaoUser(
            uuid: json['id'].toString(),
            profileImageUrl: json['kakao_account']['profile']['profile_image_url'],
            gender: json['kakao_account']['gender'],
            accessToken: token.accessToken,
          );
        } catch (error) {
          print('사용자 정보 요청 실패 $error');
        }
      } catch (error) {
        print('카카오톡으로 로그인 실패 $error');

        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {
          throw Error();
        }
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          await UserApi.instance.loginWithKakaoAccount();
          print('카카오계정으로 로그인 성공');
        } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
        }
      }
    } else {
      print("이 폰에는 카카오톡이 없습니다?");
      try {
        await UserApi.instance.loginWithKakaoAccount();
        print('카카오계정으로 로그인 성공');

      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
      }
    }
    throw Error();
  }
}