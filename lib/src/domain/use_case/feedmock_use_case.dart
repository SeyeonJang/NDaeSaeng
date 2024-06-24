import 'package:dart_flutter/src/common/pagination/pagination.dart';
import 'package:dart_flutter/src/domain/entity/comment.dart';
import 'package:dart_flutter/src/domain/entity/option.dart';
import 'package:dart_flutter/src/domain/entity/personal_info.dart';
import 'package:dart_flutter/src/domain/entity/survey.dart';
import 'package:dart_flutter/src/domain/entity/survey_detail.dart';
import 'package:dart_flutter/src/domain/entity/type/IdCardVerificationStatus.dart';
import 'package:dart_flutter/src/domain/entity/university.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';

class FeedMockUseCase {
  SurveyDetail mockUpSurveyDetail = SurveyDetail(
      id: 0,
      question: '여사친에게 겉옷 빌려주는 행동 플러팅일까?',
      options: [
        Option(id: 1, name: '그렇다', headCount: 10),
        Option(id: 2, name: '아니다', headCount: 25)
      ],
      picked: false,
      pickedOption: 1,
      createdAt: DateTime.now(),
      latestComment: '여사친한테 겉옷 빌려주면 이게 플러팅이지 뭐얏!!!',
      comments: [
        Comment(
            id: 111,
            writer: User(
                personalInfo: const PersonalInfo(
                    id: 999,
                    name: '닉넴',
                    nickname: '닉넴',
                    profileImageUrl: 'https://',
                    verification: IdCardVerificationStatus.NOT_VERIFIED_YET,
                    phone: '',
                    gender: '',
                    birthYear: 2002,
                    admissionYear: 2022,
                    recommendationCode: 'ABCD1234',
                    point: 0),
                university: University(
                    id: 9890890, name: '인하대학교', department: '정보통신전자공학부'),
                titleVotes: []),
            content: '여사친한테 겉옷 빌려주면 이게 플러팅이지 뭐얏!!!',
            createdAt: DateTime.now(),
            likes: 5,
            liked: false),
        Comment(
            id: 112,
            writer: User(
                personalInfo: const PersonalInfo(
                    id: 999,
                    name: '닉넴',
                    nickname: '닉넴',
                    profileImageUrl: 'https://',
                    verification: IdCardVerificationStatus.NOT_VERIFIED_YET,
                    phone: '',
                    gender: '',
                    birthYear: 2002,
                    admissionYear: 2022,
                    recommendationCode: 'ABCD1234',
                    point: 0),
                university: University(
                    id: 9890890, name: '인하대학교', department: '정보통신전자공학부'),
                titleVotes: []),
            content: '여사친한테 겉옷 빌려주면 이게 플러팅이지 뭐얏ㅡㅡ!!!',
            createdAt: DateTime.now(),
            likes: 5,
            liked: false),
        Comment(
            id: 112,
            writer: User(
                personalInfo: const PersonalInfo(
                    id: 999,
                    name: '닉넴',
                    nickname: '닉넴',
                    profileImageUrl: 'https://',
                    verification: IdCardVerificationStatus.NOT_VERIFIED_YET,
                    phone: '',
                    gender: '',
                    birthYear: 2002,
                    admissionYear: 2022,
                    recommendationCode: 'ABCD1234',
                    point: 0),
                university: University(
                    id: 9890890, name: '인하대학교', department: '정보통신전자공학부'),
                titleVotes: []),
            content: '여사친한테 겉옷 빌려주면 이게 플러팅이지 뭐얏ㅡㅡ!!!',
            createdAt: DateTime.now(),
            likes: 5,
            liked: false),
        Comment(
            id: 112,
            writer: User(
                personalInfo: const PersonalInfo(
                    id: 999,
                    name: '닉넴',
                    nickname: '닉넴',
                    profileImageUrl: 'https://',
                    verification: IdCardVerificationStatus.NOT_VERIFIED_YET,
                    phone: '',
                    gender: '',
                    birthYear: 2002,
                    admissionYear: 2022,
                    recommendationCode: 'ABCD1234',
                    point: 0),
                university: University(
                    id: 9890890, name: '인하대학교', department: '정보통신전자공학부'),
                titleVotes: []),
            content: '여사친한테 겉옷 빌려주면 이게 플러팅이지 뭐얏ㅡㅡ!!!',
            createdAt: DateTime.now(),
            likes: 5,
            liked: false),
        Comment(
            id: 112,
            writer: User(
                personalInfo: const PersonalInfo(
                    id: 999,
                    name: '닉넴',
                    nickname: '닉넴',
                    profileImageUrl: 'https://',
                    verification: IdCardVerificationStatus.NOT_VERIFIED_YET,
                    phone: '',
                    gender: '',
                    birthYear: 2002,
                    admissionYear: 2022,
                    recommendationCode: 'ABCD1234',
                    point: 0),
                university: University(
                    id: 9890890, name: '인하대학교', department: '정보통신전자공학부'),
                titleVotes: []),
            content: '여사친한테 겉옷 빌려주면 이게 플러팅이지 뭐얏ㅡㅡ!!!',
            createdAt: DateTime.now(),
            likes: 5,
            liked: false)
      ]);

