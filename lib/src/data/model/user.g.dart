// // GENERATED CODE - DO NOT MODIFY BY HAND
//
// part of 'user.dart';
//
// // **************************************************************************
// // JsonSerializableGenerator
// // **************************************************************************
//
// UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
//       userId: json['userId'] as int?,
//       univId: json['univId'] as int?,
//       admissionNumber: json['admissionNumber'] as int?,
//       point: json['point'] as int?,
//       name: json['name'] as String?,
//       phone: json['phone'] as String?,
//       universityName: json['universityName'] as String?,
//       department: json['department'] as String?,
//       nextVoteDateTime: json['nextVoteDateTime'] == null
//           ? null
//           : DateTime.parse(json['nextVoteDateTime'] as String),
//     );
//
// Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
//     <String, dynamic>{
//       'userId': instance.userId,
//       'univId': instance.univId,
//       'admissionNumber': instance.admissionNumber,
//       'point': instance.point,
//       'name': instance.name,
//       'phone': instance.phone,
//       'universityName': instance.universityName,
//       'department': instance.department,
//       'nextVoteDateTime': instance.nextVoteDateTime?.toIso8601String(),
//     };
