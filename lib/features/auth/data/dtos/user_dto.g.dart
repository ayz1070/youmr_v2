// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDTO _$UserDTOFromJson(Map<String, dynamic> json) => UserDTO(
  uid: json['uid'] as String,
  email: json['email'] as String,
  nickname: json['nickname'] as String,
  profileImageUrl: json['profile_image_url'] as String,
  userType: json['user_type'] as String,
  dayOfWeek: json['day_of_week'] as String?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$UserDTOToJson(UserDTO instance) => <String, dynamic>{
  'uid': instance.uid,
  'email': instance.email,
  'nickname': instance.nickname,
  'profile_image_url': instance.profileImageUrl,
  'user_type': instance.userType,
  'day_of_week': instance.dayOfWeek,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
};
