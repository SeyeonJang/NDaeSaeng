// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vote_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoteState _$VoteStateFromJson(Map<String, dynamic> json) => VoteState(
      step: $enumDecode(_$VoteStepEnumMap, json['step']),
      voteIterator: json['voteIterator'] as int,
      votes: (json['votes'] as List<dynamic>)
          .map((e) => VoteRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextVoteDateTime: DateTime.parse(json['nextVoteDateTime'] as String),
      friends: (json['friends'] as List<dynamic>)
          .map((e) => Friend.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VoteStateToJson(VoteState instance) => <String, dynamic>{
      'step': _$VoteStepEnumMap[instance.step]!,
      'voteIterator': instance.voteIterator,
      'votes': instance.votes,
      'nextVoteDateTime': instance.nextVoteDateTime.toIso8601String(),
      'friends': instance.friends,
    };

const _$VoteStepEnumMap = {
  VoteStep.start: 'start',
  VoteStep.process: 'process',
  VoteStep.done: 'done',
  VoteStep.wait: 'wait',
};
