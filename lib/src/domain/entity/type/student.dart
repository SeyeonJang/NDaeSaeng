import 'package:dart_flutter/src/domain/entity/title_vote.dart';

abstract interface class Student {
  int getId();
  String getName();
  String getProfileImageUrl();
  int getUniversityId();
  String getUniversityName();
  String getDepartment();
  bool getIsCertifiedUser();
  int getBirthYear();
  List<TitleVote> getTitleVotes();
  Map<String, dynamic> toJson();
}
