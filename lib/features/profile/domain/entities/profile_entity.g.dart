// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfileEntityImpl _$$ProfileEntityImplFromJson(Map<String, dynamic> json) =>
    _$ProfileEntityImpl(
      id: json['id'] as String,
      email: json['email'] as String,
      nickname: json['nickname'] as String,
      userType: json['userType'] as String,
      profileImageUrl: json['profileImageUrl'] as String,
      dayOfWeek: json['dayOfWeek'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$ProfileEntityImplToJson(_$ProfileEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'nickname': instance.nickname,
      'userType': instance.userType,
      'profileImageUrl': instance.profileImageUrl,
      'dayOfWeek': instance.dayOfWeek,
      'createdAt': instance.createdAt.toIso8601String(),
    };
