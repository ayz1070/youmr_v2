import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// 공지글 관리 페이지
class NoticeManagementPage extends StatefulWidget {
  const NoticeManagementPage({super.key});

  @override
  State<NoticeManagementPage> createState() => _NoticeManagementPageState();
}

class _NoticeManagementPageState extends State<NoticeManagementPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  /// 공지 해제
  Future<void> _unsetNotice(String postId, BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection('posts').doc(postId).update({'isNotice': false});
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('공지에서 해제되었습니다.')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('공지 해제 실패')));
      }
    }
  }

  /// 공지글 삭제
  Future<void> _deletePost(String postId, BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection('posts').doc(postId).delete();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('공지글이 삭제되었습니다.')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('공지글 삭제 실패')));
      }
    }
  }

  /// 새로고침
  Future<void> _refresh() async {
    // StreamBuilder가 자동으로 새로고침되므로 별도 로직 불필요
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _refresh,
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .where('isNotice', isEqualTo: true)
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('오류가 발생했습니다: ${snapshot.error}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => _refreshIndicatorKey.currentState?.show(),
                    child: const Text('새로고침'),
                  ),
                ],
              ),
            );
          }

          final docs = snapshot.data?.docs ?? [];
          if (docs.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.campaign_outlined, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('공지글이 없습니다.'),
                  SizedBox(height: 8),
                  Text('우측 상단의 + 버튼을 눌러 공지글을 작성하세요.', 
                       style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            );
          }

          return ListView.separated(
            itemCount: docs.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, idx) {
              final post = docs[idx].data();
              final postId = docs[idx].id;
              final createdAt = post['createdAt'] as Timestamp?;
              final authorNickname = post['authorNickname'] ?? '알 수 없음';
              final title = post['title'] ?? '제목 없음';
              
              return ListTile(
                leading: const Icon(Icons.campaign, color: Colors.amber),
                title: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('작성자: $authorNickname'),
                    if (createdAt != null)
                      Text(
                        '작성일: ${createdAt.toDate().toString().substring(0, 16)}',
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                  ],
                ),
                trailing: PopupMenuButton<String>(
                  onSelected: (value) async {
                    if (value == 'unset') {
                      await _unsetNotice(postId, context);
                    } else if (value == 'delete') {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('공지글 삭제'),
                          content: const Text('정말 삭제하시겠습니까?\n이 작업은 되돌릴 수 없습니다.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(ctx, false), 
                              child: const Text('취소')
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(ctx, true), 
                              child: const Text('삭제', style: TextStyle(color: Colors.red))
                            ),
                          ],
                        ),
                      );
                      if (confirm == true) {
                        await _deletePost(postId, context);
                      }
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'unset', 
                      child: Row(
                        children: [
                          Icon(Icons.remove_circle_outline, size: 16),
                          SizedBox(width: 8),
                          Text('공지 해제'),
                        ],
                      )
                    ),
                    const PopupMenuItem(
                      value: 'delete', 
                      child: Row(
                        children: [
                          Icon(Icons.delete_outline, size: 16, color: Colors.red),
                          SizedBox(width: 8),
                          Text('공지글 삭제', style: TextStyle(color: Colors.red)),
                        ],
                      )
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
} 