// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vote_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VoteDtoImpl _$$VoteDtoImplFromJson(Map<String, dynamic> json) =>
    _$VoteDtoImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      artist: json['artist'] as String,
      youtubeUrl: json['youtubeUrl'] as String?,
      voteCount: (json['voteCount'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      createdBy: json['createdBy'] as String,
    );

Map<String, dynamic> _$$VoteDtoImplToJson(_$VoteDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'artist': instance.artist,
      'youtubeUrl': instance.youtubeUrl,
      'voteCount': instance.voteCount,
      'createdAt': instance.createdAt.toIso8601String(),
      'createdBy': instance.createdBy,
    };
