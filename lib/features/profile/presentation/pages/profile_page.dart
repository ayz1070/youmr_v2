import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youmr_v2/features/admin/presentation/pages/admin_page.dart';
import '../../../../core/widgets/primary_app_bar.dart';
import '../providers/profile_provider.dart';
import 'profile_edit_page.dart';
import 'location_page.dart';
import '../../../auth/presentation/pages/profile_setup_page.dart';
import '../../../auth/presentation/pages/login_page.dart';
import '../../../notification/presentation/pages/notification_settings_page.dart';
import '../../../../core/widgets/app_dialog.dart';

/// 프로필 탭 페이지 (Provider 기반)
class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider);
    final notifier = ref.read(profileProvider.notifier);

    return profileAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text('내 정보 불러오기 실패\n${e.toString()}')),
      data: (profile) {
        if (profile == null) {
          // 프로필이 없는 경우 ProfileSetupPage로 이동
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const ProfileSetupPage()),
            );
          });
          return const Center(child: CircularProgressIndicator());
        }

        final isAdmin =
            profile.userType == 'admin' || profile.userType == 'developer';
        final profileImageUrl =
            profile.profileImageUrl != null && profile.profileImageUrl != ''
            ? profile.profileImageUrl
            : null;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: PrimaryAppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: '마이페이지',
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 프로필 정보 섹션
                Row(
                  children: [
                    // 프로필 이미지
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: profileImageUrl != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: Image.network(
                                profileImageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                              ),
                            )
                          : const Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 40,
                            ),
                    ),
                    const SizedBox(width: 16),
                    // 프로필 정보 (세로 배치)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profile.nickname,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          if (profile.name != null &&
                              profile.name!.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text(
                              profile.name!,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              _getUserTypeDisplayName(profile.userType),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // 설정 메뉴
                const Text(
                  '설정',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 12),
                Divider(height: 1, color: Colors.grey[200]),


                // 설정 메뉴 컨테이너
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      _buildMenuItem(
                        title: '알림설정',
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const NotificationSettingsPage(),
                            ),
                          );
                        },
                      ),
                      _buildMenuItem(
                        title: '프로필 수정',
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const ProfileEditPage(),
                            ),
                          );
                        },
                      ),
                      _buildMenuItem(
                        title: '로그아웃',
                        onTap: () async {
                          _showLogoutDialog(context, notifier);
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),
                // 설정 메뉴
                const Text(
                  '모임',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 12),
                Divider(height: 1, color: Colors.grey[200]),


                // 설정 메뉴 컨테이너
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      _buildMenuItem(
                        title: '오픈 채팅방 바로가기',
                        onTap: () async {
                          // 카카오톡 오픈 채팅방 링크 열기
                          final Uri url = Uri.parse('https://open.kakao.com/o/gZlPWoff');
                          try {
                            if (await canLaunchUrl(url)) {
                              await launchUrl(
                                url,
                                mode: LaunchMode.externalApplication,
                              );
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
                      ),
                      _buildMenuItem(
                        title: '위치',
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const LocationPage(),
                            ),
                          );
                        },
                      ),

                    ],
                  ),
                ),



                // 관리자 메뉴 (관리자만 표시, 하단에 배치)
                if (isAdmin) ...[
                  const SizedBox(height: 32),
                  const Text(
                    '관리자 메뉴',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Divider(height: 1, color: Colors.grey[200]),

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: _buildMenuItem(
                      title: '관리자 페이지',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const AdminPage(),
                          ),
                        );
                      },
                    ),
                  ),

                ],



              ],
            ),
          ),
        );
      },
    );
  }

  /// 메뉴 아이템 위젯 (미니멀한 디자인)
  Widget _buildMenuItem({
    required String title,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16, 
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right, 
                color: Colors.grey[400], 
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 사용자 타입 표시 이름 반환
  String _getUserTypeDisplayName(String userType) {
    switch (userType) {
      case 'admin':
        return '관리자';
      case 'developer':
        return '개발자';
      case 'offline_member':
        return '오프라인 회원';
      case 'member':
        return '일반 회원';
      default:
        return userType;
    }
  }

  /// 로그아웃 확인 다이얼로그를 표시합니다
  void _showLogoutDialog(BuildContext context, ProfileNotifier notifier) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AppDialog(
          title: '로그아웃',
          message: '정말로 로그아웃 하시겠습니까?',
          cancelText: '취소',
          confirmText: '로그아웃',
          cancelColor: const Color(0xFFF5F5F5),
          confirmColor: Colors.red,
          cancelTextColor: Colors.black,
          confirmTextColor: Colors.white,
          onCancel: () => Navigator.of(context).pop(),
          onConfirm: () {
            Navigator.of(context).pop();
            _performLogout(context, notifier);
          },
        );
      },
    );
  }

  /// 로그아웃을 수행합니다
  Future<void> _performLogout(BuildContext context, ProfileNotifier notifier) async {
    try {
      // Firebase Auth에서 로그아웃
      await notifier.logout(context);
      
      if (context.mounted) {
        // 로그아웃 성공 메시지 표시
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('로그아웃되었습니다.'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green,
          ),
        );

        // LoginPage로 이동 (모든 이전 화면 제거)
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => const LoginPage(),
          ),
          (route) => false, // 모든 이전 화면 제거
        );
      }
    } catch (error) {
      if (context.mounted) {
        // 로그아웃 실패 메시지 표시
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('로그아웃 중 오류가 발생했습니다: ${error.toString()}'),
            duration: const Duration(seconds: 3),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
