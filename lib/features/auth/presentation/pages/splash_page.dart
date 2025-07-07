import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../controllers/auth_controller.dart';
import 'login_page.dart';
import 'profile_setup_page.dart';
import '../../../main/presentation/pages/main_navigation_page.dart';

/// 앱 실행 시 최초로 보여지는 스플래시 화면 (Riverpod 기반)
class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    final authController = ref.read(authControllerProvider.notifier);
    final result = await authController.checkAuthAndProfile();
    if (!mounted) return;
    if (result == AuthCheckResult.notLoggedIn) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    } else if (result == AuthCheckResult.needProfile) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const ProfileSetupPage()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const MainNavigationPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoadingIndicator(),
    );
  }
} 