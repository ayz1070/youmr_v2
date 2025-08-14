// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserResponseDtoImpl _$$UserResponseDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$UserResponseDtoImpl(
      uid: json['uid'] as String,
      email: json['email'] as String,
      nickname: json['nickname'] as String,
      name: json['name'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
      userType: json['userType'] as String?,
      dayOfWeek: json['dayOfWeek'] as String?,
      fcmToken: json['fcmToken'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      lastUpdated: json['lastUpdated'] == null
          ? null
          : DateTime.parse(json['lastUpdated'] as String),
    );

Map<String, dynamic> _$$UserResponseDtoImplToJson(
        _$UserResponseDtoImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'nickname': instance.nickname,
      'name': instance.name,
      'profileImageUrl': instance.profileImageUrl,
      'userType': instance.userType,
      'dayOfWeek': instance.dayOfWeek,
      'fcmToken': instance.fcmToken,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'lastUpdated': instance.lastUpdated?.toIso8601String(),
    };
