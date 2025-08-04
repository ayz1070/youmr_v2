import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:youmr_v2/features/notification/data/dtos/notification_settings_dto.dart';

/// 알림 로컬 데이터 소스 인터페이스
abstract class NotificationLocalDataSource {
  /// 알림 설정 저장
  Future<void> saveNotificationSettings(NotificationSettingsDto settings);
  
  /// 알림 설정 조회
  Future<NotificationSettingsDto?> getNotificationSettings();
  
  /// 알림 설정 삭제
  Future<void> deleteNotificationSettings();
}

/// Hive를 사용한 알림 로컬 데이터 소스 구현
class NotificationHiveDataSource implements NotificationLocalDataSource {
  static const String _boxName = 'notification_settings';
  static const String _settingsKey = 'settings';

  /// Hive 박스 초기화
  static Future<void> initialize() async {
    await Hive.initFlutter();
    await Hive.openBox(_boxName);
  }

  @override
  Future<void> saveNotificationSettings(NotificationSettingsDto settings) async {
    try {
      final box = Hive.box(_boxName);
      await box.put(_settingsKey, settings.toJson());
      debugPrint('알림 설정 저장 완료');
    } catch (e) {
      debugPrint('알림 설정 저장 실패: $e');
      rethrow;
    }
  }

  @override
  Future<NotificationSettingsDto?> getNotificationSettings() async {
    try {
      final box = Hive.box(_boxName);
      final data = box.get(_settingsKey);
      
      if (data == null) {
        debugPrint('알림 설정이 존재하지 않음');
        return null;
      }

      final settings = NotificationSettingsDto.fromJson(Map<String, dynamic>.from(data));
      debugPrint('알림 설정 조회 완료');
      return settings;
    } catch (e) {
      debugPrint('알림 설정 조회 실패: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteNotificationSettings() async {
    try {
      final box = Hive.box(_boxName);
      await box.delete(_settingsKey);
      debugPrint('알림 설정 삭제 완료');
    } catch (e) {
      debugPrint('알림 설정 삭제 실패: $e');
      rethrow;
    }
  }
} 