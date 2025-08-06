import 'package:dartz/dartz.dart';
import 'package:youmr_v2/core/errors/app_failure.dart';
import 'package:youmr_v2/features/notification/domain/entities/send_notification_params.dart';
import 'package:youmr_v2/features/notification/domain/repositories/notification_repository.dart';

/// 푸시 알림 전송 Use Case
class SendPushNotification {
  final NotificationRepository _repository;

  const SendPushNotification(this._repository);

  /// 푸시 알림을 전송합니다.
  /// 
  /// [params] 전송할 알림 정보
  /// Returns: 성공 시 void, 실패 시 AppFailure
  Future<Either<AppFailure, void>> call(SendNotificationParams params) async {
    return await _repository.sendPushNotification(params);
  }
} 