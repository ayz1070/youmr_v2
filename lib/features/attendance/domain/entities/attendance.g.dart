// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AttendanceImpl _$$AttendanceImplFromJson(Map<String, dynamic> json) =>
    _$AttendanceImpl(
      weekKey: json['weekKey'] as String,
      userId: json['userId'] as String,
      selectedDays: (json['selectedDays'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      name: json['name'] as String,
      profileImageUrl: json['profileImageUrl'] as String,
      lastUpdated: json['lastUpdated'] == null
          ? null
          : DateTime.parse(json['lastUpdated'] as String),
    );

Map<String, dynamic> _$$AttendanceImplToJson(_$AttendanceImpl instance) =>
    <String, dynamic>{
      'weekKey': instance.weekKey,
      'userId': instance.userId,
      'selectedDays': instance.selectedDays,
      'name': instance.name,
      'profileImageUrl': instance.profileImageUrl,
      'lastUpdated': instance.lastUpdated?.toIso8601String(),
    };
