// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_settings_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationSettingsDtoImpl _$$NotificationSettingsDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationSettingsDtoImpl(
      userId: json['userId'] as String,
      isEnabled: json['isEnabled'] as bool? ?? true,
      attendanceReminderEnabled:
          json['attendanceReminderEnabled'] as bool? ?? true,
      monthlyFeeReminderEnabled:
          json['monthlyFeeReminderEnabled'] as bool? ?? true,
      attendanceReminderTime:
          json['attendanceReminderTime'] as String? ?? '12:00',
      attendanceReminderDayOfWeek:
          (json['attendanceReminderDayOfWeek'] as num?)?.toInt() ?? 1,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$NotificationSettingsDtoImplToJson(
        _$NotificationSettingsDtoImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'isEnabled': instance.isEnabled,
      'attendanceReminderEnabled': instance.attendanceReminderEnabled,
      'monthlyFeeReminderEnabled': instance.monthlyFeeReminderEnabled,
      'attendanceReminderTime': instance.attendanceReminderTime,
      'attendanceReminderDayOfWeek': instance.attendanceReminderDayOfWeek,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
