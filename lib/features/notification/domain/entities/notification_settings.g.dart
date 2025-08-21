// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationSettingsImpl _$$NotificationSettingsImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationSettingsImpl(
      userId: json['userId'] as String,
      isEnabled: json['isEnabled'] as bool? ?? true,
      attendanceReminderEnabled:
          json['attendanceReminderEnabled'] as bool? ?? true,
      monthlyFeeReminderEnabled:
          json['monthlyFeeReminderEnabled'] as bool? ?? true,
      attendanceReminderTime: json['attendanceReminderTime'] == null
          ? const TimeOfDay(hour: 12, minute: 0)
          : const TimeOfDayConverter()
              .fromJson(json['attendanceReminderTime'] as String),
      attendanceReminderDayOfWeek:
          (json['attendanceReminderDayOfWeek'] as num?)?.toInt() ?? 1,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$NotificationSettingsImplToJson(
        _$NotificationSettingsImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'isEnabled': instance.isEnabled,
      'attendanceReminderEnabled': instance.attendanceReminderEnabled,
      'monthlyFeeReminderEnabled': instance.monthlyFeeReminderEnabled,
      'attendanceReminderTime':
          const TimeOfDayConverter().toJson(instance.attendanceReminderTime),
      'attendanceReminderDayOfWeek': instance.attendanceReminderDayOfWeek,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
