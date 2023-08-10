import 'package:dart_flutter/src/data/model/friend_dto.dart';
import 'package:dart_flutter/src/data/model/university_dto.dart';

void main() {
  FriendDto abcde = FriendDto(
    userId: 20,
    name: 'Robert',
    admissionYear: 1983,
    gender: 'male',
    university: UniversityDto(
      id: 20,
      name: 'Columbia University',
      department: 'Business Administration',
    ),
  );



  List<FriendDto> friends = [
    FriendDto(
      userId: 1,
      name: 'John',
      admissionYear: 2003,
      gender: 'male',
      university: UniversityDto(
        id: 1,
        name: 'Harvard University',
        department: 'Computer Science',
      ),
    ),
    FriendDto(
      userId: 2,
      name: 'Mary',
      admissionYear: 2002,
      gender: 'female',
      university: UniversityDto(
        id: 2,
        name: 'Stanford University',
        department: 'Mechanical Engineering',
      ),
    ),
    FriendDto(
      userId: 3,
      name: 'Michael',
      admissionYear: 2001,
      gender: 'male',
      university: UniversityDto(
        id: 3,
        name: 'MIT',
        department: 'Electrical Engineering',
      ),
    ),
    FriendDto(
      userId: 4,
      name: 'Jennifer',
      admissionYear: 2000,
      gender: 'female',
      university: UniversityDto(
        id: 4,
        name: 'Yale University',
        department: 'Literature',
      ),
    ),
    // Add more Friend objects here...
    FriendDto(
      userId: 20,
      name: 'Robert',
      admissionYear: 1983,
      gender: 'male',
      university: UniversityDto(
        id: 20,
        name: 'Columbia University',
        department: 'Business Administration',
      ),
    ),
    abcde,
  ];


  friends.remove(abcde);

  print(friends.toString());
  print(friends.length);
}
