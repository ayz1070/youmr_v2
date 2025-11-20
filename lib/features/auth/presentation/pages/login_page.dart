import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youmr_v2/features/auth/presentation/pages/profile_setup_page.dart';
import '../../../../core/constants/app_logger.dart';
import '../../../main/presentation/pages/main_navigation_page.dart';
import '../../di/auth_module.dart';
import '../providers/notifier/auth_notifier.dart';
import 'splash_page.dart';

/// 구글 로그인 버튼이 있는 로그인 화면 (Provider 기반)
class LoginPage extends ConsumerWidget {
  /// [key]: 위젯 고유 키
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 인증 상태 구독
    final authState = ref.watch(authProvider);
    // 상태 변화 리스너: 로그인 성공/실패 분기
    ref.listen(authProvider, (previous, next) {
      // 로그인 성공 시 프로필 완성도에 따라 직접 분기
      if (next is AsyncData && next.value != null) {
        final user = next.value!;
        if (user.userType != null && user.userType!.trim().isNotEmpty) {
          // 프로필 완성 → 메인 페이지로 이동
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const MainNavigationPage()),
          );
        } else {
          // 프로필 미완성 → 프로필 설정 페이지로 이동
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const ProfileSetupPage()),
          );
        }
      }

      // 에러 발생 시 스낵바 표시 (실제 앱에서는 AppErrorView 등 공통 위젯 사용 권장)
      if (next is AsyncError) {
        final error = next.error;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('구글 로그인 실패:  ${error.toString()}'), // 문구 상수화 권장
            duration: const Duration(seconds: 5),
          ),
        );
      }
    });

    return Scaffold(
      body: Stack(
        children: [
          // 배경 이미지
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg_login.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // 중앙에 로고나 안내 텍스트 등 필요시 추가 가능
          const SizedBox.expand(),
          // 로딩 상태: CircularProgressIndicator 대신 AppLoadingView 등 공통 위젯 사용 권장
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
                  height: 56,
                  child: Material(
                    color: const Color(0xFFF5F6F8),
                    elevation: 2,
                    child: InkWell(
                      onTap: () {
                        // 구글 로그인 액션 (ref.listen에서 성공/실패 처리)
                        ref.read(authProvider.notifier).signInWithGoogle();
                      },
                      child: Container(
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // 구글 로고 이미지
                            Image.asset(
                              'assets/images/google_logo.png',
                              width: 28,
                              height: 28,
                            ),
                            const SizedBox(width: 24),
                            // 버튼 텍스트 (상수화 권장)
                            const Text(
                              'Google로 로그인',
                              style: TextStyle(
                                fontSize: 16,
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
            ),
        ],
      ),
    );
  }
} 