import 'package:freezed_annotation/freezed_annotation.dart';

part 'push_notification_dto.freezed.dart';
part 'push_notification_dto.g.dart';

/// 푸시 알림 DTO
@freezed
class PushNotificationDto with _$PushNotificationDto {
  const factory PushNotificationDto({
    /// 알림 ID
    required String id,
    
    /// 사용자 ID
    required String userId,
    
    /// 알림 제목
    required String title,
    
    /// 알림 내용
    required String body,
    
    /// 알림 타입 (attendance, monthly_fee, general)
    required String type,
    
    /// 추가 데이터
    @Default({}) Map<String, dynamic> data,
    
    /// 생성 시간
    required DateTime createdAt,
    
    /// 읽음 여부
    @Default(false) bool isRead,
  }) = _PushNotificationDto;

  factory PushNotificationDto.fromJson(Map<String, dynamic> json) => 
      _$PushNotificationDtoFromJson(json);
} 