import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import '../data/model/kakao_user_dto.dart';

class KakaoShareRemoteDataSource {
  Future<void> share (BuildContext context) async {
    bool isKakaoTalkSharingAvailable = await ShareClient.instance.isKakaoTalkSharingAvailable();

    if (isKakaoTalkSharingAvailable) {
      print('카카오톡으로 공유 가능');
    } else {
      print('카카오톡 미설치: 웹 공유 기능 사용 권장');
    }
  }
}