import 'package:flutter/material.dart';
import 'package:youmr_v2/core/constants/app_constants.dart';

/// 두 번째 온보딩 페이지 - 모임 소개2
class OnboardingIntroPage extends StatelessWidget {
  const OnboardingIntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          // 메인 제목
          const Text(
            '${AppConstants.brandName} 은',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 16),
          
          // 부제목
          const Text(
            '통기타 모임으로 정기적으로 모여 활동하고 있는 동호회입니다',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 40),
          


        ],
      ),
    );
  }

}
