import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'like_button.dart';
import 'package:uuid/uuid.dart';

/// 댓글의 수정/삭제/신고 콜백 타입
typedef OnEditComment = void Function(String commentId, String content);

/// 게시글의 댓글 리스트 위젯
///
/// - Firestore에서 postId로 댓글 실시간 조회
/// - Provider/DI 구조로 개선 권장
/// - 컬러/문구/패딩 등은 core/constants로 상수화 권장
class CommentList extends StatelessWidget {
  /// 게시글 ID
  final String postId;
  /// 댓글 수정 콜백
  final OnEditComment? onEdit;
  /// 리스트 뷰 밀집 여부
  final bool dense;
  /// 외부 스크롤 컨트롤러
  final ScrollController? scrollController;
  /// 생성자
  const CommentList({super.key, required this.postId, this.onEdit, this.dense = false, this.scrollController});

  /// 관리자/작성자 권한 확인
  /// [c] : 댓글 데이터
  /// [uid] : 현재 유저 UID
  /// [userType] : 유저 타입
  /// return : 수정/삭제 가능 여부
  bool _isAdminOrOwner(Map<String, dynamic> c, String? uid, String? userType) {
    return c['authorId'] == uid || (userType == 'admin' || userType == 'developer');
  }

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final String? uid = user?.uid;
    // 관리자 권한 확인(간단 예시)
    final userType = null; // TODO: Provider 등에서 현재 유저 타입 받아오기

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('comments')
          .where('postId', isEqualTo: postId)
          .orderBy('createdAt', descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('댓글이 없습니다.'));
        }
        final List<QueryDocumentSnapshot<Map<String, dynamic>>> comments = snapshot.data!.docs;
        return ListView.separated(
          controller: scrollController,
          itemCount: comments.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, idx) {
            final doc = comments[idx];
            final Map<String, dynamic> c = doc.data();
            final bool isOwnerOrAdmin = _isAdminOrOwner(c, uid, userType);
            return ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: dense ? 4 : 16, vertical: dense ? 2 : 8),
              minVerticalPadding: dense ? 0 : null,
              leading: CircleAvatar(
                radius: dense ? 12 : 18,
                backgroundImage: c['authorProfileUrl'] != null && c['authorProfileUrl'] != ''
                    ? NetworkImage(c['authorProfileUrl'])
                    : const AssetImage('assets/images/default_profile.png') as ImageProvider,
              ),
              title: Row(
                children: [
                  Text(
                    c['authorNickname'] ?? '',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: dense ? 12 : 14),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    c['createdAt'] != null ? (c['createdAt'] as Timestamp).toDate().toString().substring(5, 16) : '',
                    style: TextStyle(fontSize: dense ? 10 : 12, color: Colors.grey),
                  ),
                ],
              ),
              subtitle: Text(
                c['content'] ?? '',
                style: TextStyle(fontSize: dense ? 12 : 14),
                maxLines: dense ? 2 : null,
                overflow: dense ? TextOverflow.ellipsis : null,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  LikeButton(
                    postId: doc.id,
                    likes: List<String>.from(c['likes'] ?? []),
                    likesCount: c['likesCount'] ?? 0,
                    isComment: true,
                  ),
                  PopupMenuButton<String>(
                    onSelected: (value) async {
                      if (value == 'edit' && onEdit != null) {
                        onEdit!(doc.id, c['content'] ?? '');
                      } else if (value == 'delete') {
                        await FirebaseFirestore.instance.collection('comments').doc(doc.id).delete();
                      } else if (value == 'report') {
                        final String uuid = const Uuid().v4();
                        await FirebaseFirestore.instance.collection('admin_notifications').doc(uuid).set({
                          'id': uuid,
                          'title': '[신고] 댓글',
                          'content': '댓글ID: ${doc.id}\n내용: ${c['content'] ?? ''}\n작성자: ${c['authorNickname'] ?? ''}\n신고자: $uid',
                          'targetUserTypes': ['admin', 'developer'],
                          'sentAt': FieldValue.serverTimestamp(),
                          'createdBy': uid,
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('신고가 접수되었습니다. 관리자 검토 후 조치됩니다.')),
                        );
                      }
                    },
                    itemBuilder: (context) {
                      final List<PopupMenuEntry<String>> items = <PopupMenuEntry<String>>[];
                      if (isOwnerOrAdmin) {
                        items.add(const PopupMenuItem(value: 'edit', child: Text('수정')));
                        items.add(const PopupMenuItem(value: 'delete', child: Text('삭제')));
                      }
                      items.add(const PopupMenuItem(value: 'report', child: Text('신고')));
                      return items;
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
} 