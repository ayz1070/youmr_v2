import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_logger.dart';

/// 온보딩 관련 유틸리티 클래스
class OnboardingUtils {
  static const String _onboardingCompletedKey = 'onboarding_completed';

  /// 온보딩 완료 상태 확인
  /// 반환: 온보딩 완료 여부
  static Future<bool> isOnboardingCompleted() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_onboardingCompletedKey) ?? false;
    } catch (e) {
      // 에러 발생 시 기본값 false 반환
      AppLogger.e('온보딩 상태 확인 실패: $e');
      return false;
    }
  }

  /// 온보딩 완료 상태 저장
  /// [completed]: 온보딩 완료 여부
  static Future<void> setOnboardingCompleted(bool completed) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_onboardingCompletedKey, completed);
      AppLogger.i('온보딩 상태 저장 완료: $completed');
    } catch (e) {
      // 에러 발생 시 로깅만 수행
      AppLogger.e('온보딩 상태 저장 실패: $e');
    }
  }

  /// 온보딩 완료 상태 초기화 (테스트용)
  static Future<void> resetOnboardingStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_onboardingCompletedKey);
      AppLogger.i('온보딩 상태 초기화 완료');
    } catch (e) {
      AppLogger.e('온보딩 상태 초기화 실패: $e');
    }
  }
}
