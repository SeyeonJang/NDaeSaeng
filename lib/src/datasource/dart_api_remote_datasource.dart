import 'package:dart_flutter/src/data/model/contact.dart';
import 'package:dart_flutter/src/data/model/sns_request.dart';
import 'package:dart_flutter/src/data/model/user.dart';

import '../data/model/dart_auth.dart';
import '../data/model/vote.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

//TODO repository에 들어갈 내용인데 datasourcedㅔ 넣어버렸다...
class DartApiRemoteDataSource {
  static const String baseUrl = "www.naver.com";

  /// Auth: 로그인 요청
  static Future<DartAuth> postLoginWithKakao(String kakaoAccessToken) async {
    return DartAuth.from(await _simplePost('/v1/auth/kakao', kakaoAccessToken));
  }

  /// Auth: 문자인증 요청
  static Future<void> postSnsRequest(SnsRequest snsRequest) async {
    await _simplePost('/v1/auth/sns', snsRequest);
  }

  /// Auth: 문자인증 번호 검증 요청
  static Future<void> postCheckSnsCode(SnsRequest snsRequest) async {
    await _simplePost('/v1/auth/sns-check', snsRequest);
  }

  /// User: 회원가입 요청
  static Future<void> postUserSignup(UserRequest user) async {
    await _simplePost('/v1/user/signup', user);
  }

  /// User: 내 정보 가져오기
  static Future<UserResponse> getUser(String accessToken) async {
    final response = await http.get(Uri.https(baseUrl, '/v1/user/me', {'accessToken': "Bearer $accessToken"}));
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
      return UserResponse.from(jsonResponse);
    }
    throw Error();
  }

  // User: 내 정보 업데이트하기
  static Future<void> putUser(String accessToken, UserRequest user) async {
    final response = await http.put(Uri.https(baseUrl, '/v1/user/me', {'accessToken': "Bearer $accessToken", 'user': user}));
    return;
  }

  // Friend: 전화번호부 전달해서 받기 (가입자/미가입자를 구분하는 로직 필요)
  static Future<List<Contact>> postContacts(List<Contact> contacts) async {
    List<Contact> newContacts = [];
    final response = await _simplePostWithoutDecode('/v1/friends/contacts', contacts);

    if (response.statusCode == 200) {
      final List<dynamic> contactInstances = convert.jsonDecode(response.body);
      for (final contactInstance in contactInstances) {
        newContacts.add(Contact.from(contactInstance));
      }
      return newContacts;
    }
    throw Error();
  }

  // Friend: 친구목록 가져오기 (realFriend를 통해 '내가 추가한 친구'와 '추천 친구'를 구분함)
  static Future<List<Contact>> getMyFriends(String accessToken, String realFriend) async {
    final response = await http
        .get(Uri.https(baseUrl, '/v1/friends', {'accessToken': "Bearer $accessToken", 'realFriend': realFriend}));
    if (response.statusCode == 200) {
      final List<dynamic> contactInstances = convert.jsonDecode(response.body);
      return contactInstances.map((contactInstance) => Contact.from(contactInstance)).toList();
    }
    throw Error();
  }

  // vote: 새로운 투표들을 받기
  static Future<List<VoteResponse>> getNewVotes(String accessToken) async {
    final response = await http.get(Uri.https(baseUrl, '/v1/votes/form', {'accessToken': "Bearer $accessToken"}));
    if (response.statusCode == 200) {
      final List<dynamic> voteInstances = convert.jsonDecode(response.body);
      return voteInstances.map((voteInstance) => VoteResponse.from(voteInstance)).toList();
    }
    throw Error();
  }

  // vote: 투표한 내용 전달하기
  static Future<void> postVotes(String accessToken, List<VoteRequest> votes) async {
    await _simplePostWithoutDecode('/v1/votes', votes);  // TODO accessToken 사용 안하고 있음
  }

  // vote: 받은 투표 리스트 확인하기
  static Future<List<VoteResponse>> getVotes(String accessToken) async {
    final response = await http.get(Uri.https(baseUrl, '/v1/votes', {'accessToken': "Bearer $accessToken"}));
    if (response.statusCode == 200) {
      final List<dynamic> voteInstances = convert.jsonDecode(response.body);
      return voteInstances.map((voteInstance) => VoteResponse.from(voteInstance)).toList();
    }
    throw Error();
  }

  static Future<VoteResponse> getVote(int voteId) async {
    final response = await _simpleGet("/v1/votes/${voteId}");
    return VoteResponse.from(response);
  }

  // vote: 힌트 요청하기
  static Future<Hint> getHint(String accessToken, int voteId, String typeOfHint) async {  // TODO 이후 규격 보고 param와 header중 어디에 변수 넣을지 확인
    final response = await http.get(Uri.https(baseUrl, '/v1/votes/hints', {'accessToken': "Bearer $accessToken", 'voteId': voteId, 'kindOfHint': typeOfHint}));
    return Hint.from(_jsonDecode(response));
  }

  // vote: 투표 가능한지 확인하기 (남은 시간 확인)
  static Future<int> getCanIVote(String accessToken) async {
    // return await simpleGet('/v1/votes/lefttime');  // TODO 이후 규격보고 설정
    return 0;
  }

  // --------------------------------------------------------------------------

  static Future<Map<String, dynamic>> _simplePost(String path, Object? body) async {
    final uri = Uri.https(baseUrl, path);
    final response = await http.post(uri, body: body);
    return _jsonDecode(response);
  }

  static Future<http.Response> _simplePostWithoutDecode(String path, Object? body) async {
    final uri = Uri.https(baseUrl, path);
    return await http.post(uri, body: body);
  }

  static Future<Map<String, dynamic>> _simpleGet(String path) async {
    final uri = Uri.https(baseUrl, path);
    final response = await http.get(uri);
    return _jsonDecode(response);
  }

  static Map<String, dynamic> _jsonDecode(http.Response response) {
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
      return jsonResponse;
    }
    throw _errorHandler(response);
  }

  static Error _errorHandler(http.Response response) {
    throw Error();
  }
}