  Pagination<Survey> mockUpSurveys = Pagination(content: [
    Survey(
        id: 0,
        question: '여사친에게 겉옷 빌려주는 행동 플러팅일까?',
        options: [
          Option(id: 1, name: '그렇다', headCount: 10),
          Option(id: 2, name: '아니다', headCount: 25)
        ],
        picked: false,
        pickedOption: 1,
        category: '',
        createdAt: DateTime.now(),
        latestComment: '여사친한테 겉옷 빌려주면 이게 플러팅이지 뭐얏!!!'),
    Survey(
        id: 1,
        question: '로또맞으면 가족한테 말 한다 안 한다?',
        options: [
          Option(id: 3, name: '한다 🙆🏻‍♀️', headCount: 30),
          Option(id: 4, name: '안 한다🙅🏻‍♀️', headCount: 80)
        ],
        category: '',
        picked: true,
        pickedOption: 3,
        createdAt: DateTime.now(),
        latestComment: '고민된다 이거 ...')
  ]);

  // 서베이

  Pagination<Survey> getSurveys({int page = 0, int size = 10}) {
    // 오늘의 질문 목록 get (Pagination)
    return mockUpSurveys;
  }

  SurveyDetail getSurvey(int id) {
    // 오늘의 질문 한 개 get
    return mockUpSurveyDetail;
  }

  void pickOption() {
    // 선택지 선택 post
    mockUpSurveyDetail = SurveyDetail(
        id: 0,
        question: '여사친에게 겉옷 빌려주는 행동 플러팅일까?',
        options: [
          Option(id: 1, name: '그렇다', headCount: 50),
          Option(id: 2, name: '아니다', headCount: 25)
        ],
        picked: false,
        pickedOption: 1,
        createdAt: DateTime.now(),
        latestComment: '여사친한테 겉옷 빌려주면 이게 플러팅이지 뭐얏!!!',
        comments: [
          Comment(
              id: 111,
              writer: User(
                  personalInfo: const PersonalInfo(
                      id: 999,
                      name: '닉넴',
                      nickname: '닉넴',
                      profileImageUrl: 'https://',
                      verification: IdCardVerificationStatus.NOT_VERIFIED_YET,
                      phone: '',
                      gender: '',
                      birthYear: 2002,
                      admissionYear: 2022,
                      recommendationCode: 'ABCD1234',
                      point: 0),
                  university: University(
                      id: 9890890, name: '인하대학교', department: '정보통신전자공학부'),
                  titleVotes: []),
              content: '여사친한테 겉옷 빌려주면 이게 플러팅이지 뭐얏!!!',
              createdAt: DateTime.now(),
              likes: 5,
              liked: false)
        ]);
  }

  // 댓글

  void postComment(User userResponse, String content, DateTime createdAt) {
    // 댓글 추가
    mockUpSurveyDetail.comments.add(Comment(
        id: 0,
        writer: userResponse,
        content: content,
        createdAt: createdAt,
        likes: 0,
        liked: false));
    print(Comment(
        id: 0,
        writer: userResponse,
        content: content,
        createdAt: createdAt,
        likes: 0,
        liked: false));
  }

  void deleteComment(int commentId) {
    // 댓글 삭제
    mockUpSurveyDetail.comments.removeLast();
  }

  void reportComment(int commentId) {
    // 댓글 삭제
    // TODO : report
  }

  void postLikeComment(int commentId) {
    // 댓글 좋아요
    // TODO : like
  }
}
