import 'package:freezed_annotation/freezed_annotation.dart';

part 'monthly_fee_notification_params.freezed.dart';

/// 회비 공지 알림 전송 파라미터
@freezed
class MonthlyFeeNotificationParams with _$MonthlyFeeNotificationParams {
  const factory MonthlyFeeNotificationParams({
    /// 알림 제목
    @Default('회비 납부 안내') String title,
    
    /// 알림 내용
    @Default('이번 달 회비를 납부해주세요.') String body,
    
    /// 대상 조건: 출석 요일 (null이면 모든 요일)
    int? dayOfWeek,
    
    /// 대상 조건: 사용자 타입
    @Default('offline_member') String userType,
    
    /// 회비 금액
    @Default(50000) int feeAmount,
    
    /// 납부 기한
    required DateTime dueDate,
    
    /// 추가 데이터
    @Default({}) Map<String, dynamic> data,
  }) = _MonthlyFeeNotificationParams;
} 