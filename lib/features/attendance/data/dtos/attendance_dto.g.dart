// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AttendanceDtoImpl _$$AttendanceDtoImplFromJson(Map<String, dynamic> json) =>
    _$AttendanceDtoImpl(
      weekKey: json['weekKey'] as String,
      userId: json['userId'] as String,
      selectedDays: (json['selectedDays'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      name: json['name'] as String,
      profileImageUrl: json['profileImageUrl'] as String,
      lastUpdated: _fromTimestamp(json['last_updated']),
    );

Map<String, dynamic> _$$AttendanceDtoImplToJson(_$AttendanceDtoImpl instance) =>
    <String, dynamic>{
      'weekKey': instance.weekKey,
      'userId': instance.userId,
      'selectedDays': instance.selectedDays,
      'name': instance.name,
      'profileImageUrl': instance.profileImageUrl,
      'last_updated': _toTimestamp(instance.lastUpdated),
    };
