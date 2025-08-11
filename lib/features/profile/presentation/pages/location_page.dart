import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youmr_v2/core/widgets/app_button.dart';

/// 위치 정보를 보여주는 페이지
class LocationPage extends StatelessWidget {
  const LocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    const String address = '서울 도봉구 도당로29길 66';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          '위치',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '주소',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),

            // 위치 정보 카드
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.grey[50]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$address, 지하 1층",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 주소 복사 버튼
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        await Clipboard.setData(
                          const ClipboardData(text: address),
                        );
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.black,
                              content: Text('주소가 클립보드에 복사되었습니다.'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                      icon: const Icon(Icons.copy, size: 18),
                      label: const Text('주소 복사'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // 지도 앱으로 이동 섹션
            const Text(
              '지도 앱으로 이동',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),

            // 구글 지도
            _buildMapAppButton(
              title: 'Google 지도',
              subtitle: '구글 지도에서 위치 보기',
              icon: Icons.location_on_outlined,
              iconColor: Colors.red,
              onTap: () => _openGoogleMaps(address),
            ),

            const SizedBox(height: 12),

            // 카카오 지도
            _buildMapAppButton(
              title: '카카오 지도',
              subtitle: '카카오 지도에서 위치 보기',
              icon: Icons.location_on_outlined,
              // 탐색/발견의 의미를 가진 아이콘
              iconColor: Colors.yellow[700]!,
              onTap: () => _openKakaoMaps(address),
            ),

            const SizedBox(height: 12),

            // 네이버 지도
            _buildMapAppButton(
              title: '네이버 지도',
              subtitle: '네이버 지도에서 위치 보기',
              icon: Icons.location_on_outlined,
              iconColor: Colors.green[500]!,
              onTap: () => _openNaverMaps(address),
            ),

            const SizedBox(height: 32),

            const Text(
              '오픈 채팅방',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () async {
                  // 카카오톡 오픈 채팅방 링크 열기
                  final Uri url = Uri.parse('https://open.kakao.com/o/gZlPWoff');
                  try {
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url, mode: LaunchMode.externalApplication);
                    } else {
                      // URL을 열 수 없는 경우 스낵바로 알림
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('링크를 열 수 없습니다.'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    }
                  } catch (e) {
                    // 오류 발생 시 스낵바로 알림
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('오류가 발생했습니다: ${e.toString()}'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  }
                },
                icon: const Icon(Icons.chat_bubble_outline, size: 18),
                label: const Text('오픈 채팅에서 더 물어보기'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
              ),
            ),



          ],
        ),
      ),
    );
  }

  /// 지도 앱 버튼 위젯
  Widget _buildMapAppButton({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(icon, color: iconColor, size: 24),
              ),
              const SizedBox(width: 16),
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
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 16),
            ],
          ),
        ),
      ),
    );
  }

  /// 구글 지도 열기
  Future<void> _openGoogleMaps(String address) async {
    final String encodedAddress = Uri.encodeComponent(address);
    final Uri url = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$encodedAddress',
    );

    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        throw Exception('구글 지도를 열 수 없습니다.');
      }
    } catch (e) {
      // 오류 처리
    }
  }

  /// 카카오 지도 열기
  Future<void> _openKakaoMaps(String address) async {
    final String encodedAddress = Uri.encodeComponent(address);
    final Uri url = Uri.parse(
      'https://map.kakao.com/link/search/$encodedAddress',
    );

    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        throw Exception('카카오 지도를 열 수 없습니다.');
      }
    } catch (e) {
      // 오류 처리
    }
  }

  /// 네이버 지도 열기
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
