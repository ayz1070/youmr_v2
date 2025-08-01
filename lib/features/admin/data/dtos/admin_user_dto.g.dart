// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AdminUserDtoImpl _$$AdminUserDtoImplFromJson(Map<String, dynamic> json) =>
    _$AdminUserDtoImpl(
      uid: json['uid'] as String,
      nickname: json['nickname'] as String,
      email: json['email'] as String,
      userType: json['user_type'] as String,
      profileImageUrl: json['profile_image_url'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$AdminUserDtoImplToJson(_$AdminUserDtoImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'nickname': instance.nickname,
      'email': instance.email,
      'user_type': instance.userType,
      'profile_image_url': instance.profileImageUrl,
      'created_at': instance.createdAt.toIso8601String(),
    };
