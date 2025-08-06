// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommentDtoImpl _$$CommentDtoImplFromJson(Map<String, dynamic> json) =>
    _$CommentDtoImpl(
      id: json['id'] as String,
      postId: json['postId'] as String,
      content: json['content'] as String,
      authorId: json['authorId'] as String,
      authorNickname: json['authorNickname'] as String,
      authorProfileUrl: json['authorProfileUrl'] as String?,
      likes:
          (json['likes'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      likesCount: (json['likesCount'] as num?)?.toInt() ?? 0,
      createdAt: DateTime.parse(json['createdAt'] as String),
      serverCreatedAt: json['serverCreatedAt'] == null
          ? null
          : DateTime.parse(json['serverCreatedAt'] as String),
    );

Map<String, dynamic> _$$CommentDtoImplToJson(_$CommentDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'postId': instance.postId,
      'content': instance.content,
      'authorId': instance.authorId,
      'authorNickname': instance.authorNickname,
      'authorProfileUrl': instance.authorProfileUrl,
      'likes': instance.likes,
      'likesCount': instance.likesCount,
      'createdAt': instance.createdAt.toIso8601String(),
      'serverCreatedAt': instance.serverCreatedAt?.toIso8601String(),
    };
