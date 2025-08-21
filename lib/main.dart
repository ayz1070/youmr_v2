import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/config/firebase_config.dart';
import 'core/config/environment_config.dart';
import 'core/constants/app_constants.dart';
import 'core/constants/app_logger.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/pages/splash_page.dart';
import 'core/services/admob_service.dart';
import 'core/services/fcm_service.dart';
import 'core/services/notification_scheduler.dart';
import 'package:youmr_v2/features/notification/data/data_sources/notification_local_data_source.dart';

void main() async {
  // Flutter 위젯 바인딩 초기화
  WidgetsFlutterBinding.ensureInitialized();

  // 환경별 Firebase 초기화
  await _initializeFirebase();

  // Hive 초기화
  await NotificationHiveDataSource.initialize();

  // AdMob 초기화
  await AdMobService().initialize();

  // FCM 초기화
  await FcmService().initialize();

  // 알림 스케줄러 초기화
  await NotificationScheduler().initialize();

  runApp(
    const ProviderScope(
      child: YouMRApp(),
    ),
  );
}

/// 환경별 Firebase 초기화
Future<void> _initializeFirebase() async {
  try {
    // 현재 환경 정보 로그 출력
    FirebaseConfig.logCurrentEnvironment();
    
    final options = FirebaseConfig.currentOptions;
    
    AppLogger.i('🚀 Firebase 초기화 시작...');
    
    await Firebase.initializeApp(options: options);

    AppLogger.i('Firebase 초기화 완료');
  } catch (e) {
    AppLogger.e('Firebase 초기화 실패: $e');
    rethrow;
  }
}

/// 앱 루트 위젯
class YouMRApp extends StatelessWidget {
  const YouMRApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _getAppTitle(),
      theme: AppTheme.lightTheme,
      home: const SplashPage(),
    );
  }

  /// 환경별 앱 제목 생성
  String _getAppTitle() {
    final baseTitle = AppConstants.appName;
    if (EnvironmentConfig.isProduction) {
      return baseTitle;
    }
    return '$baseTitle (${EnvironmentConfig.environmentName})';
  }
}
