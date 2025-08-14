import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youmr_v2/core/constants/app_constants.dart';

/// 세 번째 온보딩 페이지 - 위치 정보 제공
class OnboardingLocationPage extends StatelessWidget {
  const OnboardingLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 메인 제목
          const Text(
            '${AppConstants.brandName} 모임 장소',
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
            '편리한 접근성과 쾌적한 환경',
            style: TextStyle(fontSize: 18, color: Colors.grey),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 40),

          // 위치 정보 카드
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row(
                //   children: [
                //     Icon(Icons.location_on, color: Colors.red, size: 20),
                //     const SizedBox(width: 12),
                //     Expanded(
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Text(
                //             "주소",
                //             style: const TextStyle(
                //               fontSize: 16,
                //               fontWeight: FontWeight.w600,
                //               color: Colors.black,
                //             ),
                //           ),
                //
                //           InkWell(
                //             onTap: () async{
                //               // 지도 앱 열기 로직
                //               _openNaverMaps(AppConstants.address);
                //             },
                //             child: Row(
                //               mainAxisSize: MainAxisSize.min,
                //               mainAxisAlignment: MainAxisAlignment.center,
                //               crossAxisAlignment: CrossAxisAlignment.center,
                //
                //
                //               children: [
                //                 Text(
                //                   "지도로 확인하기",
                //                   style: TextStyle(
                //                     fontSize: 14,
                //                     color: Colors.grey.shade600,
                //                   ),
                //                 ),
                //                 const SizedBox(width: 4),
                //                 Icon(
                //                   Icons.arrow_forward_ios,
                //                   size: 10,
                //                   color: Colors.grey.shade600,
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ],
                // ),
                // const SizedBox(height: 16),

                // 교통편 정보
                _buildTransportInfo(
                  '지하철',
                  '방학역 1번 출구에서 도보 5분',
                  Icons.directions_subway,
                  Colors.blue[600]!,
                ),

                const SizedBox(height: 16),

                _buildTransportInfo(
                  '버스',
                  '신도봉시장에서 하차',
                  Icons.directions_bus,
                  Colors.green!,
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  /// 교통편 정보 위젯 생성
  Widget _buildTransportInfo(
    String title,
    String description,
    IconData icon,
    Color iconColor,
  ) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Text(
                description,
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _openNaverMaps(String address) async {
    final String encodedAddress = Uri.encodeComponent(address);
    final Uri url = Uri.parse('https://map.naver.com/p/search/$encodedAddress');

    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        throw Exception('네이버 지도를 열 수 없습니다.');
      }
    } catch (e) {
      // 오류 처리
    }
  }
}
