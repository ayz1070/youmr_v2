// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommentImpl _$$CommentImplFromJson(Map<String, dynamic> json) =>
    _$CommentImpl(
      id: json['id'] as String,
      postId: json['postId'] as String,
      content: json['content'] as String,
      authorId: json['authorId'] as String,
      authorNickname: json['authorNickname'] as String,
      authorProfileUrl: json['authorProfileUrl'] as String?,
      likes:
          (json['likes'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      likeCount: (json['likeCount'] as num?)?.toInt() ?? 0,
      createdAt: DateTime.parse(json['createdAt'] as String),
      serverCreatedAt: json['serverCreatedAt'] == null
          ? null
          : DateTime.parse(json['serverCreatedAt'] as String),
    );

Map<String, dynamic> _$$CommentImplToJson(_$CommentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'postId': instance.postId,
      'content': instance.content,
      'authorId': instance.authorId,
      'authorNickname': instance.authorNickname,
      'authorProfileUrl': instance.authorProfileUrl,
      'likes': instance.likes,
      'likeCount': instance.likeCount,
      'createdAt': instance.createdAt.toIso8601String(),
      'serverCreatedAt': instance.serverCreatedAt?.toIso8601String(),
    };
