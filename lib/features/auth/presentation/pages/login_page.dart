import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import 'splash_page.dart';

/// 구글 로그인 버튼이 있는 로그인 화면 (Provider 기반)
class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    ref.listen(authProvider, (previous, next) {
      // 로그인 성공 시 SplashPage로 이동
      if (next is AsyncData && next.value != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const SplashPage()),
        );
      }
      // 에러 발생 시 스낵바 표시
      if (next is AsyncError) {
        final error = next.error;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('구글 로그인 실패: ${error.toString()}'),
            duration: const Duration(seconds: 5),
          ),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('로그인')),
      body: Center(
        child: authState.isLoading
            ? const CircularProgressIndicator()
            : ElevatedButton.icon(
                icon: Image.asset('assets/images/google_logo.png', width: 24, height: 24),
                label: const Text('구글로 시작하기'),
                onPressed: () {
                  ref.read(authProvider.notifier).signInWithGoogle();
                },
              ),
      ),
    );
  }
} 