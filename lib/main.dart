import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/pages/splash_page.dart';
import 'firebase_options.dart';
import 'features/voting/presentation/providers/voting_provider.dart';
import 'features/voting/data/repositories/voting_repository_impl.dart';
import 'features/voting/data/data_sources/voting_firestore_data_source.dart';
import 'core/constants/app_constants.dart';
import 'features/main/presentation/pages/main_navigation_page.dart';
import 'features/voting/presentation/pages/voting_write_page.dart';

void main() async {
  // Flutter 위젯 바인딩 초기화
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase 초기화
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ProviderScope(
      overrides: [
        // 투표 리포지토리 Provider를 실제 구현체로 주입
        votingRepositoryProvider.overrideWith(
          (ref) => VotingRepositoryImpl(
            dataSource: VotingFirestoreDataSource(),
          ),
        ),
      ],
      child: const YouMRApp(),
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
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const MainNavigationPage(),
      // 라우트 등록: 투표 등록 화면
      routes: {
        '/voting/write': (context) => const VotingWritePage(),
      },
    );
  }
}
