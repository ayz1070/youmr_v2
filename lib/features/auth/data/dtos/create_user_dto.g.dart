// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreateUserDtoImpl _$$CreateUserDtoImplFromJson(Map<String, dynamic> json) =>
    _$CreateUserDtoImpl(
      uid: json['uid'] as String,
      email: json['email'] as String,
      nickname: json['nickname'] as String,
      name: json['name'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
      userType: json['userType'] as String? ?? '',
      dayOfWeek: json['dayOfWeek'] as String? ?? '',
      fcmToken: json['fcmToken'] as String? ?? '',
    );

Map<String, dynamic> _$$CreateUserDtoImplToJson(_$CreateUserDtoImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'nickname': instance.nickname,
      'name': instance.name,
      'profileImageUrl': instance.profileImageUrl,
      'userType': instance.userType,
      'dayOfWeek': instance.dayOfWeek,
      'fcmToken': instance.fcmToken,
    };
