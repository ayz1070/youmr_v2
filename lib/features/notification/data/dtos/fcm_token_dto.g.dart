// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fcm_token_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FcmTokenDtoImpl _$$FcmTokenDtoImplFromJson(Map<String, dynamic> json) =>
    _$FcmTokenDtoImpl(
      userId: json['userId'] as String,
      token: json['token'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deviceInfo: json['deviceInfo'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$FcmTokenDtoImplToJson(_$FcmTokenDtoImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'token': instance.token,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'deviceInfo': instance.deviceInfo,
    };
