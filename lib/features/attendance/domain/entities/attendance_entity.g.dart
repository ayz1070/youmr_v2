// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AttendanceEntityImpl _$$AttendanceEntityImplFromJson(
  Map<String, dynamic> json,
) => _$AttendanceEntityImpl(
  weekKey: json['weekKey'] as String,
  userId: json['userId'] as String,
  nickname: json['nickname'] as String,
  profileImageUrl: json['profileImageUrl'] as String,
  selectedDays: (json['selectedDays'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  lastUpdated: json['lastUpdated'] == null
      ? null
      : DateTime.parse(json['lastUpdated'] as String),
);

Map<String, dynamic> _$$AttendanceEntityImplToJson(
  _$AttendanceEntityImpl instance,
) => <String, dynamic>{
  'weekKey': instance.weekKey,
  'userId': instance.userId,
  'nickname': instance.nickname,
  'profileImageUrl': instance.profileImageUrl,
  'selectedDays': instance.selectedDays,
  'lastUpdated': instance.lastUpdated?.toIso8601String(),
};
