/// 애플리케이션 환경을 관리하는 클래스
class EnvironmentConfig {
  /// 현재 환경 (기본값: production)
  static const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: 'production',
  );

  /// 프로덕션 환경 여부
  static bool get isProduction => environment == 'production';
  
  /// 테스트 환경 여부
  static bool get isTest => environment == 'test';
  
  /// 개발 환경 여부
  static bool get isDevelopment => environment == 'development';

  /// 현재 환경명 (한글)
  static String get environmentName {
    switch (environment) {
      case 'production':
        return '프로덕션';
      case 'test':
        return '테스트';
      case 'development':
        return '개발';
      default:
        return '프로덕션';
    }
  }

  /// 디버그 모드 여부
  static bool get isDebugMode => !isProduction;

  /// 현재 Firebase 프로젝트 ID
  static String get currentFirebaseProjectId {
    switch (environment) {
      case 'production':
        return 'youmr-v2';
      case 'test':
        return 'youmr-test';
      case 'development':
        return 'youmr-dev';
      default:
        return 'youmr-v2';
    }
  }
}
