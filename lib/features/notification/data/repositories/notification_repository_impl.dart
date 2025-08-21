import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:youmr_v2/core/errors/app_failure.dart';
import 'package:youmr_v2/features/notification/data/data_sources/fcm_data_source.dart';
import 'package:youmr_v2/features/notification/data/data_sources/notification_local_data_source.dart';
import 'package:youmr_v2/features/notification/data/dtos/notification_settings_dto.dart';
import 'package:youmr_v2/features/notification/domain/entities/notification_settings.dart';
import 'package:youmr_v2/features/notification/domain/entities/send_notification_params.dart';
import 'package:youmr_v2/features/notification/domain/repositories/notification_repository.dart';

/// 알림 Repository 구현체
class NotificationRepositoryImpl implements NotificationRepository {
  final FcmDataSource _fcmDataSource;
  final NotificationLocalDataSource _localDataSource;
  final FirebaseAuth _firebaseAuth;

  const NotificationRepositoryImpl({
    required FcmDataSource fcmDataSource,
    required NotificationLocalDataSource localDataSource,
    required FirebaseAuth firebaseAuth,
  })  : _fcmDataSource = fcmDataSource,
        _localDataSource = localDataSource,
        _firebaseAuth = firebaseAuth;

  @override
  Future<Either<AppFailure, void>> saveFcmToken(String token, String? userId) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        return const Left(AppFailure.unauthorized);
      }

      // userId가 제공되면 사용, 아니면 현재 로그인된 사용자 ID 사용
      final targetUserId = userId ?? user.uid;
      
      await _fcmDataSource.saveFcmToken(targetUserId, token);
      return const Right(null);
    } catch (e) {
      return Left(AppFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, void>> deleteFcmToken() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        return const Left(AppFailure.unauthorized);
      }

      await _fcmDataSource.deleteFcmToken(user.uid);
      return const Right(null);
    } catch (e) {
      return Left(AppFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, List<String>>> getFcmTokensByUserIds(
      List<String> userIds) async {
    try {
      final tokens = await _fcmDataSource.getFcmTokensByUserIds(userIds);
      return Right(tokens);
    } catch (e) {
      return Left(AppFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, String?>> getFcmTokenByUserId(String userId) async {
    try {
      final token = await _fcmDataSource.getFcmTokenByUserId(userId);
      return Right(token);
    } catch (e) {
      return Left(AppFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, NotificationSettings>> getNotificationSettings() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        return const Left(AppFailure.unauthorized);
      }

      final settingsDto = await _localDataSource.getNotificationSettings();
      
      if (settingsDto == null) {
        // 기본 설정 반환
        final defaultSettings = NotificationSettings(
          userId: user.uid,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        return Right(defaultSettings);
      }

      // DTO를 엔티티로 변환
      final settings = NotificationSettings(
        userId: settingsDto.userId,
        isEnabled: settingsDto.isEnabled,
        attendanceReminderEnabled: settingsDto.attendanceReminderEnabled,
        monthlyFeeReminderEnabled: settingsDto.monthlyFeeReminderEnabled,
        attendanceReminderTime: _parseTimeString(settingsDto.attendanceReminderTime),
        attendanceReminderDayOfWeek: settingsDto.attendanceReminderDayOfWeek,
        createdAt: settingsDto.createdAt,
        updatedAt: settingsDto.updatedAt,
      );

      return Right(settings);
    } catch (e) {
      return Left(AppFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, void>> saveNotificationSettings(
      NotificationSettings settings) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        return const Left(AppFailure.unauthorized);
      }

      // 엔티티를 DTO로 변환
      final settingsDto = NotificationSettingsDto(
        userId: settings.userId,
        isEnabled: settings.isEnabled,
        attendanceReminderEnabled: settings.attendanceReminderEnabled,
        monthlyFeeReminderEnabled: settings.monthlyFeeReminderEnabled,
        attendanceReminderTime: _formatTimeOfDay(settings.attendanceReminderTime),
        attendanceReminderDayOfWeek: settings.attendanceReminderDayOfWeek,
        createdAt: settings.createdAt,
        updatedAt: DateTime.now(),
      );

      await _localDataSource.saveNotificationSettings(settingsDto);
      return const Right(null);
    } catch (e) {
      return Left(AppFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, void>> sendPushNotification(
      SendNotificationParams params) async {
    try {
      await _fcmDataSource.sendPushNotification(params);
      return const Right(null);
    } catch (e) {
      return Left(AppFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, void>> sendConditionalPushNotification(
    SendNotificationParams params, {
    int? dayOfWeek,
    String? userType,
  }) async {
    try {
      await _fcmDataSource.sendConditionalPushNotification(
        params,
        dayOfWeek: dayOfWeek,
        userType: userType,
      );
      return const Right(null);
    } catch (e) {
      return Left(AppFailure.serverError(e.toString()));
    }
  }

  /// TimeOfDay를 문자열로 변환 (HH:mm 형식)
  String _formatTimeOfDay(TimeOfDay timeOfDay) {
    return '${timeOfDay.hour.toString().padLeft(2, '0')}:${timeOfDay.minute.toString().padLeft(2, '0')}';
  }

  /// 문자열을 TimeOfDay로 변환
  TimeOfDay _parseTimeString(String timeString) {
    final parts = timeString.split(':');
    return TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );
  }
} 