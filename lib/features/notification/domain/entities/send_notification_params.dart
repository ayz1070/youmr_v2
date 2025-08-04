import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_notification_params.freezed.dart';

/// 푸시 알림 전송 파라미터
@freezed
class SendNotificationParams with _$SendNotificationParams {
  const factory SendNotificationParams({
    /// 알림 제목
    required String title,
    
    /// 알림 내용
    required String body,
    
    /// 알림 타입
    @Default('general') String type,
    
    /// 대상 사용자 ID 리스트 (빈 리스트면 모든 사용자)
    @Default([]) List<String> userIds,
    
    /// 추가 데이터
    @Default({}) Map<String, dynamic> data,
    
    /// 이미지 URL (선택사항)
    String? imageUrl,
  }) = _SendNotificationParams;
} 