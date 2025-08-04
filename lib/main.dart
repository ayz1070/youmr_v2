import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youmr_v2/features/auth/presentation/pages/login_page.dart';
import 'package:youmr_v2/features/auth/presentation/pages/profile_setup_page.dart';
import 'firebase_options.dart';
import 'core/constants/app_constants.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/pages/splash_page.dart';
import 'features/voting/presentation/pages/voting_write_page.dart';
import 'core/services/admob_service.dart';
import 'core/services/fcm_service.dart';
import 'core/services/notification_scheduler.dart';
import 'package:youmr_v2/features/notification/data/data_sources/notification_local_data_source.dart';

void main() async {
  // Flutter 위젯 바인딩 초기화
  WidgetsFlutterBinding.ensureInitialized();
  
  // Firebase 초기화
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
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

/// 앱 루트 위젯
class YouMRApp extends StatelessWidget {
  const YouMRApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      theme: AppTheme.lightTheme, // AppTheme 사용
      home: const SplashPage(), // 인증 상태 확인을 위해 SplashPage로 시작

    );
  }
}
