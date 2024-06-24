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
  String? content;
  int? totalHeadCount;
  List<Answers>? answers;
  int? userAnswerId;
  List<Comments>? comments;

  SurveyDetailDto(
      {this.surveyId,
        this.createdTime,
        this.lastModifiedTime,
        this.category,
        this.content,
        this.totalHeadCount,
        this.answers,
        this.userAnswerId,
        this.comments});

  SurveyDetailDto.fromJson(Map<String, dynamic> json) {
    surveyId = json['surveyId'];
    createdTime = json['createdTime'];
    lastModifiedTime = json['lastModifiedTime'];
    category = json['category'];
    content = json['content'];
    totalHeadCount = json['totalHeadCount'];
    if (json['answers'] != null) {
      answers = <Answers>[];
      json['answers'].forEach((v) {
        answers!.add(Answers.fromJson(v));
      });
    }
    userAnswerId = json['userAnswerId'];
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['surveyId'] = surveyId;
    data['createdTime'] = createdTime;
    data['lastModifiedTime'] = lastModifiedTime;
    data['category'] = category;
    data['content'] = content;
    data['totalHeadCount'] = totalHeadCount;
    if (answers != null) {
      data['answers'] = answers!.map((v) => v.toJson()).toList();
    }
    data['userAnswerId'] = userAnswerId;
    if (comments != null) {
      data['comments'] = comments!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  SurveyDetail newSurveyDetail() {
    return SurveyDetail(
        id: surveyId ?? 0,
        question: content ?? "질문 불러오기에 실패했습니다.",
        options: answers?.map((answer) => answer.toOption()).toList() ?? [],
        picked: userAnswerId == null ? false : true,
        pickedOption: userAnswerId ?? 0,
        createdAt: createdTime != null ? DateTime.parse(createdTime!) : DateTime.now(),
        latestComment: "작성된 댓글이 없습니다.",
        comments: comments?.map((comment) => comment.newComment()).toList() ?? [],
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['answerId'] = answerId;
    data['content'] = content;
    data['headCount'] = headCount;
    return data;
  }

  Option toOption() {
    return Option(id: answerId ?? 0, name: content ?? "불러오지 못했습니다.", headCount: headCount ?? 0);
  }
}

class Comments {
  int? commentId;
  String? content;
  int? like;
  bool? isLiked;
  bool? isReported;
  _User? user;
  String? createdTime;

  Comments({this.commentId, this.content, this.like, this.user, this.isLiked, this.isReported});

  Comments.fromJson(Map<String, dynamic> json) {
    commentId = json['commentId'];
    content = json['content'];
    like = json['like'];
    user = json['user'] != null ? _User.fromJson(json['user']) : null;
    createdTime = json['createdTime'];
    isLiked = json['isLiked'];
    isReported = json['isReported'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['commnetId'] = commentId;
    data['content'] = content;
    data['like'] = like;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['createdTime'] = createdTime;
    data['isLiked'] = isLiked;
    data['isReported'] = isReported;
    return data;
  }

  Comment newComment() {
    return Comment(
        id: commentId ?? 0,
        writer: user?.newUser() ?? User(titleVotes: []),
        content: content ?? "",
        createdAt: createdTime != null ? DateTime.parse(createdTime!) : DateTime.now(),
        likes: like ?? 0,
        liked: isLiked ?? false,
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

  _User();

  _User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    nickname = json['nickname'];
    gender = json['gender'];
    admissionYear = json['admissionYear'];
    university = json['university'] != null
        ? _University.fromJson(json['university'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['name'] = name;
    data['nickname'] = nickname;
    data['gender'] = gender;
    data['admissionYear'] = admissionYear;
    if (university != null) {
      data['university'] = university!.toJson();
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

  _University();

  _University.fromJson(Map<String, dynamic> json) {
    universityId = json['universityId'];
    name = json['name'];
    department = json['department'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['universityId'] = universityId;
    data['name'] = name;
    data['department'] = department;
    return data;
  }

  University newUniversity() {
    return University(id: universityId ?? 0, name: name ?? "XX대학교", department: department ?? "OOO학과");
  }
}
