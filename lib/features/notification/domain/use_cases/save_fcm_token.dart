import 'package:dartz/dartz.dart';
import 'package:youmr_v2/core/errors/app_failure.dart';
import 'package:youmr_v2/features/notification/domain/repositories/notification_repository.dart';

/// FCM 토큰 저장 파라미터
class SaveFcmTokenParams {
  /// FCM 토큰
  final String token;
  
  /// 사용자 ID (선택사항, null이면 현재 로그인된 사용자)
  final String? userId;

  const SaveFcmTokenParams({
    required this.token,
    this.userId,
  });
}

/// FCM 토큰 저장 Use Case
class SaveFcmToken {
  final NotificationRepository _repository;

  const SaveFcmToken(this._repository);

  /// FCM 토큰을 저장합니다.
  /// 
  /// [params] 저장할 토큰 정보
  /// Returns: 성공 시 void, 실패 시 AppFailure
  Future<Either<AppFailure, void>> call(SaveFcmTokenParams params) async {
    return await _repository.saveFcmToken(params.token, params.userId);
  }
} 