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
      body: Stack(
        children: [
          // 중앙에 로고나 안내 텍스트 등 필요시 추가 가능
          const SizedBox.expand(),
          if (authState.isLoading)
            const Center(child: CircularProgressIndicator()),
          // 하단 구글 로그인 버튼
          if (!authState.isLoading)
            Align(
              alignment: Alignment.bottomCenter,
              child: SafeArea(
                minimum: const EdgeInsets.only(left: 24, right: 24, bottom: 32),
                child: SizedBox(
                  width: double.infinity,
                  height: 64,
                  child: Material(
                    color: const Color(0xFFF5F6F8),
                    borderRadius: BorderRadius.circular(24),
                    elevation: 2,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(24),
                      onTap: () {
                        ref.read(authProvider.notifier).signInWithGoogle();
                      },
                      child: Row(
                        children: [
                          const SizedBox(width: 24),
                          Image.asset(
                            'assets/images/google_logo.png',
                            width: 32,
                            height: 32,
                          ),
                          const SizedBox(width: 16),
                          const Text(
                            '구글로 계속하기',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF222222),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
} 