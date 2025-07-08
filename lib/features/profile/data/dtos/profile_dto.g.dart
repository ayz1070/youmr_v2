// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfileDtoImpl _$$ProfileDtoImplFromJson(Map<String, dynamic> json) =>
    _$ProfileDtoImpl(
      uid: json['uid'] as String,
      nickname: json['nickname'] as String,
      userType: json['userType'] as String,
      profileImageUrl: json['profileImageUrl'] as String?,
      dayOfWeek: json['dayOfWeek'] as String?,
    );

Map<String, dynamic> _$$ProfileDtoImplToJson(_$ProfileDtoImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'nickname': instance.nickname,
      'userType': instance.userType,
      'profileImageUrl': instance.profileImageUrl,
      'dayOfWeek': instance.dayOfWeek,
    };
