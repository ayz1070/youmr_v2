import 'package:firebase_core/firebase_core.dart';
import '../../firebase_options.dart';
import '../../firebase_options_dev.dart';
import '../../firebase_options_test.dart';
import 'environment_config.dart';

/// 환경별 Firebase 설정을 관리하는 클래스
class FirebaseConfig {
  /// 프로덕션 환경 Firebase 설정
  static FirebaseOptions production = DefaultFirebaseOptions.currentPlatform;
  
  /// 개발 환경 Firebase 설정
  static FirebaseOptions development = FirebaseOptionsDev.currentPlatform;
  
  /// 테스트 환경 Firebase 설정
  static FirebaseOptions test = TestFirebaseOptions.currentPlatform;
  
  /// 현재 환경에 맞는 Firebase 설정 반환
  static FirebaseOptions get currentOptions {
    switch (EnvironmentConfig.environment) {
      case 'production':
        return production;
      case 'test':
        return test;
      case 'development':
        return development;
      default:
        return production;
    }
  }

  /// 현재 Firebase 프로젝트 ID
  static String get currentProjectId {
    return EnvironmentConfig.currentFirebaseProjectId;
  }

  /// 현재 환경 정보 로그 출력
  static void logCurrentEnvironment() {
    print('🔥 Firebase 환경 정보');
    print('🌍 환경: ${EnvironmentConfig.environmentName}');
    print('📱 프로젝트 ID: ${currentProjectId}');
    print('🔧 디버그 모드: ${EnvironmentConfig.isDebugMode}');
  }
}
