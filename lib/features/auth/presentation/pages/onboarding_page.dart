import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/utils/onboarding_utils.dart';
import '../../../../core/constants/app_logger.dart';
import '../../../main/presentation/pages/main_navigation_page.dart';
import 'onboarding/onboarding_chat_page.dart';
import 'onboarding/onboarding_greeting_page.dart';
import 'onboarding/onboarding_intro_page.dart';
import 'onboarding/onboarding_location_page.dart';

/// 온보딩 페이지 관리자
class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Widget> _onboardingPages = [
    const OnboardingGreetingPage(),
    const OnboardingIntroPage(),
    const OnboardingLocationPage(),
    const OnboardingChatPage(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _onboardingPages.length - 1) {
      setState(() {
        _currentPage++;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }


  void _completeOnboarding() async {
    // 온보딩 완료 상태 저장
    await OnboardingUtils.setOnboardingCompleted(true);
    
    // 온보딩 완료 후 메인 페이지로 이동
    if (mounted) {
      AppLogger.i('온보딩 완료 → 메인 페이지로 이동');
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const MainNavigationPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 페이지 인디케이터
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 페이지 점 표시
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _onboardingPages.length,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index == _currentPage
                              ? Colors.black
                              : Colors.grey.shade300,
                        ),
                      ),
                    ),
                  ),
                  
                ],
              ),
            ),
            
            // 페이지 콘텐츠
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: _onboardingPages,
              ),
            ),
            
            // 하단 네비게이션
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: AppButton(
                text: _currentPage == _onboardingPages.length - 1
                    ? '시작하기'
                    : '다음',
                onPressed: _currentPage == _onboardingPages.length - 1
                    ? _completeOnboarding
                    : _nextPage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
