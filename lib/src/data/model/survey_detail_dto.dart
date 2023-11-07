import 'package:dart_flutter/src/domain/entity/comment.dart';
import 'package:dart_flutter/src/domain/entity/option.dart';
import 'package:dart_flutter/src/domain/entity/personal_info.dart';
import 'package:dart_flutter/src/domain/entity/survey_detail.dart';
import 'package:dart_flutter/src/domain/entity/type/IdCardVerificationStatus.dart';
import 'package:dart_flutter/src/domain/entity/university.dart';
import 'package:dart_flutter/src/domain/entity/user.dart';

class SurveyDetailDto {
  int? surveyId;
  String? createdTime;
  String? lastModifiedTime;
  String? category;
  String? title;
  int? totalHeadCount;
  List<Answers>? answers;
  int? userAnswerId;
  List<Comments>? comments;

  SurveyDetailDto(
      {this.surveyId,
        this.createdTime,
        this.lastModifiedTime,
        this.category,
        this.title,
        this.totalHeadCount,
        this.answers,
        this.userAnswerId,
        this.comments});

  SurveyDetailDto.fromJson(Map<String, dynamic> json) {
    surveyId = json['surveyId'];
    createdTime = json['createdTime'];
    lastModifiedTime = json['lastModifiedTime'];
    category = json['category'];
    title = json['title'];
    totalHeadCount = json['totalHeadCount'];
    if (json['answers'] != null) {
      answers = <Answers>[];
      json['answers'].forEach((v) {
        answers!.add(new Answers.fromJson(v));
      });
    }
    userAnswerId = json['userAnswerId'];
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(new Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['surveyId'] = this.surveyId;
    data['createdTime'] = this.createdTime;
    data['lastModifiedTime'] = this.lastModifiedTime;
    data['category'] = this.category;
    data['title'] = this.title;
    data['totalHeadCount'] = this.totalHeadCount;
    if (this.answers != null) {
      data['answers'] = this.answers!.map((v) => v.toJson()).toList();
    }
    data['userAnswerId'] = this.userAnswerId;
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  SurveyDetail newSurveyDetail() {
    return SurveyDetail(
        id: surveyId ?? 0,
        question: title ?? "질문 불러오기에 실패했습니다.",
        options: answers?.map((answer) => answer.toOption()).toList() ?? [],
        picked: userAnswerId == null ? false : true,
        pickedOption: userAnswerId ?? 0,
        createdAt: createdTime != null ? DateTime.parse(createdTime!) : DateTime.now(),
        latestComment: "작성된 댓글이 없습니다.",
        comments: [],
    );
  }
}

class Answers {
  int? answerId;
  String? content;
  int? headCount;

  Answers({this.answerId, this.content, this.headCount});

  Answers.fromJson(Map<String, dynamic> json) {
    answerId = json['answerId'];
    content = json['content'];
    headCount = json['headCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['answerId'] = this.answerId;
    data['content'] = this.content;
    data['headCount'] = this.headCount;
    return data;
  }

  Option toOption() {
    return Option(id: answerId ?? 0, name: content ?? "불러오지 못했습니다.", headCount: headCount ?? 0);
  }
}

class Comments {
  int? commentId;
  String? content;
  int? likes;
  _User? user;
  String? createdTime;

  Comments({this.commentId, this.content, this.likes, this.user});

  Comments.fromJson(Map<String, dynamic> json) {
    commentId = json['commnetId'];
    content = json['content'];
    likes = json['likes'];
    user = json['user'] != null ? new _User.fromJson(json['user']) : null;
    createdTime = json['createdTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commnetId'] = this.commentId;
    data['content'] = this.content;
    data['likes'] = this.likes;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['createdTime'] = this.createdTime;
    return data;
  }

  Comment newComment() {
    return Comment(
        id: commentId ?? 0,
        writer: user!.newUser(),
        content: content ?? "",
        createdAt: createdTime != null ? DateTime.parse(createdTime!) : DateTime.now(),
        likes: likes ?? 0,
        liked: false
    );
  }
}

class _User {
  int? userId;
  String? name;
  String? nickname;
  String? gender;
  int? admissionYear;
  _University? university;

  _User(
      {this.userId,
        this.name,
        this.nickname,
        this.gender,
        this.admissionYear,
        this.university});

  _User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    nickname = json['nickname'];
    gender = json['gender'];
    admissionYear = json['admissionYear'];
    university = json['university'] != null
        ? new _University.fromJson(json['university'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['nickname'] = this.nickname;
    data['gender'] = this.gender;
    data['admissionYear'] = this.admissionYear;
    if (this.university != null) {
      data['university'] = this.university!.toJson();
    }
    return data;
  }

  User newUser() {
    return User(
        personalInfo: PersonalInfo(
          id: userId ?? 0,
          name: name ?? "",
          nickname: nickname ?? "",
          gender: gender ?? "",
          admissionYear: admissionYear ?? 2000,
          profileImageUrl: '',
          verification: IdCardVerificationStatus.VERIFICATION_FAILED,
          phone: '',
          birthYear: 2000,
          recommendationCode: '',
          point: 0,
        ),
        university: university?.newUniversity(),
        titleVotes: []
    );
  }
}

class _University {
  int? universityId;
  String? name;
  String? department;

  _University({this.universityId, this.name, this.department});

  _University.fromJson(Map<String, dynamic> json) {
    universityId = json['universityId'];
    name = json['name'];
    department = json['department'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['universityId'] = this.universityId;
    data['name'] = this.name;
    data['department'] = this.department;
    return data;
  }

  University newUniversity() {
    return University(id: universityId ?? 0, name: name ?? "XX대학교", department: department ?? "OOO학과");
  }
}
