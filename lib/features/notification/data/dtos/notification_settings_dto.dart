import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_settings_dto.freezed.dart';
part 'notification_settings_dto.g.dart';

/// 알림 설정 DTO
@freezed
class NotificationSettingsDto with _$NotificationSettingsDto {
  const factory NotificationSettingsDto({
    /// 사용자 ID
    required String userId,
    
    /// 전체 알림 활성화 여부
    @Default(true) bool isEnabled,
    
    /// 출석 체크 알림 활성화 여부
    @Default(true) bool attendanceReminderEnabled,
    
    /// 회비 알림 활성화 여부
    @Default(true) bool monthlyFeeReminderEnabled,
    
    /// 출석 체크 알림 시간 (HH:mm 형식)
    @Default('12:00') String attendanceReminderTime,
    
    /// 출석 체크 알림 요일 (1-7, 월-일)
    @Default(1) int attendanceReminderDayOfWeek,
    
    /// 생성 시간
    required DateTime createdAt,
    
    /// 수정 시간
    required DateTime updatedAt,
  }) = _NotificationSettingsDto;

  factory NotificationSettingsDto.fromJson(Map<String, dynamic> json) => 
      _$NotificationSettingsDtoFromJson(json);
} 