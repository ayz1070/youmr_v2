import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'profile_edit_page.dart';

/// 프로필 탭 페이지
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic>? _userData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  /// 내 정보 불러오기
  Future<void> _loadUser() async {
    setState(() => _isLoading = true);
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;
      final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      setState(() => _userData = doc.data());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  /// 로그아웃
  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    if (mounted) {
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  /// 프로필 수정 페이지로 이동
  Future<void> _editProfile() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const ProfileEditPage()),
    );
    if (result == true) {
      await _loadUser();
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_userData == null) {
      return const Center(child: Text('내 정보 불러오기 실패'));
    }
    final isAdmin = _userData!['userType'] == 'admin' || _userData!['userType'] == 'developer';
    final profileImageUrl = _userData!['profileImageUrl'] != null && _userData!['profileImageUrl'] != ''
        ? _userData!['profileImageUrl']
        : null;
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
                    child: profileImageUrl != null
                        ? Image.network(
                            profileImageUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 320,
                            errorBuilder: (context, error, stackTrace) => Container(
                              color: Colors.grey[300],
                              width: double.infinity,
                              height: 320,
                              child: Icon(Icons.person, size: 80, color: Colors.grey[500]),
                            ),
                          )
                        : Container(
                            color: Colors.grey[300],
                            width: double.infinity,
                            height: 320,
                            child: Icon(Icons.person, size: 80, color: Colors.grey[500]),
                          ),
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
                              _userData!['nickname'] ?? '',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                shadows: [Shadow(color: Colors.black38, blurRadius: 4)],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '회원타입: ${_userData!['userType'] ?? ''}',
                              style: const TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            if ((_userData!['userType'] ?? '') == 'offline_member')
                              Text(
                                '요일: ${_userData!['dayOfWeek'] ?? ''}',
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
                      onTap: _editProfile,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                      visualDensity: VisualDensity.compact,
                    ),
                    const Divider(height: 1, thickness: 1, indent: 24, endIndent: 24),
                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text('로그아웃', style: TextStyle(fontSize: 14)),
                      onTap: _logout,
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