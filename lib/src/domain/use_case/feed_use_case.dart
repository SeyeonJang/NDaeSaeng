import 'package:dart_flutter/src/common/pagination/pagination.dart';
import 'package:dart_flutter/src/domain/entity/comment.dart';
import 'package:dart_flutter/src/domain/entity/option.dart';
import 'package:dart_flutter/src/domain/entity/personal_info.dart';
import 'package:dart_flutter/src/domain/entity/post.dart';
import 'package:dart_flutter/src/domain/entity/survey.dart';
import 'package:dart_flutter/src/domain/entity/type/IdCardVerificationStatus.dart';
import 'package:dart_flutter/src/domain/entity/university.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';

class FeedUseCase {
  Survey dummySurvey = Survey(
      id: 0,
      question: '여사친에게 겉옷 빌려주는 행동 플러팅일까?',
      options: [Option(id: 1, name: '그렇다', percent: 54.3), Option(id: 2, name: '아니다', percent: 45.7)],
      picked: false,
      pickedOption: 1
  );

  Pagination<Post> posts = Pagination(content: [
    Post(
        id: 10,
        title: '타이틀1',
        content: '본문1',
        writer: User(
          personalInfo: const PersonalInfo(
              id: 123,
              name: '',
              nickname: '',
              profileImageUrl: '',
              verification: IdCardVerificationStatus.NOT_VERIFIED_YET,
              phone: '',
              gender: '',
              birthYear: 2002,
              admissionYear: 2022,
              recommendationCode: 'ABCD1234',
              point: 0
          ),
            university: University(
                id: 10000,
                name: '가톨릭대학교',
                department: ''
            ),
            titleVotes: []),
        comments: [],
        createdAt: DateTime.now().subtract(Duration(minutes: 2)),
        likes: 0,
        liked: false
    ),
    Post(
        id: 11,
        title: '타이틀2',
        content: '본문2',
        writer: User(
            personalInfo: const PersonalInfo(
                id: 234,
                name: '',
                nickname: '',
                profileImageUrl: '',
                verification: IdCardVerificationStatus.NOT_VERIFIED_YET,
                phone: '',
                gender: '',
                birthYear: 2002,
                admissionYear: 2022,
                recommendationCode: 'BCDE4321',
                point: 0
            ),
            university: University(
                id: 10001,
                name: '인하대학교',
                department: ''
            ),
            titleVotes: []),
        comments: [Comment(id: 999, writer: User(
            personalInfo: const PersonalInfo(
                id: 123,
                name: '',
                nickname: '',
                profileImageUrl: '',
                verification: IdCardVerificationStatus.NOT_VERIFIED_YET,
                phone: '',
                gender: '',
                birthYear: 2002,
                admissionYear: 2022,
                recommendationCode: 'ABCD1234',
                point: 0
            ),
            university: University(
                id: 10000,
                name: '가톨릭대학교',
                department: ''
            ),
            titleVotes: []), content: '댓글입니다1', createdAt: DateTime.now())],
        createdAt: DateTime.now().subtract(Duration(minutes: 1)),
        likes: 5,
        liked: true
    ),
  ]);

  Survey getSurvey() { // 오늘의 질문 get
    return dummySurvey;
  }

  void pickOption() { // 오늘의 질문 선택 post
    dummySurvey = Survey(
        id: 0,
        question: '여사친에게 겉옷 빌려주는 행동 플러팅일까?',
        options: [Option(id: 1, name: '그렇다', percent: 54.3), Option(id: 2, name: '아니다', percent: 45.7)],
        picked: true,
        pickedOption: 1
    );
  }

  Pagination<Post> getPosts({int page = 0, int size = 10}) { // 커뮤니티 글 get (Pagination)
    return posts;
  }

  void postOnePost(Post onePost) { // 커뮤니티 글 post
    posts.content?.add(onePost);
  }
}