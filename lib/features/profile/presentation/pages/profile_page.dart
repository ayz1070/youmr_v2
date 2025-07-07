import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/profile_controller.dart';
import '../widgets/profile_avatar.dart';
import 'profile_edit_page.dart';

/// 프로필 페이지 (클린 아키텍처/riverpod 기반)
class ProfilePage extends ConsumerWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileControllerProvider);
    final controller = ref.read(profileControllerProvider.notifier);

    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    final profile = state.profile;
    if (profile == null) {
      return const Center(child: Text('내 정보 불러오기 실패'));
    }
    final isAdmin = profile.userType == 'admin' || profile.userType == 'developer';
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 상단 프로필 이미지 + 정보 overlay
              Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 320,
                    child: ProfileAvatar(imageUrl: profile.profileImageUrl, radius: 80),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 32,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.35),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              profile.nickname,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                shadows: [Shadow(color: Colors.black38, blurRadius: 4)],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '회원타입: ${profile.userType}',
                              style: const TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            if (profile.userType == 'offline_member')
                              Text(
                                '요일: ${profile.dayOfWeek ?? ''}',
                                style: const TextStyle(color: Colors.white, fontSize: 16),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // 소제목
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
                child: Row(
                  children: const [
                    Text('프로필', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
              ),
              // 메뉴 리스트 (프로필 수정, 로그아웃)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.edit_outlined),
                      title: const Text('프로필 수정', style: TextStyle(fontSize: 14)),
                      onTap: () async {
                        final result = await Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const ProfileEditPage()),
                        );
                        if (result == true) {
                          controller.fetchProfile();
                        }
                      },
                      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                      visualDensity: VisualDensity.compact,
                    ),
                    const Divider(height: 1, thickness: 1, indent: 24, endIndent: 24),
                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text('로그아웃', style: TextStyle(fontSize: 14)),
                      onTap: () async {
                        // TODO: 로그아웃 유스케이스/컨트롤러로 분리
                      },
                      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                      visualDensity: VisualDensity.compact,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              // 관리자 메뉴
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (isAdmin)
                      Card(
                        color: Colors.blue[50],
                        child: ListTile(
                          leading: const Icon(Icons.admin_panel_settings, color: Colors.blue),
                          title: const Text('관리자 메뉴'),
                          subtitle: const Text('공지글 관리, 회원 관리 등'),
                          onTap: () {}, // TODO: 관리자 기능 연결
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 