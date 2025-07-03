import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// 회원 관리 페이지
class MemberManagementPage extends StatelessWidget {
  const MemberManagementPage({super.key});

  /// 회원 권한 변경
  Future<void> _changeUserType(String uid, String newType, BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).update({'userType': newType});
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('권한이 변경되었습니다.')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('권한 변경 실패')));
    }
  }

  /// 회원 강퇴
  Future<void> _removeUser(String uid, BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).delete();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('회원이 삭제되었습니다.')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('회원 삭제 실패')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection('users').orderBy('createdAt', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final docs = snapshot.data?.docs ?? [];
        if (docs.isEmpty) {
          return const Center(child: Text('회원이 없습니다.'));
        }
        return ListView.separated(
          itemCount: docs.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, idx) {
            final user = docs[idx].data();
            final uid = docs[idx].id;
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: user['profileImageUrl'] != null && user['profileImageUrl'] != ''
                    ? NetworkImage(user['profileImageUrl'])
                    : const AssetImage('assets/images/default_profile.png') as ImageProvider,
              ),
              title: Text(user['nickname'] ?? ''),
              subtitle: Text('이메일: ${user['email'] ?? ''}\n권한: ${user['userType'] ?? ''}'),
              trailing: PopupMenuButton<String>(
                onSelected: (value) async {
                  if (value.startsWith('type:')) {
                    await _changeUserType(uid, value.substring(5), context);
                  } else if (value == 'remove') {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('회원 삭제'),
                        content: const Text('정말 삭제하시겠습니까?'),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('취소')),
                          TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('삭제')),
                        ],
                      ),
                    );
                    if (confirm == true) {
                      await _removeUser(uid, context);
                    }
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(value: 'type:admin', child: Text('관리자 지정')),
                  const PopupMenuItem(value: 'type:developer', child: Text('개발자 지정')),
                  const PopupMenuItem(value: 'type:offline_member', child: Text('오프라인 회원 지정')),
                  const PopupMenuItem(value: 'type:member', child: Text('일반 회원 지정')),
                  const PopupMenuDivider(),
                  const PopupMenuItem(value: 'remove', child: Text('회원 삭제', style: TextStyle(color: Colors.red))),
                ],
              ),
            );
          },
        );
      },
    );
  }
} 