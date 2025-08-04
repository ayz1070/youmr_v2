import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:youmr_v2/core/errors/app_failure.dart';
import 'package:youmr_v2/features/notification/domain/entities/notification_settings.dart';
import 'package:youmr_v2/features/notification/domain/entities/send_notification_params.dart';
import 'package:youmr_v2/features/notification/domain/use_cases/get_notification_settings.dart';
import 'package:youmr_v2/features/notification/domain/use_cases/save_notification_settings.dart';
import 'package:youmr_v2/features/notification/domain/use_cases/save_fcm_token.dart';
import 'package:youmr_v2/features/notification/domain/use_cases/delete_fcm_token.dart';
import 'package:youmr_v2/features/notification/domain/use_cases/send_push_notification.dart';
import 'package:youmr_v2/features/notification/data/repositories/notification_repository_impl.dart';
import 'package:youmr_v2/features/notification/data/data_sources/fcm_data_source.dart';
import 'package:youmr_v2/features/notification/data/data_sources/notification_local_data_source.dart';
import 'package:youmr_v2/core/services/notification_scheduler.dart';

/// 알림 설정 상태
class NotificationState {
  final AsyncValue<NotificationSettings> settings;
  final bool isLoading;

  const NotificationState({
    this.settings = const AsyncValue.loading(),
    this.isLoading = false,
  });

  NotificationState copyWith({
    AsyncValue<NotificationSettings>? settings,
    bool? isLoading,
  }) {
    return NotificationState(
      settings: settings ?? this.settings,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

/// 알림 Provider Notifier
class NotificationNotifier extends StateNotifier<NotificationState> {
  final GetNotificationSettings _getNotificationSettings;
  final SaveNotificationSettings _saveNotificationSettings;
  final SaveFcmToken _saveFcmToken;
  final DeleteFcmToken _deleteFcmToken;
  final SendPushNotification _sendPushNotification;
  final NotificationScheduler _scheduler;

  NotificationNotifier({
    required GetNotificationSettings getNotificationSettings,
    required SaveNotificationSettings saveNotificationSettings,
    required SaveFcmToken saveFcmToken,
    required DeleteFcmToken deleteFcmToken,
    required SendPushNotification sendPushNotification,
  })  : _getNotificationSettings = getNotificationSettings,
        _saveNotificationSettings = saveNotificationSettings,
        _saveFcmToken = saveFcmToken,
        _deleteFcmToken = deleteFcmToken,
        _sendPushNotification = sendPushNotification,
        _scheduler = NotificationScheduler(),
        super(const NotificationState());

  /// 알림 설정 로드
  Future<void> loadNotificationSettings() async {
    state = state.copyWith(isLoading: true);
    
    final result = await _getNotificationSettings();
    
    result.fold(
      (failure) {
        state = state.copyWith(
          settings: AsyncValue.error(failure, StackTrace.current),
          isLoading: false,
        );
      },
      (settings) {
        state = state.copyWith(
          settings: AsyncValue.data(settings),
          isLoading: false,
        );
      },
    );
  }

  /// 알림 설정 업데이트
  Future<void> updateNotificationSettings(NotificationSettings settings) async {
    state = state.copyWith(isLoading: true);
    
    final result = await _saveNotificationSettings(settings);
    
    result.fold(
      (failure) {
        state = state.copyWith(
          settings: AsyncValue.error(failure, StackTrace.current),
          isLoading: false,
        );
      },
      (_) async {
        // 알림 스케줄링 업데이트
        await _updateNotificationSchedules(settings);
        
        state = state.copyWith(
          settings: AsyncValue.data(settings),
          isLoading: false,
        );
      },
    );
  }

  /// 알림 스케줄링 업데이트
  Future<void> _updateNotificationSchedules(NotificationSettings settings) async {
    try {
      if (!settings.isEnabled) {
        // 전체 알림이 비활성화된 경우 모든 스케줄 취소
        await _scheduler.cancelAllScheduledNotifications(settings.userId);
        return;
      }

      // 출석 체크 알림 스케줄링
      if (settings.attendanceReminderEnabled) {
        await _scheduler.scheduleAttendanceReminder(
          userId: settings.userId,
          dayOfWeek: settings.attendanceReminderDayOfWeek,
          time: settings.attendanceReminderTime,
        );
      } else {
        await _scheduler.cancelScheduledNotifications(settings.userId, 'attendance');
      }

      // 회비 알림 스케줄링
      if (settings.monthlyFeeReminderEnabled) {
        await _scheduler.scheduleMonthlyFeeReminder(
          userId: settings.userId,
          dayOfMonth: 1, // 매월 1일
        );
      } else {
        await _scheduler.cancelScheduledNotifications(settings.userId, 'monthly_fee');
      }
    } catch (e) {
      debugPrint('알림 스케줄링 업데이트 실패: $e');
    }
  }

  /// FCM 토큰 저장
  Future<void> saveFcmToken(String token, {String? userId}) async {
    final result = await _saveFcmToken(SaveFcmTokenParams(
      token: token,
      userId: userId,
    ));
    
    result.fold(
      (failure) {
        // 토큰 저장 실패 시 에러 처리
        state = state.copyWith(
          settings: AsyncValue.error(failure, StackTrace.current),
        );
      },
      (_) {
        // 토큰 저장 성공
      },
    );
  }

  /// FCM 토큰 삭제
  Future<void> deleteFcmToken() async {
    final result = await _deleteFcmToken();
    
    result.fold(
      (failure) {
        // 토큰 삭제 실패 시 에러 처리
        state = state.copyWith(
          settings: AsyncValue.error(failure, StackTrace.current),
        );
      },
      (_) {
        // 토큰 삭제 성공
      },
    );
  }

  /// 푸시 알림 전송
  Future<Either<AppFailure, void>> sendPushNotification(SendNotificationParams params) async {
    return await _sendPushNotification(params);
  }
}

/// FCM 데이터 소스 Provider
final fcmDataSourceProvider = Provider<FcmDataSource>((ref) {
  return FcmFirestoreDataSource();
});

/// 알림 로컬 데이터 소스 Provider
final notificationLocalDataSourceProvider = Provider<NotificationLocalDataSource>((ref) {
  return NotificationHiveDataSource();
});

/// 알림 Repository Provider
final notificationRepositoryProvider = Provider<NotificationRepositoryImpl>((ref) {
  return NotificationRepositoryImpl(
    fcmDataSource: ref.watch(fcmDataSourceProvider),
    localDataSource: ref.watch(notificationLocalDataSourceProvider),
    firebaseAuth: FirebaseAuth.instance,
  );
});

/// 알림 Provider
final notificationProvider = StateNotifierProvider<NotificationNotifier, NotificationState>((ref) {
  final repository = ref.watch(notificationRepositoryProvider);
  
  return NotificationNotifier(
    getNotificationSettings: GetNotificationSettings(repository),
    saveNotificationSettings: SaveNotificationSettings(repository),
    saveFcmToken: SaveFcmToken(repository),
    deleteFcmToken: DeleteFcmToken(repository),
    sendPushNotification: SendPushNotification(repository),
  );
}); 