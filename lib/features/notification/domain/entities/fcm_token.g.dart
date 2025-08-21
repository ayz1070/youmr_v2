// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fcm_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FcmTokenImpl _$$FcmTokenImplFromJson(Map<String, dynamic> json) =>
    _$FcmTokenImpl(
      userId: json['userId'] as String,
      token: json['token'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deviceInfo: json['deviceInfo'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$FcmTokenImplToJson(_$FcmTokenImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'token': instance.token,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'deviceInfo': instance.deviceInfo,
    };
