import 'package:dartz/dartz.dart';
import 'package:youmr_v2/core/errors/app_failure.dart';
import 'package:youmr_v2/features/notification/domain/entities/notification_settings.dart';
import 'package:youmr_v2/features/notification/domain/repositories/notification_repository.dart';

/// 알림 설정 조회 Use Case
class GetNotificationSettings {
  final NotificationRepository _repository;

  const GetNotificationSettings(this._repository);

  /// 현재 사용자의 알림 설정을 조회합니다.
  /// 
  /// Returns: 성공 시 NotificationSettings, 실패 시 AppFailure
  Future<Either<AppFailure, NotificationSettings>> call() async {
    return await _repository.getNotificationSettings();
  }
} 