// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfileImpl _$$ProfileImplFromJson(Map<String, dynamic> json) =>
    _$ProfileImpl(
      uid: json['uid'] as String,
      nickname: json['nickname'] as String,
      userType: json['userType'] as String,
      profileImageUrl: json['profileImageUrl'] as String?,
      dayOfWeek: json['dayOfWeek'] as String?,
    );

Map<String, dynamic> _$$ProfileImplToJson(_$ProfileImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'nickname': instance.nickname,
      'userType': instance.userType,
      'profileImageUrl': instance.profileImageUrl,
      'dayOfWeek': instance.dayOfWeek,
    };
