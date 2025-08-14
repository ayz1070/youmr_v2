import 'package:flutter/material.dart';

/// 첫 번째 온보딩 페이지 - 인사 및 모임 소개
class OnboardingGreetingPage extends StatelessWidget {
  const OnboardingGreetingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 메인 제목
          const Text(
            '안녕하세요!',
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
            'YouMR에 오신 것을 환영합니다',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 40),

          // 모임 소개 카드
          // Container(
          //   width: double.infinity,
          //   padding: const EdgeInsets.all(24),
          //   decoration: BoxDecoration(
          //     color: Colors.grey.shade50,
          //     borderRadius: BorderRadius.circular(16),
          //     border: Border.all(color: Colors.grey.shade200),
          //   ),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Row(
          //         children: [
          //           Icon(
          //             Icons.info_outline,
          //             color: Colors.blue.shade600,
          //             size: 24,
          //           ),
          //           const SizedBox(width: 12),
          //           const Text(
          //             '모임 소개',
          //             style: TextStyle(
          //               fontSize: 18,
          //               fontWeight: FontWeight.bold,
          //               color: Colors.black,
          //             ),
          //           ),
          //         ],
          //       ),
          //
          //       const SizedBox(height: 16),
          //
          //       const Text(
          //         '우리는 함께 성장하고 배우는 모임입니다. '
          //         '다양한 활동을 통해 새로운 경험을 만들어가고, '
          //         '서로에게 영감을 주고받으며 발전해 나갑니다.',
          //         style: TextStyle(
          //           fontSize: 16,
          //           color: Colors.black87,
          //           height: 1.5,
          //         ),
          //       ),
          //
          //       const SizedBox(height: 16),
          //
          //       // 모임 특징
          //       Row(
          //         children: [
          //           _buildFeatureChip('친목', Icons.favorite),
          //           const SizedBox(width: 12),
          //           _buildFeatureChip('학습', Icons.school),
          //           const SizedBox(width: 12),
          //           _buildFeatureChip('성장', Icons.trending_up),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),


        ],
      ),
    );
  }

  /// 특징 칩 위젯 생성
  Widget _buildFeatureChip(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: Colors.blue.shade700,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.blue.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
