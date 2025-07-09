import 'package:logger/logger.dart';

/// 앱 전역에서 사용하는 Logger 싱글톤
/// - 로그 레벨, 포맷 등 중앙에서 일괄 관리
/// - 개발/운영 환경에 따라 설정 변경 가능
class AppLogger {
  /// Logger 인스턴스 (싱글톤, 내부용)
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 1, // 호출 스택 깊이
      errorMethodCount: 5, // 에러 발생 시 스택 깊이
      lineLength: 80, // 한 줄 최대 길이
      colors: true, // 컬러 출력
      printEmojis: true, // 이모지 출력
      printTime: true, // 시간 출력
    ),
  );

  /// 기존 instance getter(호환성 유지)
  static Logger get instance => _logger;

  /// 에러 로그 (static)
  static void e(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  /// 경고 로그 (static)
  static void w(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.w(message, error: error, stackTrace: stackTrace);
  }

  /// 정보 로그 (static)
  static void i(dynamic message) {
    _logger.i(message);
  }

  /// 디버그 로그 (static)
  static void d(dynamic message) {
    _logger.d(message);
  }

  /// 상세 로그 (static)
  static void v(dynamic message) {
    _logger.v(message);
  }

  // 생성자 private(외부 인스턴스화 방지)
  AppLogger._();
} 