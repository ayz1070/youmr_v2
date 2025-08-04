import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';

part 'notification_settings.freezed.dart';
part 'notification_settings.g.dart';

/// TimeOfDay JSON 변환기
class TimeOfDayConverter implements JsonConverter<TimeOfDay, String> {
  const TimeOfDayConverter();

  @override
  TimeOfDay fromJson(String json) {
    final parts = json.split(':');
    return TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );
  }

  @override
  String toJson(TimeOfDay timeOfDay) {
    return '${timeOfDay.hour.toString().padLeft(2, '0')}:${timeOfDay.minute.toString().padLeft(2, '0')}';
  }
}

/// 알림 설정 엔티티
@freezed
class NotificationSettings with _$NotificationSettings {
  const factory NotificationSettings({
    /// 사용자 ID
    required String userId,
    
    /// 전체 알림 활성화 여부
    @Default(true) bool isEnabled,
    
    /// 출석 체크 알림 활성화 여부
    @Default(true) bool attendanceReminderEnabled,
    
    /// 회비 알림 활성화 여부
    @Default(true) bool monthlyFeeReminderEnabled,
    
    /// 출석 체크 알림 시간 (기본: 12:00)
    @TimeOfDayConverter()
    @Default(TimeOfDay(hour: 12, minute: 0)) TimeOfDay attendanceReminderTime,
    
    /// 출석 체크 알림 요일 (1-7, 월-일, 기본: 월요일)
    @Default(1) int attendanceReminderDayOfWeek,
    
    /// 생성 시간
    required DateTime createdAt,
    
    /// 수정 시간
    required DateTime updatedAt,
  }) = _NotificationSettings;

  factory NotificationSettings.fromJson(Map<String, dynamic> json) => 
      _$NotificationSettingsFromJson(json);
} 