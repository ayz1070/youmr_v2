import 'package:dartz/dartz.dart';
import 'package:youmr_v2/core/errors/app_failure.dart';
import 'package:youmr_v2/features/notification/domain/entities/send_notification_params.dart';
import 'package:youmr_v2/features/notification/domain/entities/monthly_fee_notification_params.dart';
import 'package:youmr_v2/features/notification/domain/repositories/notification_repository.dart';

/// 회비 공지 알림 전송 Use Case
class SendMonthlyFeeNotification {
  final NotificationRepository _repository;

  const SendMonthlyFeeNotification(this._repository);

  /// 특정 요일 출석 + offline_member 사용자들에게 회비 공지 알림을 전송합니다.
  /// 
  /// [params] 회비 공지 알림 파라미터
  /// Returns: 성공 시 void, 실패 시 AppFailure
  Future<Either<AppFailure, void>> call(MonthlyFeeNotificationParams params) async {
    try {
      // 조건에 맞는 사용자들에게 알림 전송
      final notificationParams = SendNotificationParams(
        title: params.title,
        body: _generateNotificationBody(params),
        type: 'monthly_fee_notice',
        userIds: [], // 빈 리스트로 설정하여 조건부 조회 사용
        data: {
          'type': 'monthly_fee_notice',
          'feeAmount': params.feeAmount,
          'dueDate': params.dueDate.toIso8601String(),
          'dayOfWeek': params.dayOfWeek,
          'userType': params.userType,
          ...params.data,
        },
      );
      
      return await _repository.sendConditionalPushNotification(
        notificationParams,
        dayOfWeek: params.dayOfWeek,
        userType: params.userType,
      );
    } catch (e) {
      return Left(AppFailure.serverError(e.toString()));
    }
  }

  /// 알림 내용 생성
  String _generateNotificationBody(MonthlyFeeNotificationParams params) {
    final dueDateStr = '${params.dueDate.month}월 ${params.dueDate.day}일';
    final feeAmountStr = '${(params.feeAmount / 10000).toInt()}만원';
    final dayOfWeekStr = _getDayOfWeekString(params.dayOfWeek);
    
    return '${params.body}\n\n'
           '💰 회비: $feeAmountStr\n'
           '📅 납부기한: $dueDateStr\n\n'
           '$dayOfWeekStr 출석 회원분들께 안내드립니다.';
  }

  /// 요일 문자열 반환
  String _getDayOfWeekString(int? dayOfWeek) {
    if (dayOfWeek == null) return '모든';
    
    switch (dayOfWeek) {
      case 1: return '월요일';
      case 2: return '화요일';
      case 3: return '수요일';
      case 4: return '목요일';
      case 5: return '금요일';
      case 6: return '토요일';
      case 7: return '일요일';
      default: return '모든';
    }
  }
} 