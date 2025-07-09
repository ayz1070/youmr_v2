// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_vote_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserVoteDtoImpl _$$UserVoteDtoImplFromJson(Map<String, dynamic> json) =>
    _$UserVoteDtoImpl(
      userId: json['userId'] as String,
      voteId: json['voteId'] as String,
      votedAt: DateTime.parse(json['votedAt'] as String),
    );

Map<String, dynamic> _$$UserVoteDtoImplToJson(_$UserVoteDtoImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'voteId': instance.voteId,
      'votedAt': instance.votedAt.toIso8601String(),
    };
