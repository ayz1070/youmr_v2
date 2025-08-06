import 'package:dartz/dartz.dart';
import 'package:youmr_v2/core/errors/app_failure.dart';
import 'package:youmr_v2/features/notification/domain/entities/notification_settings.dart';
import 'package:youmr_v2/features/notification/domain/repositories/notification_repository.dart';

/// 알림 설정 저장 Use Case
class SaveNotificationSettings {
  final NotificationRepository _repository;

  const SaveNotificationSettings(this._repository);

  /// 알림 설정을 저장합니다.
  /// 
  /// [settings] 저장할 알림 설정
  /// Returns: 성공 시 void, 실패 시 AppFailure
  Future<Either<AppFailure, void>> call(NotificationSettings settings) async {
    return await _repository.saveNotificationSettings(settings);
  }
} 