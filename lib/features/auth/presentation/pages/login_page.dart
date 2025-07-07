import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../../../core/widgets/empty_state.dart';
import '../controllers/auth_controller.dart';
import 'splash_page.dart';
import '../widgets/google_sign_in_button.dart';

/// 구글 로그인 버튼이 있는 로그인 화면 (Riverpod 기반)
class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    final authController = ref.read(authControllerProvider.notifier);

    ref.listen(authControllerProvider, (prev, next) {
      next.whenOrNull(
        data: (user) {
          if (user != null && context.mounted) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const SplashPage()),
            );
          }
        },
        error: (e, st) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('구글 로그인 실패: ${e.toString()}')),
            );
          }
        },
      );
    });

    return Scaffold(
      appBar: AppBar(title: const Text('로그인')),
      body: Center(
        child: authState.when(
          loading: () => const LoadingIndicator(),
          error: (e, st) => EmptyState(
            icon: Icons.error_outline,
            message: '로그인 에러',
            subMessage: e.toString(),
            buttonText: '다시 시도',
            onButtonPressed: () => authController.signInWithGoogle(),
          ),
          data: (_) => GoogleSignInButton(
            onPressed: () => authController.signInWithGoogle(),
          ),
        ),
      ),
    );
  }
} 