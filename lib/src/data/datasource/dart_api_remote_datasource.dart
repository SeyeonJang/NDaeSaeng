import 'dart:convert';

import 'package:dart_flutter/res/environment/app_environment.dart';
import 'package:dart_flutter/src/data/model/question_dto.dart';
import 'package:dart_flutter/src/data/model/meet_team_request_dto.dart';
import 'package:dart_flutter/src/data/model/title_vote_dto.dart';
import 'package:dart_flutter/src/data/model/university_dto.dart';
import 'package:dart_flutter/src/data/model/user_request_dto.dart';
import 'package:dart_flutter/src/data/model/vote_detail_dto.dart';

import '../../common/util/http_util.dart';
import '../../data/model/dart_auth_dto.dart';
import '../../data/model/user_signup_request_dto.dart';
import '../../data/model/user_dto.dart';
import '../../data/model/vote_request_dto.dart';

import '../../data/model/vote_response_dto.dart';
import '../model/meet_team_response_dto.dart';
import '../model/type/team_region.dart';

class DartApiRemoteDataSource {
  static final String baseUrl = AppEnvironment.getEnv.getApiBaseUrl();
  static final _httpUtil = HttpUtil(baseUrl: baseUrl, headers: {
    'Accept': '*/*',
    'Content-Type': 'application/json',
  });

  static void addAuthorizationToken(String accessToken) {
    _httpUtil.addHeader('Authorization', 'Bearer ${accessToken}');
  }

  static get httpUtil {
    return _httpUtil;
  }

  // health
  static Future<String> healthCheck() async {
    const path = '/v1/health';
    final response = await _httpUtil.request().get(path);
    return response.data;
  }

  // Auth: 카카오 로그인 요청
  static Future<DartAuthDto> postLoginWithKakao(String kakaoAccessToken) async {
    const path = '/v1/auth/kakao';
    final body = {"accessToken": kakaoAccessToken};

    final response = await _httpUtil.request().post(path, data: body);

    final jsonResponse = json.decode(response.toString());
    final dartAuth = DartAuthDto.from(jsonResponse);
    addAuthorizationToken(dartAuth.accessToken);
    return dartAuth;
  }

  static Future<DartAuthDto> postLoginWithApple(String appleIdentifyToken) async {
    const path = '/v1/auth/apple';
    final body = {"idToken": appleIdentifyToken};

    final response = await _httpUtil.request().post(path, data: body);

    final jsonResponse = json.decode(response.toString());
    final dartAuth = DartAuthDto.from(jsonResponse);
    addAuthorizationToken(dartAuth.accessToken);
    return dartAuth;
  }

  /// Univ: 전체 대학 목록 가져오기
  static Future<List<UniversityDto>> getUniversities() async {
    const path = '/v1/universities';

    final response = await _httpUtil.request().get(path);
    final List<dynamic> jsonResponse = response.data;

    List<UniversityDto> universities = jsonResponse.map((university) => UniversityDto.fromJson(university)).toList();
    return universities;
  }

  /// User: 회원가입 요청
  static Future<UserDto> postUserSignup(UserSignupRequestDto user) async {
    const path = '/v1/users/signup';
    final body = user.toJson();
    print(body.toString());

    final response = await _httpUtil.request().post(path, data: body);

    final jsonResponse = json.decode(response.toString());
    return UserDto.fromJson(jsonResponse);
  }

  /// User: 회원 탈퇴 요청
  static Future<void> deleteMyAccount() async {
    const path = '/v1/users/me';
    final response = await _httpUtil.request().delete(path);
    print(response.toString());
  }

  /// User: 학생증 인증 요청
  static Future<UserDto> verifyStudentIdCard(String name, String idCardImageUrl) async {
    const path = '/v1/users/me/verify-student-id-card';
    final body = {"name": name, "studentIdCardImageUrl": idCardImageUrl};
    final response = await _httpUtil.request().post(path, data: body);
    final jsonResponse = json.decode(response.toString());
    return UserDto.fromJson(jsonResponse);
  }

  /// User: 내 정보 가져오기
  static Future<UserDto> getMyInformation() async {
    const path = '/v1/users/me';
    final response = await _httpUtil.request().get(path);

    final jsonResponse = json.decode(response.toString());
    return UserDto.fromJson(jsonResponse);
  }

  // User: 내 정보 수정하기
  static Future<UserDto> patchMyInformation(UserRequestDto user) async {
    const path = '/v1/users/me';
    final body = user.toBody();
    final response = await _httpUtil.request().patch(path, data: body);

    final jsonResponse = json.decode(response.toString());
    return UserDto.fromJson(jsonResponse);
  }

  // Friend: 친구목록 가져오기 (realFriend를 통해 '내가 추가한 친구'와 '추천 친구'를 구분함)
  static Future<List<UserDto>> getMyFriends({bool suggested=false}) async {
    try {
      const path = '/v1/friends';
      final pathFull = "$path?suggested=$suggested";
      final response = await _httpUtil.request().get(pathFull);

      final List<dynamic> jsonResponse = response.data;
      List<UserDto> friends = jsonResponse.map((user) => UserDto.fromJson(user)).toList();
      return friends;
    } catch (e) {
      return [];  // 에러 발생시 빈 리스트를 반환
    }
  }

  // Friend: 친구 추가하기
  static Future<String> postFriend(int friendUserId) async {
    const path = '/v1/friends';
    final body = {"friendUserId": friendUserId};

    final response = await _httpUtil.request().post(path, data: body);
    return response.data;
  }

