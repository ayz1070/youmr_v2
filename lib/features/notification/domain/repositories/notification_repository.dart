import 'package:dartz/dartz.dart';
import 'package:youmr_v2/core/errors/app_failure.dart';
import 'package:youmr_v2/features/notification/domain/entities/notification_settings.dart';
import 'package:youmr_v2/features/notification/domain/entities/send_notification_params.dart';

/// 알림 Repository 인터페이스
abstract class NotificationRepository {
  /// FCM 토큰 저장
  Future<Either<AppFailure, void>> saveFcmToken(String token, String? userId);
  
  /// FCM 토큰 삭제
  Future<Either<AppFailure, void>> deleteFcmToken();
  
  /// 사용자별 FCM 토큰 조회
  Future<Either<AppFailure, List<String>>> getFcmTokensByUserIds(List<String> userIds);
  
  /// 특정 사용자의 FCM 토큰 조회
  Future<Either<AppFailure, String?>> getFcmTokenByUserId(String userId);
  
  /// 알림 설정 조회
  Future<Either<AppFailure, NotificationSettings>> getNotificationSettings();
  
  /// 알림 설정 저장
  Future<Either<AppFailure, void>> saveNotificationSettings(NotificationSettings settings);
  
  /// 푸시 알림 전송
  Future<Either<AppFailure, void>> sendPushNotification(SendNotificationParams params);
  
  /// 조건부 푸시 알림 전송
  Future<Either<AppFailure, void>> sendConditionalPushNotification(
    SendNotificationParams params, {
    int? dayOfWeek,
    String? userType,
  });
} 