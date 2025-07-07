// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AdminUserEntityImpl _$$AdminUserEntityImplFromJson(
  Map<String, dynamic> json,
) => _$AdminUserEntityImpl(
  id: json['id'] as String,
  email: json['email'] as String,
  nickname: json['nickname'] as String,
  userType: json['userType'] as String,
  profileImageUrl: json['profileImageUrl'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$$AdminUserEntityImplToJson(
  _$AdminUserEntityImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'nickname': instance.nickname,
  'userType': instance.userType,
  'profileImageUrl': instance.profileImageUrl,
  'createdAt': instance.createdAt.toIso8601String(),
};
