// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_vote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserVoteImpl _$$UserVoteImplFromJson(Map<String, dynamic> json) =>
    _$UserVoteImpl(
      userId: json['userId'] as String,
      voteId: json['voteId'] as String,
      votedAt: DateTime.parse(json['votedAt'] as String),
    );

Map<String, dynamic> _$$UserVoteImplToJson(_$UserVoteImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'voteId': instance.voteId,
      'votedAt': instance.votedAt.toIso8601String(),
    };
