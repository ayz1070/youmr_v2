// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vote_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

// 중복 선언 제거: 아래 함수가 한 번만 존재해야 함
_$VoteDtoImpl _$$VoteDtoImplFromJson(Map<String, dynamic> json) =>
    _$VoteDtoImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      artist: json['artist'] as String,
      youtubeUrl: json['youtubeUrl'] as String?,
      voteCount: (json['voteCount'] as num).toInt(),
      createdAt: const TimestampOrDateTimeConverter()
          .fromJson(json['createdAt'] as Object),
      createdBy: json['createdBy'] as String,
    );

Map<String, dynamic> _$$VoteDtoImplToJson(_$VoteDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'artist': instance.artist,
      'youtubeUrl': instance.youtubeUrl,
      'voteCount': instance.voteCount,
      'createdAt':
          const TimestampOrDateTimeConverter().toJson(instance.createdAt),
      'createdBy': instance.createdBy,
    };
