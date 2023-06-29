import 'package:dart_flutter/src/data/model/friend.dart';
import 'package:dart_flutter/src/data/model/university.dart';

class FriendsMock {
  List<Friend> friends = [
    Friend(
      userId: 2,
      admissionNumber: 23,
      mutualFriend: 0,
      name: '최현식',
      // phone: '010-1234-5678',
      // signUp: true,
      university: University(id: 1, name: '서울대학교', department: "화학과"),
    ),
    Friend(
      userId: 2,
      admissionNumber: 11,
      mutualFriend: 0,
      name: '최현일',
      // phone: '010-1234-5678',
      // signUp: true,
      university: University(id: 1, name: '서울대학교', department: "화학과"),
    ),
    Friend(
      userId: 2,
      admissionNumber: 12,
      mutualFriend: 0,
      name: '최현이',
      // phone: '010-1234-5678',
      // signUp: true,
      university: University(id: 2, name: '하버드대학교', department: "화학과"),
    ),
    Friend(
      userId: 2,
      admissionNumber: 13,
      mutualFriend: 0,
      name: '최현삼',
      // phone: '010-1234-5678',
      // signUp: true,
      university: University(id: 2, name: '하버드대학교', department: "화학과"),
    ),
    Friend(
      userId: 2,
      admissionNumber: 14,
      mutualFriend: 0,
      name: '최현사',
      // phone: '010-1234-5678',
      // signUp: true,
      university: University(id: 3, name: '서울대학교', department: "소프트웨어융합과"),
    ),
    Friend(
      userId: 2,
      admissionNumber: 15,
      mutualFriend: 0,
      name: '최현오',
      // phone: '010-1234-5678',
      // signUp: true,
      university: University(id: 4, name: '서울대학교', department: "호텔관광학과"),
    ),
    Friend(
      userId: 2,
      admissionNumber: 16,
      mutualFriend: 0,
      name: '최현육',
      // phone: '010-1234-5678',
      // signUp: true,
      university: University(id: 5, name: '조선대학교', department: "글로벌비즈니스커뮤니케이션학과"),
    ),
    Friend(
      userId: 2,
      admissionNumber: 17,
      mutualFriend: 0,
      name: '최현칠',
      // phone: '010-1234-5678',
      // signUp: true,
      university: University(id: 6, name: '서울대학교', department: "경영학과"),
    ),
  ];

  List<Friend> getFriends() {
    return friends;
  }
}
