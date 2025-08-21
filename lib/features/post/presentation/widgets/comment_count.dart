import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/// 게시글/댓글의 댓글 수 표시 위젯
///
/// - Firestore에서 postId로 댓글 개수를 실시간 조회
/// - 컬러/문구/패딩 등은 core/constants로 상수화 권장
class CommentCount extends StatelessWidget {
  /// 게시글 ID
  final String postId;
  /// 생성자
  const CommentCount({required this.postId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('comments')
          .where('postId', isEqualTo: postId)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return const SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(strokeWidth: 2),
          );
        final int count = snapshot.data!.docs.length;
        return Text(
          '$count',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.normal,
          ),
        );
      },
    );
  }
}
