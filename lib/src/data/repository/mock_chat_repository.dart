// import 'package:dart_flutter/src/domain/entity/blind_date_team.dart';
// import 'package:dart_flutter/src/domain/entity/chat_message.dart';
// import 'package:dart_flutter/src/domain/entity/chat_room_detail.dart';
// import 'package:dart_flutter/src/domain/entity/location.dart';
// import 'package:dart_flutter/src/domain/entity/chat_room.dart';
// import 'package:dart_flutter/src/domain/entity/type/blind_date_user.dart';
// import 'package:dart_flutter/src/domain/entity/user.dart';
// import 'package:dart_flutter/src/domain/repository/chat_repository.dart';
//
// class MockChatRepository implements ChatRepository {
//   static final List<ChatRoom> mockChatRooms = [
//     ChatRoom(
//       id: 1,
//       myTeam: BlindDateTeam(
//           id: 10,
//           name: '우리 팀이에요 :)',
//           averageBirthYear: 2022.5,
//           regions: [ Location(id: 0, name: '서울') ],
//           universityName: '가톨릭대학교',
//           isCertifiedTeam: true,
//           teamUsers: [
//             BlindDateUser(
//                 id: 20,
//                 name: '장세연',
//                 profileImageUrl: 'https://i.pinimg.com/1200x/98/18/05/9818050fe90f779aa89d41044400b36b.jpg',
//                 department: '컴퓨터정보공학부'
//             ),
//             BlindDateUser(
//                 id: 21,
//                 name: '장하니',
//                 profileImageUrl: 'https://img.hankyung.com/photo/202209/p1065589384443518_204_thum.png',
//                 department: '범죄심리학과'
//             ),
//             BlindDateUser(
//                 id: 22,
//                 name: '이주은',
//                 profileImageUrl: 'https://www.meme-arsenal.com/memes/bfe13ac70856af0393c810dd0eab54f9.jpg',
//                 department: '극작과'
//             ),
//           ]
//       ),
//       otherTeam: BlindDateTeam(
//           id: 11,
//           name: '상대 팀입니다-!',
//           averageBirthYear: 2023.5,
//           regions: [ Location(id: 0, name: '서울'), Location(id: 1, name: '인천') ],
//           universityName: '성균관대학교',
//           isCertifiedTeam: true,
//           teamUsers: [
//             BlindDateUser(
//                 id: 23,
//                 name: '성서진',
//                 profileImageUrl: 'https://thumb.mtstarnews.com/06/2022/03/2022033018491188462_1.jpg',
//                 department: '정보통신전자공학부'
//             ),
//             BlindDateUser(
//                 id: 24,
//                 name: '이승열',
//                 profileImageUrl: 'https://www.jeonmae.co.kr/news/photo/202206/896923_588697_2015.jpeg',
//                 department: '컴퓨터공학과'
//             ),
//             BlindDateUser(
//                 id: 25,
//                 name: '최현식',
//                 profileImageUrl: 'https://images.chosun.com/resizer/T_O6__-g6jMXsnVKAzXNNjyaQOo=/802x1069/smart/cloudfront-ap-northeast-1.images.arcpublishing.com/chosun/HGWRQLS7RZE4RAPEMMVENMIGJ4.JPG',
//                 department: '컴퓨터공학과'
//             ),
//           ]
//       ),
//       message: ChatMessage(userId: 24, message: '만나쟈 8', sendTime: DateTime(2023, 9, 11, 15, 20))
//       // messages: [
//       //   ChatMessage(userId: 20, message: '하이 1', sendTime: DateTime(2023, 9, 11, 14, 30)),
//       //   ChatMessage(userId: 21, message: '안녕 2', sendTime: DateTime(2023, 9, 11, 14, 31)),
//       //   ChatMessage(userId: 22, message: '반가워 3', sendTime: DateTime(2023, 9, 11, 14, 32)),
//       //   ChatMessage(userId: 23, message: '나도 4', sendTime: DateTime(2023, 9, 11, 14, 33)),
//       //   ChatMessage(userId: 24, message: '안녀엉 5', sendTime: DateTime(2023, 9, 11, 14, 34)),
//       //   ChatMessage(userId: 25, message: '메시지 6', sendTime: DateTime(2023, 9, 11, 14, 35)),
//       //   ChatMessage(userId: 20, message: '메시징 7', sendTime: DateTime(2023, 9, 11, 14, 40)),
//       //   ChatMessage(userId: 24, message: '만나쟈 8', sendTime: DateTime(2023, 9, 11, 15, 20))]
//     )
//   ];
//
//   @override
//   Future<List<ChatRoom>> getChatRooms() async {
//     return mockChatRooms;
//   }
//
//   @override
//   Future<ChatRoomDetail> getChatRoomDetail(int teamId) async {
//     return mockChatRooms.map((mockChatRoom) => mockChatRoom.id == teamId ? mockChatRoom : throw Error()).first;
//   }
// }