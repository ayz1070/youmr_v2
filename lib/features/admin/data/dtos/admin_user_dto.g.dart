// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AdminUserDtoImpl _$$AdminUserDtoImplFromJson(Map<String, dynamic> json) =>
    _$AdminUserDtoImpl(
      uid: json['uid'] as String?,
      nickname: json['nickname'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      userType: json['userType'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
    );

Map<String, dynamic> _$$AdminUserDtoImplToJson(_$AdminUserDtoImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'nickname': instance.nickname,
      'name': instance.name,
      'email': instance.email,
      'userType': instance.userType,
      'profileImageUrl': instance.profileImageUrl,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };
