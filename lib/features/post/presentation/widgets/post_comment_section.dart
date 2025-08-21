import 'package:flutter/material.dart';

/// 게시글 댓글 섹션 위젯
class PostCommentSection extends StatelessWidget {
  final String postId;
  final String? editCommentId;
  final String? editContent;
  final void Function(String, String) onEditComment;
  final VoidCallback onEditDone;
  const PostCommentSection({super.key, required this.postId, this.editCommentId, this.editContent, required this.onEditComment, required this.onEditDone});

  @override
  Widget build(BuildContext context) {
    // 실제 댓글 리스트+입력 UI 코드 분리 구현
    // ...
    return Container(); // TODO: 실제 UI 코드로 대체
  }
} 