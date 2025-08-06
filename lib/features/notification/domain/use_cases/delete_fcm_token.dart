import 'package:dartz/dartz.dart';
import 'package:youmr_v2/core/errors/app_failure.dart';
import 'package:youmr_v2/features/notification/domain/repositories/notification_repository.dart';

/// FCM 토큰 삭제 Use Case
class DeleteFcmToken {
  final NotificationRepository _repository;

  const DeleteFcmToken(this._repository);

  /// 현재 사용자의 FCM 토큰을 삭제합니다.
  /// 
  /// Returns: 성공 시 void, 실패 시 AppFailure
  Future<Either<AppFailure, void>> call() async {
    return await _repository.deleteFcmToken();
  }
} 