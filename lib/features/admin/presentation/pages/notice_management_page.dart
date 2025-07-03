import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// 공지글 관리 페이지
class NoticeManagementPage extends StatelessWidget {
  const NoticeManagementPage({super.key});

  /// 공지 해제
  Future<void> _unsetNotice(String postId, BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection('posts').doc(postId).update({'isNotice': false});
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('공지에서 해제되었습니다.')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('공지 해제 실패')));
    }
  }

  /// 공지글 삭제
  Future<void> _deletePost(String postId, BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection('posts').doc(postId).delete();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('공지글이 삭제되었습니다.')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('공지글 삭제 실패')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('posts')
          .where('isNotice', isEqualTo: true)
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final docs = snapshot.data?.docs ?? [];
        if (docs.isEmpty) {
          return const Center(child: Text('공지글이 없습니다.'));
        }
        return ListView.separated(
          itemCount: docs.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, idx) {
            final post = docs[idx].data();
            final postId = docs[idx].id;
            return ListTile(
              leading: const Icon(Icons.campaign, color: Colors.amber),
              title: Text(post['title'] ?? ''),
              subtitle: Text('${post['authorNickname'] ?? ''} • ${(post['createdAt'] as Timestamp?)?.toDate().toString().substring(0, 16) ?? ''}'),
              trailing: PopupMenuButton<String>(
                onSelected: (value) async {
                  if (value == 'unset') {
                    await _unsetNotice(postId, context);
                  } else if (value == 'delete') {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('공지글 삭제'),
                        content: const Text('정말 삭제하시겠습니까?'),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('취소')),
                          TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('삭제')),
                        ],
                      ),
                    );
                    if (confirm == true) {
                      await _deletePost(postId, context);
                    }
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(value: 'unset', child: Text('공지 해제')),
                  const PopupMenuItem(value: 'delete', child: Text('공지글 삭제', style: TextStyle(color: Colors.red))),
                ],
              ),
            );
          },
        );
      },
    );
  }
} 