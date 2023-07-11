import 'dart:convert';

import 'package:dart_flutter/src/data/model/contact.dart';
import 'package:dart_flutter/src/data/model/friend.dart';
import 'package:dart_flutter/src/data/model/question.dart';
import 'package:dart_flutter/src/data/model/sns_request.dart';
import 'package:dart_flutter/src/data/model/university.dart';
import 'package:dart_flutter/src/data/model/user.dart';

import '../common/util/HttpUtil.dart';
import '../data/model/dart_auth.dart';
import '../data/model/vote.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

//TODO repository에 들어갈 내용인데 datasourcedㅔ 넣어버렸다...
class DartApiRemoteDataSource {
  static const String baseUrl = "dart-server-aiasblaoxa-du.a.run.app";

  static final _httpUtil = HttpUtil(baseUrl: 'https://dart-server-aiasblaoxa-du.a.run.app', headers: {
    // 'Authorization': 'Bearer nothing',
    'Accept': '*/*',
    'Content-Type': 'application/json',
  });

  static void addAuthorizationToken(String accessToken) {
    _httpUtil.addHeader('Authorization', 'Bearer ${accessToken}');
  }

  static get httpUtil {
    return _httpUtil;
  }

  // Auth: 카카오 로그인 요청
  static Future<DartAuth> postLoginWithKakao(String kakaoAccessToken) async {
    const path = '/v1/auth/kakao';
    final body = {"accessToken": kakaoAccessToken};

    final response = await _httpUtil.request().post(path, data: body);

    final jsonResponse = json.decode(response.toString());
    final dartAuth = DartAuth.from(jsonResponse);
    addAuthorizationToken(dartAuth.accessToken);
    return dartAuth;
  }

  /// Auth: 문자인증 요청
  static Future<void> postSnsRequest(SnsRequest snsRequest) async {
    const path = '/v1/auth/sms';
    final body = {"phoneNumber": snsRequest.getPhone};

    final response = await _httpUtil.request().post(path, data: body);
    return;
  }

  /// Auth: 문자인증 번호 검증 요청
  static Future<bool> postCheckSnsCode(SnsVerifyingRequest snsVerifyingRequest) async {
    const path = '/v1/auth/sms/verifying';
    final body = {"code": snsVerifyingRequest.getCode};

    final response = await _httpUtil.request().post(path, data: body);

    final jsonResponse = json.decode(response.toString());
    if (jsonResponse['status'] == 'ok') {
      return true;
    } else {
      print(jsonResponse['status']);
      return false;
    }
  }

  /// Univ: 전체 대학 목록 가져오기
  static Future<List<University>> getUniversities() async {
    const path = '/v1/universities';

    final response = await _httpUtil.request().get(path);
    final List<dynamic> jsonResponse = response.data;

    List<University> universities = jsonResponse.map((university) => University.fromJson(university)).toList();
    return universities;
  }

  /// User: 회원가입 요청
  static Future<UserResponse> postUserSignup(UserRequest user) async {
    const path = '/v1/users/signup';
    final body = user.toJson();
    print(body.toString());

    final response = await _httpUtil.request().post(path, data: body);

    final jsonResponse = json.decode(response.toString());
    return UserResponse.fromJson(jsonResponse);
  }

  /// User: 회원 탈퇴 요청
  static Future<void> deleteMyAccount() async {
    const path = '/v1/users/me';
    final response = await _httpUtil.request().delete(path);
    print(response.toString());
  }

  /// User: 내 정보 가져오기
  static Future<UserResponse> getMyInformation() async {
    const path = '/v1/users/me';
    final response = await _httpUtil.request().get(path);
    print(response);

    final jsonResponse = json.decode(response.toString());
    return UserResponse.fromJson(jsonResponse);
  }

  // User: 내 정보 업데이트하기
  static Future<void> putUser(String accessToken, UserRequest user) async {
    final response =
        await http.put(Uri.https(baseUrl, '/v1/user/me', {'accessToken': "Bearer $accessToken", 'user': user}));
    return;
  }

  // Friend: 친구목록 가져오기 (realFriend를 통해 '내가 추가한 친구'와 '추천 친구'를 구분함)
  static Future<List<Friend>> getMyFriends({bool suggested=false}) async {
    const path = '/v1/friends';
    final pathFull = "$path?suggested=$suggested";
    final response = await _httpUtil.request().get(pathFull);

    final List<dynamic> jsonResponse = response.data;
    List<Friend> friends = jsonResponse.map((friend) => Friend.fromJson(friend)).toList();
    return friends;
  }

  // Friend: 친구 추가하기
  static Future<String> postFriend(int friendUserId) async {
    const path = '/v1/friends';
    final body = {"friendUserId": friendUserId};

    final response = await _httpUtil.request().post(path, data: body);
    return response.data;
  }

  // Friend: 친구 삭제하기 (연결끊기)
  static Future<String> deleteFriend(int friendUserId) async {
    const path = '/v1/friends';
    final params = {"friendUserId": friendUserId};

    final response = await _httpUtil.request().delete(path, queryParameters: params);
    return response.data;
  }

  // vote: 새로운 투표들을 받기
  static Future<List<Question>> getNewQuestions() async {
    const path = '/v1/questions';
    final response = await _httpUtil.request().get(path);

    final List<dynamic> jsonResponse = response.data;
    List<Question> questions = jsonResponse.map((question) => Question.fromJson(question)).toList();
    return questions;
  }

  // vote: 투표한 내용들 전달하기
  static Future<void> postVotes(List<VoteRequest> votes) async {
    const path = '/v1/votes';
    final body = [];
    votes.forEach((vote) => body.add(vote.toJson()));

    final response = await _httpUtil.request().post(path, data: body);
  }

  // vote: 투표한 내용 전달하기
  static Future<void> postVote(VoteRequest vote) async {
    const path = '/v1/votes';
    final body = vote.toJson();

    final response = await _httpUtil.request().post(path, data: body);
  }

  // vote: 받은 투표 리스트 확인하기
  static Future<List<VoteResponse>> getVotes() async {
    const path = '/v1/votes';

    final response = await _httpUtil.request().get(path);
    final List<dynamic> jsonResponse = response.data;
    List<VoteResponse> voteResponse = jsonResponse.map((vote) => VoteResponse.fromJson(vote)).toList();
    return voteResponse;
  }

  static Future<VoteResponse> getVote(int voteId) async {
    const path = '/v1/votes';
    final fullPath = '$path/$voteId';

    final response = await _httpUtil.request().get(fullPath);
    return VoteResponse.fromJson(response.data);
  }

  // vote: 투표 가능한지 확인하기 (남은 시간 확인)
  static Future<int> getCanIVote(String accessToken) async {
    // return await simpleGet('/v1/votes/lefttime');  // TODO 이후 규격보고 설정
    return 0;
  }

  static Future<void> updateMyNextVoteTime(String accessToken) async {
    // return await simpleGet('/v1/votes/lefttime');  // TODO 이후 규격보고 설정
    return;
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
