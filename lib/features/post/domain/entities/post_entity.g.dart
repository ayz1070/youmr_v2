// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostEntityImpl _$$PostEntityImplFromJson(Map<String, dynamic> json) =>
    _$PostEntityImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      authorId: json['authorId'] as String,
      authorNickname: json['authorNickname'] as String,
      authorProfileUrl: json['authorProfileUrl'] as String,
      category: json['category'] as String,
      youtubeUrl: json['youtubeUrl'] as String?,
      isNotice: json['isNotice'] as bool?,
      likes: (json['likes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      likesCount: (json['likesCount'] as num?)?.toInt(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$PostEntityImplToJson(_$PostEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'authorId': instance.authorId,
      'authorNickname': instance.authorNickname,
      'authorProfileUrl': instance.authorProfileUrl,
      'category': instance.category,
      'youtubeUrl': instance.youtubeUrl,
      'isNotice': instance.isNotice,
      'likes': instance.likes,
      'likesCount': instance.likesCount,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
