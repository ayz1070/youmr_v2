import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youmr_v2/features/admin/presentation/pages/admin_page.dart';
import '../providers/profile_provider.dart';
import 'profile_edit_page.dart';
import '../../../auth/presentation/pages/profile_setup_page.dart';
import '../../../notification/presentation/pages/notification_settings_page.dart';

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
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: const Text(
              '마이페이지',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
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
                          await notifier.logout(context);
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

                const SizedBox(height: 32),

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
}
