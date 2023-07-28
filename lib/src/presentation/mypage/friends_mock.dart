import 'package:dart_flutter/src/data/model/friend.dart';
import 'package:dart_flutter/src/data/model/university.dart';

class FriendsMock {
  List<Friend> friends = [
    Friend(
      userId: 2,
      admissionYear: 2023,
      name: '최현식',
      // phone: '010-1234-5678',
      // signUp: true,
      university: University(id: 1, name: '서울대학교', department: "화학과"),
    ),
    Friend(
      userId: 2,
      admissionYear: 2011,
      name: '최현일',
      // phone: '010-1234-5678',
      // signUp: true,
      university: University(id: 1, name: '서울대학교', department: "화학과"),
    ),
    // Friend(
    //   userId: 2,
    //   admissionYear: 2012,
    //   name: '최현이',
    //   // phone: '010-1234-5678',
    //   // signUp: true,
    //   university: University(id: 2, name: '하버드대학교', department: "화학과"),
    // ),
    // Friend(
    //   userId: 2,
    //   admissionYear: 2013,
    //   name: '최현삼',
    //   // phone: '010-1234-5678',
    //   // signUp: true,
    //   university: University(id: 2, name: '하버드대학교', department: "화학과"),
    // ),
    // Friend(
    //   userId: 2,
    //   admissionYear: 2014,
    //   name: '최현사',
    //   // phone: '010-1234-5678',
    //   // signUp: true,
    //   university: University(id: 3, name: '서울대학교', department: "소프트웨어융합과"),
    // ),
    // Friend(
    //   userId: 2,
    //   admissionYear: 2015,
    //   name: '최현오',
    //   // phone: '010-1234-5678',
    //   // signUp: true,
    //   university: University(id: 4, name: '서울대학교', department: "호텔관광학과"),
    // ),
    // Friend(
    //   userId: 2,
    //   admissionYear: 2016,
    //   name: '최현육',
    //   // phone: '010-1234-5678',
    //   // signUp: true,
    //   university: University(id: 5, name: '조선대학교', department: "글로벌비즈니스커뮤니케이션학과"),
    // ),
    // Friend(
    //   userId: 2,
    //   admissionYear: 2017,
    //   name: '최현칠',
    //   // phone: '010-1234-5678',
    //   // signUp: true,
    //   university: University(id: 6, name: '서울대학교', department: "경영학과"),
    // ),
  ];

  List<Friend> getFriends() {
    return friends;
  }
}
