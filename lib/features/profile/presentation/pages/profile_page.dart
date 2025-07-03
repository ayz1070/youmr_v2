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
    return Scaffold(
      appBar: AppBar(
        title: const Text('내 프로필'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: '프로필 수정',
            onPressed: _editProfile,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 내 정보
          Row(
            children: [
              CircleAvatar(
                radius: 36,
                backgroundImage: _userData!['profileImageUrl'] != null && _userData!['profileImageUrl'] != ''
                    ? NetworkImage(_userData!['profileImageUrl'])
                    : const AssetImage('assets/images/default_profile.png') as ImageProvider,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_userData!['nickname'] ?? '', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Text('회원타입: ${_userData!['userType'] ?? ''}'),
                    if ((_userData!['userType'] ?? '') == 'offline_member')
                      Text('요일: ${_userData!['dayOfWeek'] ?? ''}'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // 내가 쓴 글
          const Text('내가 쓴 글', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('posts')
                .where('authorId', isEqualTo: user?.uid)
                .orderBy('createdAt', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              final docs = snapshot.data?.docs ?? [];
              if (docs.isEmpty) {
                return const Text('아직 작성한 글이 없습니다.', style: TextStyle(color: Colors.grey));
              }
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: docs.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, idx) {
                  final post = docs[idx].data();
                  return ListTile(
                    title: Text(post['title'] ?? ''),
                    subtitle: Text('${post['category'] ?? ''} • ${(post['createdAt'] as Timestamp?)?.toDate().toString().substring(0, 16) ?? ''}'),
                  );
                },
              );
            },
          ),
          const SizedBox(height: 24),
          // 설정/로그아웃
          ElevatedButton.icon(
            onPressed: _logout,
            icon: const Icon(Icons.logout),
            label: const Text('로그아웃'),
          ),
          const SizedBox(height: 24),
          // 관리자 메뉴
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
    );
  }
} 