  static Future<UserDto> postFriendBy(String inviteCode) async {
    const path = '/v1/friends/invite';
    final body = {"recommendationCode": inviteCode};

    final response = await _httpUtil.request().post(path, data: body);
    return UserDto.fromJson(response.data);
  }

  // Friend: 친구 삭제하기 (연결끊기)
  static Future<String> deleteFriend(int friendUserId) async {
    const path = '/v1/friends';
    final params = {"friendUserId": friendUserId};

    final response = await _httpUtil.request().delete(path, queryParameters: params);
    return response.data;
  }

  // vote: 새로운 투표들을 받기
  static Future<List<QuestionDto>> getNewQuestions() async {
    const path = '/v1/questions';
    final response = await _httpUtil.request().get(path);

    final List<dynamic> jsonResponse = response.data;
    List<QuestionDto> questions = jsonResponse.map((question) => QuestionDto.fromJson(question)).toList();
    return questions;
  }

  // vote: 투표한 내용들 전달하기
  static Future<void> postVotes(List<VoteRequestDto> votes) async {
    const path = '/v1/votes';
    final body = [];
    votes.forEach((vote) => body.add(vote.toJson()));

    final response = await _httpUtil.request().post(path, data: body);
  }

  // vote: 투표한 내용 전달하기
  static Future<void> postVote(VoteRequestDto vote) async {
    const path = '/v1/votes';
    final body = vote.toJson();

    final response = await _httpUtil.request().post(path, data: body);
  }

  // vote: 받은 투표 개요 확인하기
  static Future<List<TitleVoteDto>> getVotesSummary() async {
    const path = '/v1/users/me/questions';
    final response = await _httpUtil.request().get(path);

    final List<dynamic> jsonResponse = response.data;
    List<TitleVoteDto> titleVote = jsonResponse.map((vote) => TitleVoteDto.fromJson(vote)).toList();
    return titleVote;
  }

  // vote: 받은 투표 리스트 확인하기
  static Future<List<VoteResponseDto>> getVotes({int page = 0}) async {
    const path = '/v1/users/me/votes';
    final params = {"page": page};

    final response = await _httpUtil.request().get(path, queryParameters: params);
    final List<dynamic> jsonResponse = response.data['content'];
    List<VoteResponseDto> voteResponse = jsonResponse.map((vote) => VoteResponseDto.fromJson(vote)).toList();
    return voteResponse;
  }

  static Future<VoteDetailDto> getVote(int voteId) async {
    const path = '/v1/users/me/votes';
    final fullPath = '$path/$voteId';

    final response = await _httpUtil.request().get(fullPath);
    return VoteDetailDto.fromJson(response.data);
  }

  // vote: 투표 가능한지 확인하기 (남은 시간 확인)
  static Future<DateTime> getNextVoteTime() async {
    const path = '/v1/users/me/next-voting-time';

    final response = await _httpUtil.request().get(path);
    return DateTime.parse(response.data['nextVoteAvailableDateTime']);
  }

  // vote: 투표 완료 사인을 보내서 갱신하기
  static Future<DateTime> postNextVoteTime() async {
    const path = '/v1/users/me/next-voting-time';

    final response = await _httpUtil.request().post(path);
    return DateTime.parse(response.data['nextVoteAvailableDateTime']);
  }

  // region/location: 전체 지역 정보 조회
  static Future<List<TeamRegion>> getLocations() async {
    const path = '/v1/regions';
    final response = await _httpUtil.request().get(path);
    final List<dynamic> jsonResponse = response.data;
    List<TeamRegion> regions = jsonResponse.map((region) => TeamRegion.fromJson(region)).toList();
    return regions;
  }

  // meet: 전체 신청 팀 수 조회
  static Future<int> getTeamCount() async {
    const path = '/v1/teams/count';
    final response = await _httpUtil.request().get(path);
    return response.data;
  }

  // meet: 내 팀 목록 조회
  static Future<List<MeetTeamResponseDto>> getMyTeams() async {
    const path = '/v1/users/me/teams';
    final response = await _httpUtil.request().get(path);
    final List<dynamic> jsonResponse = response.data;
    List<MeetTeamResponseDto> teamResponses = jsonResponse.map((team) => MeetTeamResponseDto.fromJson(team)).toList();
    return teamResponses;
  }

  // meet: 팀 상세 조회
  static Future<MeetTeamResponseDto> getTeam(String teamId) async {
    const path = '/v1/users/me/teams';
    final pathUrl = "$path/$teamId";

    final response = await _httpUtil.request().get(pathUrl);
    return MeetTeamResponseDto.fromJson(response.data);
  }

  // meet: 팀 생성하기
  static Future<MeetTeamResponseDto> postTeam(MeetTeamRequestDto teamRequestDto) async {
    const path = '/v1/teams';
    final body = teamRequestDto.toJson();

    final response = await _httpUtil.request().post(path, data: body);
    return MeetTeamResponseDto.fromJson(response.data);
  }

  // meet: 팀 삭제하기
  static Future<void> deleteTeam(String teamId) async {
    const path = '/v1/users/me/teams';
    final pathUrl = "$path/$teamId";

    final response = await _httpUtil.request().delete(pathUrl);
  }

  // meet: 팀 정보 업데이트
  static Future<MeetTeamResponseDto> putTeam(MeetTeamRequestDto teamRequestDto) async {
    const path = '/v1/users/me/teams';
    final body = teamRequestDto.toJson();

    final response = await _httpUtil.request().put(path, data: body);
    return MeetTeamResponseDto.fromJson(response.data);
  }
}
