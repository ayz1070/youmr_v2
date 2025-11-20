import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import '../constants/app_logger.dart';
import 'environment_config.dart';
import 'env_config.dart';

/// 환경별 Firebase 설정을 관리하는 클래스
class FirebaseConfig {
  /// 현재 환경에 맞는 Firebase 설정 반환 (동적 생성)
  static FirebaseOptions get currentOptions {
    if (kDebugMode) {
      return _createDevelopmentOptions();
    } else {
      return _createProductionOptions();
    }
  }

  /// 개발 환경 Firebase 설정 생성
  static FirebaseOptions _createDevelopmentOptions() {
    return FirebaseOptions(
      apiKey: EnvConfig.firebaseApiKey,
      appId: EnvConfig.firebaseAppId,
      messagingSenderId: EnvConfig.firebaseMessagingSenderId,
      projectId: EnvConfig.firebaseProjectId,
      storageBucket: EnvConfig.firebaseStorageBucket,
      authDomain: EnvConfig.firebaseAuthDomain,
      measurementId: EnvConfig.firebaseMeasurementId,
    );
  }

  /// 프로덕션 환경 Firebase 설정 생성
  static FirebaseOptions _createProductionOptions() {
    return FirebaseOptions(
      apiKey: EnvConfig.firebaseApiKey,
      appId: EnvConfig.firebaseAppId,
      messagingSenderId: EnvConfig.firebaseMessagingSenderId,
      projectId: EnvConfig.firebaseProjectId,
      storageBucket: EnvConfig.firebaseStorageBucket,
      authDomain: EnvConfig.firebaseAuthDomain,
      measurementId: EnvConfig.firebaseMeasurementId,
    );
  }

  /// 현재 Firebase 프로젝트 ID
  static String get currentProjectId {
    return EnvironmentConfig.currentFirebaseProjectId;
  }

  /// 현재 환경 정보 로그 출력
  static void logCurrentEnvironment() {
    AppLogger.i('🔥 Firebase 환경 정보');
    AppLogger.i('🌍 환경: ${EnvironmentConfig.environmentName}');
    AppLogger.i('📱 프로젝트 ID: $currentProjectId');
    AppLogger.i('🔧 디버그 모드: ${EnvironmentConfig.isDebugMode}');
    AppLogger.i('🔑 API Key: ${EnvConfig.firebaseApiKey}');
    AppLogger.i('📱 App ID: ${EnvConfig.firebaseAppId}');
  }
}
